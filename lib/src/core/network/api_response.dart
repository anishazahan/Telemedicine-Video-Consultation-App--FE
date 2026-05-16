Map<String, dynamic> asMap(Object? value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return <String, dynamic>{};
}

List<dynamic> asList(Object? value) {
  if (value is List) return value;
  return const [];
}

Map<String, dynamic> responseData(Object? response) => asMap(asMap(response)['data']);

List<dynamic> responseItems(Object? response) => asList(responseData(response)['items']);

String stringValue(Object? value, [String fallback = '']) => value?.toString() ?? fallback;

double doubleValue(Object? value, [double fallback = 0]) => double.tryParse(value?.toString() ?? '') ?? fallback;

int intValue(Object? value, [int fallback = 0]) => int.tryParse(value?.toString() ?? '') ?? fallback;

DateTime dateValue(Object? value, [DateTime? fallback]) =>
    DateTime.tryParse(value?.toString() ?? '') ?? fallback ?? DateTime.now();
