import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit(super.context,super.initialState);


  void login() {
   if(state.formKey.currentState!.validate()){}
  }

  void selectAuthType(String? value) {
    emit(state.copyWith(selectedValue: value));
  }
}