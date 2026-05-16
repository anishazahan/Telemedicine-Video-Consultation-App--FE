import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../../core/storage/offline_cache.dart';
import 'doctor.dart';

final doctorRepositoryProvider = Provider<DoctorRepository>((ref) {
  return DoctorRepository(ref.watch(dioProvider), ref.watch(offlineCacheProvider));
});

final doctorsProvider = FutureProvider.family<List<Doctor>, DoctorQuery>((ref, query) {
  return ref.watch(doctorRepositoryProvider).listDoctors(query);
});

final doctorProvider = FutureProvider.family<Doctor, String>((ref, id) {
  return ref.watch(doctorRepositoryProvider).doctorById(id);
});

class DoctorQuery {
  const DoctorQuery({this.search = '', this.specialization, this.page = 1});
  final String search;
  final String? specialization;
  final int page;
}

class DoctorRepository {
  DoctorRepository(this._dio, this._cache);
  final Dio _dio;
  final OfflineCache _cache;

  Future<List<Doctor>> listDoctors(DoctorQuery query) async {
    try {
      final response = await _dio.get('/doctors', queryParameters: {
        if (query.search.isNotEmpty) 'search': query.search,
        if (query.specialization != null) 'specialization': query.specialization,
        'page': query.page,
        'limit': 12,
      });
      final items = responseItems(response.data).map<Doctor>((item) => _parseDoctor(item)).toList();
      await _cache.writeJson('doctors:last', items.map((e) => e.toJson()).toList());
      return items;
    } catch (_) {
      final cached = await _cache.readJson<List<Doctor>>(
        'doctors:last',
        (json) => asList(json).map((item) => Doctor.fromJson(asMap(item))).toList(),
      );
      return cached ?? demoDoctors;
    }
  }

  Future<Doctor> doctorById(String id) async {
    final doctors = await listDoctors(const DoctorQuery());
    return doctors.firstWhere((doctor) => doctor.id == id, orElse: () => demoDoctors.first);
  }

  Doctor _parseDoctor(Object raw) {
    final json = asMap(raw);
    final user = asMap(json['user']);
    final avatar = asMap(user['avatar']);
    return Doctor(
      id: stringValue(json['_id'] ?? json['id']),
      name: stringValue(user['name'] ?? json['name'], 'Doctor'),
      specialization: stringValue(json['specialization'], 'General Medicine'),
      consultationFee: doubleValue(json['consultationFee']),
      ratingAverage: doubleValue(json['ratingAverage']),
      experienceYears: intValue(json['experienceYears']),
      avatarUrl: avatar['url']?.toString(),
      bio: json['bio']?.toString(),
      isVerified: json['isVerified'] == true,
    );
  }
}

const demoDoctors = [
  Doctor(
    id: '1',
    name: 'Dr. Sarah Ahmed',
    specialization: 'Cardiology',
    consultationFee: 85,
    ratingAverage: 4.9,
    experienceYears: 12,
    bio: 'Heart specialist focused on preventive cardiac care and long-term patient outcomes.',
    isVerified: true,
  ),
  Doctor(
    id: '2',
    name: 'Dr. Omar Rahman',
    specialization: 'Dermatology',
    consultationFee: 60,
    ratingAverage: 4.8,
    experienceYears: 9,
    bio: 'Dermatologist treating chronic skin conditions, acne, allergy and cosmetic concerns.',
    isVerified: true,
  ),
  Doctor(
    id: '3',
    name: 'Dr. Nusrat Karim',
    specialization: 'Pediatrics',
    consultationFee: 70,
    ratingAverage: 4.95,
    experienceYears: 14,
    bio: 'Pediatric consultant for newborn care, vaccination, nutrition and childhood illness.',
    isVerified: true,
  ),
];
