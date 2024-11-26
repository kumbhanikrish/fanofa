import 'package:core/core.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fanofa/src/assets_path/assets_icons.dart';
import 'package:fanofa/src/logic/auth/login/login_cubit.dart';
import 'package:fanofa/src/logic/auth/register/register_cubit.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:fanofa/src/ui/auth/login_verification_view.dart';
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

  String getMaskedPhoneNumber(String phone) {
    return phone.replaceRange(2, phone.length - 2, '*' * (phone.length - 4));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: context.topPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24.0, top: 10),
              child: CommonText.semiBold(
                "Hie 👋 Welcome",
                size: 28,
              ),
            ),
            const Gap(8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: CommonText.regular(
                "Enter your phone number for login to the account.",
              ),
            ),
            const Gap(14),
            Divider(
              color: context.colorScheme.inverseSurface,
            ),
            const Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CommonText.medium(
                    "Phone Number *",
                    color: context.colorScheme.tertiary,
                    size: 14,
                  ),
                  MobileNumberField(
                    country:

                        // state.country ??
                        Country(
                      phoneCode: "1",
                      countryCode: "CA",
                      e164Sc: 0,
                      geographic: true,
                      level: 1,
                      name: "Canada",
                      example: "4161234567",
                      displayName: "Canada (+1)",
                      displayNameNoCountryCode: "Canada",
                      e164Key: "CA+1",
                    ),
                    onCountrySelected: (country) {
                      // cubit.countrySelect(country, context);

                      print("country:: ${country.displayName}");
                    },
                  ),
                  Gap(29),
                  PrimaryButton(
                    onPressed: () {
                      context.navigator
                          .pushNamed(LoginVerificationView.routeName);
                    },
                    label: "Request OTP",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 24, vertical: context.bottomPadding + 10),
        child: Wrap(
          children: [
            CommonText.regular(
              "By signing in, you are agreeing to our terms listed in",
              color: context.colorScheme.tertiary,
              size: 12,
            ),
            Row(
              children: [
                CommonText.regular(
                  "the",
                  color: context.colorScheme.tertiary,
                  size: 12,
                ),
                CommonText.regular(
                  " Legal information section",
                  color: context.colorScheme.onSecondary,
                  size: 12,
                ),
                CommonText.regular(
                  " and our",
                  color: context.colorScheme.tertiary,
                  size: 12,
                ),
                CommonText.regular(
                  " Privacy Notice.x",
                  color: context.colorScheme.onSecondary,
                  size: 12,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
