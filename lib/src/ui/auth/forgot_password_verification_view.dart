import 'package:core/core.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/src/gradient_colors.dart';
import 'package:fanofa/src/ui/auth/reset_password_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../packages/resouces/src/icons.dart';
import '../../packages/resouces/src/theme/theme.dart';

class ForgotPasswordVerificationView extends StatefulWidget {
  const ForgotPasswordVerificationView({super.key});

  static String routeName = "/complete_profile_verification_view";

  static Widget builder(BuildContext context) {
    return const ForgotPasswordVerificationView();
  }

  @override
  State<ForgotPasswordVerificationView> createState() =>
      _ForgotPasswordVerificationViewState();
}

class _ForgotPasswordVerificationViewState
    extends State<ForgotPasswordVerificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(18),
            const CommonText.semiBold(
              "Check your email",
              size: 18,
            ),
            const Gap(7),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'We sent a reset link to',
                    style: TextStyle(
                      color: context.colorScheme.surfaceTint,
                      fontFamily: AppTheme.kFontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: " contact@yahoo.com",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: TextStyle(
                      color: context.colorScheme.surfaceTint,
                      fontFamily: AppTheme.kFontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: ' enter 5 digit code that mentioned in the email',
                    style: TextStyle(
                      color: context.colorScheme.surfaceTint,
                      fontFamily: AppTheme.kFontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
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
                context.navigator.pushNamed(ResetPasswordView.routeName);
              },
              label: "Verify Code",
              gradient: AppGradients.of(context).disabledButton,
            ),
            const Gap(20),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Haven’t got the email yet?',
                      style: TextStyle(
                        color: context.colorScheme.surfaceTint,
                        fontFamily: AppTheme.kFontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: " Resend email",
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      style: TextStyle(
                        color: context.colorScheme.primary,
                        fontFamily: AppTheme.kFontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
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
