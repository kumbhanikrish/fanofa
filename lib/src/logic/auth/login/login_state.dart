part of 'login_cubit.dart';

class LoginState extends Equatable {
  final TextEditingController nameController;

  final TextEditingController emailController;

  final TextEditingController passwordController;

  final GlobalKey<FormState> formKey;

  final String selectedValue;

  const LoginState({
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.formKey,
    required this.selectedValue,
  });

  @override
  List<Object?> get props => [];

  LoginState copyWith({
    TextEditingController? emailController,
    TextEditingController? nameController,
    TextEditingController? passwordController,
    GlobalKey<FormState>? formKey,
    String? selectedValue,
  }) =>
      LoginState(
        emailController: emailController ?? this.emailController,
        nameController: nameController ?? this.nameController,
        passwordController: passwordController ?? this.passwordController,
        formKey: formKey ?? this.formKey,
        selectedValue: selectedValue ?? this.selectedValue,
      );
}
