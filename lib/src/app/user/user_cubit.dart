import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends BaseCubit<UserState> {
  UserCubit(super.context, super.initialState);

  static UserCubit of(BuildContext context, [bool listen = false]) {
    return BlocProvider.of<UserCubit>(context, listen: listen);
  }

  @override
  void onCreate() {
    super.onCreate();
  }

/*  Future<void> _clearUserData() async {
    await Future.wait([
      pref.clear(),
    ]);
  }

  Future<void> userUnauthorized() async {
    emit(UserState());
    await _clearUserData();
  }*/

}
