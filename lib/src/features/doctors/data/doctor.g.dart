// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Doctor _$DoctorFromJson(Map<String, dynamic> json) => _Doctor(
  id: json['id'] as String,
  name: json['name'] as String,
  specialization: json['specialization'] as String,
  consultationFee: (json['consultationFee'] as num).toDouble(),
  ratingAverage: (json['ratingAverage'] as num?)?.toDouble() ?? 0,
  experienceYears: (json['experienceYears'] as num?)?.toInt() ?? 0,
  avatarUrl: json['avatarUrl'] as String?,
  bio: json['bio'] as String?,
  isVerified: json['isVerified'] as bool? ?? false,
);

Map<String, dynamic> _$DoctorToJson(_Doctor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'specialization': instance.specialization,
  'consultationFee': instance.consultationFee,
  'ratingAverage': instance.ratingAverage,
  'experienceYears': instance.experienceYears,
  'avatarUrl': instance.avatarUrl,
  'bio': instance.bio,
  'isVerified': instance.isVerified,
};
