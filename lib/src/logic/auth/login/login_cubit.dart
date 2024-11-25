import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit(super.context, super.initialState);

  late final AuthRepository _authRepository =
      RepositoryProvider.of<AuthRepository>(context);

  void login() {
    if (state.formKey.currentState!.validate()) {
   /*   processData(
        _authRepository.login(
            fullName: "Dharmesh Gevariya", phoneNumber: "+918469665842"),
        onSuccess: (data) {
          print("data:: $data");
        },
      );*/
    }
  }

  void selectAuthType(String? value) {
    emit(state.copyWith(selectedValue: value));
  }
}
