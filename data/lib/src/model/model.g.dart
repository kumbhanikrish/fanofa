// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistration _$UserRegistrationFromJson(Map<String, dynamic> json) =>
    UserRegistration(
      socialType: (json['social_type'] as num?)?.toInt(),
      socialId: json['social_id'] as String? ?? "",
      firstName: json['first_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      token: json['token'] as String? ?? "",
      deviceToken: json['device_token'] as String? ?? "",
    );

Map<String, dynamic> _$UserRegistrationToJson(UserRegistration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('social_type', instance.socialType);
  val['social_id'] = instance.socialId;
  val['first_name'] = instance.firstName;
  val['email'] = instance.email;
  val['password'] = instance.password;
  val['token'] = instance.token;
  val['device_token'] = instance.deviceToken;
  return val;
}
