import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

class TokenStorage {
  static const _access = 'access_token';
  static const _refresh = 'refresh_token';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> readAccessToken() => _storage.read(key: _access);
  Future<String?> readRefreshToken() => _storage.read(key: _refresh);

  Future<void> save({required String accessToken, required String refreshToken}) async {
    await _storage.write(key: _access, value: accessToken);
    await _storage.write(key: _refresh, value: refreshToken);
  }

  Future<void> clear() => _storage.deleteAll();
}
