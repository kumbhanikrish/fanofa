import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends BaseCubit<CompleteProfileState> {
  CompleteProfileCubit(super.context, super.initialState);

  @override
  void onCreate() {
    super.onCreate();
    emit(
      state.copyWith(
        ageList: [
          "Below 20",
          "21-40",
          "41-60",
          "60+",
        ],
      ),
    );
  }

  void incrementStep() {
    if (state.currentStep < state.totalSteps) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void decrement() {
    if (state.currentStep > 1) {
      emit(state.copyWith(currentStep: state.currentStep-1));
    }
  }

  void handleGenderChange(String? value) {
    emit(state.copyWith(selectedGender: value));
  }

  void handleAgeChange(String? value) {
    emit(state.copyWith(selectedAge: value));
  }
}
