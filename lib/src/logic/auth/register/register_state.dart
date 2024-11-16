part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final Country? country;
  final bool? isSelect;
  final TextEditingController otpController;

  const RegisterState({
    this.country,
    this.isSelect = false,
    required this.otpController,
  });

  @override
  List<Object?> get props => [country,isSelect,otpController];

  RegisterState copyWith({
    Country? country,
    bool? isSelect,
    TextEditingController? otpController,
  }) =>
      RegisterState(
        country: country ?? this.country,
        isSelect: isSelect ?? this.isSelect,
        otpController: otpController ?? this.otpController,
      );
}
