import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final offlineCacheProvider = Provider<OfflineCache>((ref) => OfflineCache());

class OfflineCache {
  Future<void> writeJson(String key, Object value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(value));
  }

  Future<T?> readJson<T>(String key, T Function(Object? json) parser) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return null;
    return parser(jsonDecode(raw));
  }
}
