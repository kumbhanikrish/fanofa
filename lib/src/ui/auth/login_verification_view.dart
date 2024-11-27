import 'package:core/core.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fanofa/src/assets_path/assets_icons.dart';
import 'package:fanofa/src/logic/auth/login/login_cubit.dart';
import 'package:fanofa/src/logic/auth/register/register_cubit.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:fanofa/src/packages/resouces/src/gradient_colors.dart';
import 'package:fanofa/src/ui/auth/reset_password_view.dart';
import 'package:fanofa/src/ui/auth/your_location_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginVerificationView extends StatefulWidget {
  const LoginVerificationView({super.key});

  static String routeName = "/login_verification_view";

  static Widget builder(BuildContext context) {
    return const LoginVerificationView();
  }

  @override
  State<LoginVerificationView> createState() => _LoginVerificationViewState();
}

class _LoginVerificationViewState extends State<LoginVerificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        centerTitle: true,
        title: CommonText.semiBold(
          "Verify Phone",
          size: 28,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(30),
            CommonText.semiBold(
              "Enter the 4-digit verification code sent to 68********786",
              textAlign: TextAlign.center,
              size: 14,
              color: context.colorScheme.tertiary,
            ),
            const Gap(22),
            OtpInputField(
              controller: TextEditingController(),
              length: 6,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'Please enter all 6 digits';
                }
                return null;
              },
            ),
            const Gap(38),
            PrimaryButton(
              onPressed: () {
                context.navigator.pushNamed(YourLocationView.routeName);
              },
              label: "Verify Code",
            ),
            const Gap(20),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Didn’t receive the code!',
                      style: TextStyle(
                        color: context.colorScheme.tertiary,
                        fontFamily: AppTheme.kFontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: " Resend",
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      style: TextStyle(
                        color: context.colorScheme.primary,
                        fontFamily: AppTheme.kFontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationColor: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
