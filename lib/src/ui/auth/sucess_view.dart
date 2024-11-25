import 'package:core/core.dart';
import 'package:data/data.config.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:fanofa/src/ui/auth/forgot_password_email_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({super.key});

  static String routeName = "/success_view";

  static Widget builder(BuildContext context) {
    return const SuccessView();
  }

  @override
  State<SuccessView> createState() => _SucessViewState();
}

class _SucessViewState extends State<SuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Stack(
          children: [
            SvgImageFromAsset(
              AppIcons.successBg,
              width: context.width,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CommonText.semiBold(
                    "Woohoo!",
                    size: 40,
                  ),
                  const Gap(24),
                  const CommonText.regular(
                    "Registration complete! Get ready to have the best shopping experiences of your life.",
                    size: 14,
                    textAlign: TextAlign.center,
                  ),
                  Gap(context.height * .05),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 27.0,
          right: 27.0,
          bottom: context.bottomPadding + 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
                onPressed: () {
                  context.navigator
                      .pushNamed(ForgotPasswordEmailView.routeName);
                },
                label: "Get Started"),
          ],
        ),
      ),
    );
  }
}
