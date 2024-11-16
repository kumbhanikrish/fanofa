part of 'model.dart';

@JsonSerializable()
class UserRegistration extends Equatable {
  final int? socialType;
  final String socialId;
  final String firstName;
  final String email;
  final String password;
  final String token;
  final String deviceToken;

  const UserRegistration({
    this.socialType,
    this.socialId = "",
    required this.firstName,
    required this.email,
    required this.password,
    this.token = "",
    this.deviceToken = "",
  });

  factory UserRegistration.fromJson(JsonMap json) => _$UserRegistrationFromJson(json);

  JsonMap toJson() => _$UserRegistrationToJson(this);

  @override
  List<Object?> get props => [
        socialType,
        socialId,
        firstName,
        email,
        password,
        token,
        deviceToken,
      ];

  UserRegistration copyWith({
    int? socialType,
    String? socialId,
    String? firstName,
    String? email,
    String? password,
    String? token,
    String? deviceToken,
  }) {
    return UserRegistration(
      socialType: socialType ?? this.socialType,
      socialId: socialId ?? this.socialId,
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      deviceToken: deviceToken ?? this.deviceToken,
    );
  }
}
