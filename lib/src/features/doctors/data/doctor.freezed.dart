// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Doctor {

 String get id; String get name; String get specialization; double get consultationFee; double get ratingAverage; int get experienceYears; String? get avatarUrl; String? get bio; bool get isVerified;
/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorCopyWith<Doctor> get copyWith => _$DoctorCopyWithImpl<Doctor>(this as Doctor, _$identity);

  /// Serializes this Doctor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Doctor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.specialization, specialization) || other.specialization == specialization)&&(identical(other.consultationFee, consultationFee) || other.consultationFee == consultationFee)&&(identical(other.ratingAverage, ratingAverage) || other.ratingAverage == ratingAverage)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,specialization,consultationFee,ratingAverage,experienceYears,avatarUrl,bio,isVerified);

@override
String toString() {
  return 'Doctor(id: $id, name: $name, specialization: $specialization, consultationFee: $consultationFee, ratingAverage: $ratingAverage, experienceYears: $experienceYears, avatarUrl: $avatarUrl, bio: $bio, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class $DoctorCopyWith<$Res>  {
  factory $DoctorCopyWith(Doctor value, $Res Function(Doctor) _then) = _$DoctorCopyWithImpl;
@useResult
$Res call({
 String id, String name, String specialization, double consultationFee, double ratingAverage, int experienceYears, String? avatarUrl, String? bio, bool isVerified
});




}
/// @nodoc
class _$DoctorCopyWithImpl<$Res>
    implements $DoctorCopyWith<$Res> {
  _$DoctorCopyWithImpl(this._self, this._then);

  final Doctor _self;
  final $Res Function(Doctor) _then;

/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? specialization = null,Object? consultationFee = null,Object? ratingAverage = null,Object? experienceYears = null,Object? avatarUrl = freezed,Object? bio = freezed,Object? isVerified = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,specialization: null == specialization ? _self.specialization : specialization // ignore: cast_nullable_to_non_nullable
as String,consultationFee: null == consultationFee ? _self.consultationFee : consultationFee // ignore: cast_nullable_to_non_nullable
as double,ratingAverage: null == ratingAverage ? _self.ratingAverage : ratingAverage // ignore: cast_nullable_to_non_nullable
as double,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Doctor].
extension DoctorPatterns on Doctor {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Doctor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Doctor() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Doctor value)  $default,){
final _that = this;
switch (_that) {
case _Doctor():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Doctor value)?  $default,){
final _that = this;
switch (_that) {
case _Doctor() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String specialization,  double consultationFee,  double ratingAverage,  int experienceYears,  String? avatarUrl,  String? bio,  bool isVerified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Doctor() when $default != null:
return $default(_that.id,_that.name,_that.specialization,_that.consultationFee,_that.ratingAverage,_that.experienceYears,_that.avatarUrl,_that.bio,_that.isVerified);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String specialization,  double consultationFee,  double ratingAverage,  int experienceYears,  String? avatarUrl,  String? bio,  bool isVerified)  $default,) {final _that = this;
switch (_that) {
case _Doctor():
return $default(_that.id,_that.name,_that.specialization,_that.consultationFee,_that.ratingAverage,_that.experienceYears,_that.avatarUrl,_that.bio,_that.isVerified);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String specialization,  double consultationFee,  double ratingAverage,  int experienceYears,  String? avatarUrl,  String? bio,  bool isVerified)?  $default,) {final _that = this;
switch (_that) {
case _Doctor() when $default != null:
return $default(_that.id,_that.name,_that.specialization,_that.consultationFee,_that.ratingAverage,_that.experienceYears,_that.avatarUrl,_that.bio,_that.isVerified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Doctor implements Doctor {
  const _Doctor({required this.id, required this.name, required this.specialization, required this.consultationFee, this.ratingAverage = 0, this.experienceYears = 0, this.avatarUrl, this.bio, this.isVerified = false});
  factory _Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

@override final  String id;
@override final  String name;
@override final  String specialization;
@override final  double consultationFee;
@override@JsonKey() final  double ratingAverage;
@override@JsonKey() final  int experienceYears;
@override final  String? avatarUrl;
@override final  String? bio;
@override@JsonKey() final  bool isVerified;

/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoctorCopyWith<_Doctor> get copyWith => __$DoctorCopyWithImpl<_Doctor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoctorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Doctor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.specialization, specialization) || other.specialization == specialization)&&(identical(other.consultationFee, consultationFee) || other.consultationFee == consultationFee)&&(identical(other.ratingAverage, ratingAverage) || other.ratingAverage == ratingAverage)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,specialization,consultationFee,ratingAverage,experienceYears,avatarUrl,bio,isVerified);

@override
String toString() {
  return 'Doctor(id: $id, name: $name, specialization: $specialization, consultationFee: $consultationFee, ratingAverage: $ratingAverage, experienceYears: $experienceYears, avatarUrl: $avatarUrl, bio: $bio, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class _$DoctorCopyWith<$Res> implements $DoctorCopyWith<$Res> {
  factory _$DoctorCopyWith(_Doctor value, $Res Function(_Doctor) _then) = __$DoctorCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String specialization, double consultationFee, double ratingAverage, int experienceYears, String? avatarUrl, String? bio, bool isVerified
});




}
/// @nodoc
class __$DoctorCopyWithImpl<$Res>
    implements _$DoctorCopyWith<$Res> {
  __$DoctorCopyWithImpl(this._self, this._then);

  final _Doctor _self;
  final $Res Function(_Doctor) _then;

/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? specialization = null,Object? consultationFee = null,Object? ratingAverage = null,Object? experienceYears = null,Object? avatarUrl = freezed,Object? bio = freezed,Object? isVerified = null,}) {
  return _then(_Doctor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,specialization: null == specialization ? _self.specialization : specialization // ignore: cast_nullable_to_non_nullable
as String,consultationFee: null == consultationFee ? _self.consultationFee : consultationFee // ignore: cast_nullable_to_non_nullable
as double,ratingAverage: null == ratingAverage ? _self.ratingAverage : ratingAverage // ignore: cast_nullable_to_non_nullable
as double,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
