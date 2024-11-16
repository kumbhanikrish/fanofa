import 'package:fanofa/src/assets_path/assets_icons.dart';
import 'package:fanofa/src/logic/auth/login/login_cubit.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static String routeName = "/login_view";

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        context,
        LoginState(
          nameController: TextEditingController(),
          selectedValue: "",
          passwordController: TextEditingController(),
          formKey: GlobalKey<FormState>(),
          emailController: TextEditingController(),
        ),
      ),
      child: const LoginView(),
    );
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonText.semiBold("dg")
        ],
      ),

    );
  }
}
