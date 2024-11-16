part of 'complete_profile_cubit.dart';

class CompleteProfileState extends Equatable {
  int currentStep;
  String selectedGender;
  String selectedAge;
  final int totalSteps;
  List<String> ageList;

  CompleteProfileState(
      {this.currentStep = 1,
      this.totalSteps = 2,
      this.selectedGender = "",
      this.ageList = const [],
      this.selectedAge = ""});

  @override
  List<Object?> get props => [
        currentStep,
        totalSteps,
        selectedGender,
        selectedAge,
        ageList,
      ];

  CompleteProfileState copyWith({
    int? currentStep,
    int? totalSteps,
    String? selectedGender,
    String? selectedAge,
    List<String>?  ageList,
  }) =>
      CompleteProfileState(
        currentStep: currentStep ?? this.currentStep,
        totalSteps: totalSteps ?? this.totalSteps,
        selectedGender: selectedGender ?? this.selectedGender,
        selectedAge: selectedAge ?? this.selectedAge,
        ageList: ageList ?? this.ageList,
      );
}
