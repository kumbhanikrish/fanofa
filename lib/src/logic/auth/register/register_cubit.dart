import 'package:core/core.dart';
import 'package:country_picker/country_picker.dart';
import 'package:data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:fanofa/src/packages/components/src/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/src/loader.dart';
part 'register_state.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit(super.context, super.initialState);

  late final AuthRepository _authRepository =
      RepositoryProvider.of<AuthRepository>(context);

  void countrySelect(Country country, BuildContext context) {
    emit(state.copyWith(country: country));
  }

  void isSelect(bool value) {
    emit(state.copyWith(isSelect: value));
  }

  void register() {
    LoadingDialog();
    processData(
      _authRepository.register(
          fullName: "Dharmesh Gevariya", phoneNumber: "+918469665842"),
     // handleLoading: false,
      onSuccess: (data) {
        print("data:: $data");
      },
    );
  }
}
