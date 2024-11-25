import 'package:core/core.dart';
import 'package:fanofa/src/logic/auth/forgot_password/forgot_password_email/forgot_password_email_state.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:fanofa/src/packages/resouces/src/gradient_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'forgot_password_verification_view.dart';

class ForgotPasswordEmailView extends StatefulWidget {
  const ForgotPasswordEmailView({super.key});

  static String routeName = "/forgot_password_email_view";

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordEmailCubit(
        context,
        ForgotPasswordEmailState(
            /*   nameController: TextEditingController(),
          selectedValue: "",
          passwordController: TextEditingController(),
          formKey: GlobalKey<FormState>(),
          emailController: TextEditingController(),*/
            ),
      ),
      child: const ForgotPasswordEmailView(),
    );
  }

  @override
  State<ForgotPasswordEmailView> createState() =>
      _ForgotPasswordEmailViewState();
}

class _ForgotPasswordEmailViewState extends State<ForgotPasswordEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(18),
            CommonText.semiBold(
              "Forgot password",
              size: 18,
            ),
            Gap(7),
            CommonText.regular("Please enter your email to reset the password"),
            const Gap(29),
            CommonText.medium(
              "Enter Email *",
              color: context.colorScheme.tertiary,
              size: 14,
            ),
            const Gap(5),
            const CommonTextField(
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: SvgImageFromAsset(AppIcons.close,height: 10,width: 10,),
              ),
            ),
            Gap(29),
            PrimaryButton(
              onPressed: () {
                context.navigator.pushNamed(ForgotPasswordVerificationView.routeName);
              },
              label: "Reset Password",
              gradient: AppGradients.of(context).disabledButton,
            ),
          ],
        ),
      ),
    );
  }
}
