import 'package:core/core.dart';
import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'register_state.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit(super.context, super.initialState);

  void countrySelect(Country country,BuildContext context) {
    emit(state.copyWith(country: country));
  }

  void isSelect(bool value) {
    emit(state.copyWith(isSelect: value));
  }
}
