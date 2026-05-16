import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiBaseUrl =>
      const String.fromEnvironment('API_BASE_URL').isNotEmpty
          ? const String.fromEnvironment('API_BASE_URL')
          : dotenv.maybeGet('API_BASE_URL', fallback: 'http://localhost:5000/api/v1') ?? 'http://localhost:5000/api/v1';

  static String get socketUrl =>
      const String.fromEnvironment('SOCKET_URL').isNotEmpty
          ? const String.fromEnvironment('SOCKET_URL')
          : dotenv.maybeGet('SOCKET_URL', fallback: 'http://localhost:5000') ?? 'http://localhost:5000';
}
