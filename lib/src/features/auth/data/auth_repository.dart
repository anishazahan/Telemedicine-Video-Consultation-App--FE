import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../../core/storage/token_storage.dart';
import 'auth_models.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(dioProvider), ref.watch(tokenStorageProvider));
});

final authControllerProvider = AsyncNotifierProvider<AuthController, AppUser?>(AuthController.new);

class AuthRepository {
  AuthRepository(this._dio, this._storage);
  final Dio _dio;
  final TokenStorage _storage;

  Future<AppUser> login(String email, String password) async {
    final response = await _dio.post('/auth/login', data: {'email': email, 'password': password});
    final data = responseData(response.data);
    final tokens = _parseTokens(data['tokens']);
    await _storage.save(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken);
    return _parseUser(data['user']);
  }

  Future<AppUser> register(String name, String email, String password) async {
    final response = await _dio.post('/auth/register', data: {'name': name, 'email': email, 'password': password});
    final data = responseData(response.data);
    final tokens = _parseTokens(data['tokens']);
    await _storage.save(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken);
    return _parseUser(data['user']);
  }

  Future<AppUser?> me() async {
    final token = await _storage.readAccessToken();
    if (token == null) return null;
    final response = await _dio.get('/auth/me');
    return _parseUser(responseData(response.data)['user']);
  }

  Future<void> logout() => _storage.clear();

  AuthTokens _parseTokens(Object? raw) {
    final json = asMap(raw);
    return AuthTokens(
      accessToken: stringValue(json['accessToken']),
      refreshToken: stringValue(json['refreshToken']),
    );
  }

  AppUser _parseUser(Object? raw) {
    final json = asMap(raw);
    return AppUser(
      id: stringValue(json['_id'] ?? json['id']),
      name: stringValue(json['name'], 'Patient'),
      email: stringValue(json['email']),
      role: stringValue(json['role'], 'patient'),
      phone: json['phone']?.toString(),
      avatarUrl: asMap(json['avatar'])['url']?.toString(),
    );
  }
}

class AuthController extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() {
    return ref.watch(authRepositoryProvider).me();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(authRepositoryProvider).login(email, password));
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(authRepositoryProvider).register(name, email, password));
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }
}
