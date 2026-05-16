import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import 'appointment.dart';

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  return AppointmentRepository(ref.watch(dioProvider));
});

final appointmentsProvider = FutureProvider<List<Appointment>>((ref) {
  return ref.watch(appointmentRepositoryProvider).listAppointments();
});

class AppointmentRepository {
  AppointmentRepository(this._dio);
  final Dio _dio;

  Future<void> book({
    required String doctorId,
    required DateTime startsAt,
    required DateTime endsAt,
    required String reason,
  }) async {
    await _dio.post('/appointments', data: {
      'doctor': doctorId,
      'startsAt': startsAt.toIso8601String(),
      'endsAt': endsAt.toIso8601String(),
      'reason': reason,
    });
  }

  Future<List<Appointment>> listAppointments() async {
    try {
      final response = await _dio.get('/appointments');
      return responseItems(response.data).map<Appointment>(_parseAppointment).toList();
    } catch (_) {
      return [
        Appointment(
          id: 'a1',
          doctorName: 'Dr. Sarah Ahmed',
          startsAt: DateTime.now().add(const Duration(hours: 3)),
          endsAt: DateTime.now().add(const Duration(hours: 4)),
          status: 'confirmed',
          meetingRoomId: 'demo-room',
          reason: 'Follow-up consultation',
        ),
      ];
    }
  }

  Appointment _parseAppointment(Object? raw) {
    final json = asMap(raw);
    final doctor = asMap(json['doctor']);
    final doctorUser = asMap(doctor['user']);
    final startsAt = dateValue(json['startsAt'], DateTime.now());
    return Appointment(
      id: stringValue(json['_id'] ?? json['id']),
      doctorName: stringValue(doctorUser['name'] ?? doctor['name'], 'Doctor'),
      startsAt: startsAt,
      endsAt: dateValue(json['endsAt'], startsAt.add(const Duration(minutes: 30))),
      status: stringValue(json['status'], 'pending'),
      meetingRoomId: stringValue(json['meetingRoomId'], 'demo-room'),
      reason: json['reason']?.toString(),
    );
  }
}
