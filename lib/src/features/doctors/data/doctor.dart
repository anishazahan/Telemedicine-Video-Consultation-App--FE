import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor.freezed.dart';
part 'doctor.g.dart';

@freezed
abstract class Doctor with _$Doctor {
  const factory Doctor({
    required String id,
    required String name,
    required String specialization,
    required double consultationFee,
    @Default(0) double ratingAverage,
    @Default(0) int experienceYears,
    String? avatarUrl,
    String? bio,
    @Default(false) bool isVerified,
  }) = _Doctor;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
}
