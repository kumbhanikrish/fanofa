part of 'user_cubit.dart';

class UserState extends Equatable {
  bool isLogin;
  UserState({this.isLogin = false,});

  @override
  List<Object?> get props => [isLogin];

  UserState copyWith({
    bool? isLogin,
  }) {
    return UserState(
      isLogin: isLogin ?? this.isLogin,
    );
  }
}
