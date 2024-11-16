import 'dart:async';

import 'package:core/core.dart';
import 'package:country_picker/country_picker.dart';
import 'package:data/data.config.dart';
import 'package:fanofa/src/di/extension.dart';
import 'package:fanofa/src/logic/auth/register/register_cubit.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:fanofa/src/ui/auth/complete_profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static String routeName = "/register_view";

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        context,
        RegisterState(
          otpController: TextEditingController(),
          /*   nameController: TextEditingController(),
          selectedValue: "",
          passwordController: TextEditingController(),
          formKey: GlobalKey<FormState>(),
          emailController: TextEditingController(),*/
        ),
      ),
      child: const RegisterView(),
    );
  }

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with TickerProviderStateMixin {
  RegisterCubit get cubit => BlocProvider.of<RegisterCubit>(context);

  String getMaskedPhoneNumber(String phone) {
    return phone.replaceRange(2, phone.length - 2, '*' * (phone.length - 4));
  }
  late int remainingSeconds;
  Timer? timer;
  AnimationController? controller;

  Duration get duration => (controller?.duration ?? const Duration(seconds: 30)) * (controller?.value ?? 0.0);

  @override
  void initState() {
    remainingSeconds = 30;
    startTimer();

    super.initState();
  }
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
  void verifyAccountSheet(BuildContext context) {
    showBottomSheet(
      enableDrag: true,
      context: context,
      elevation: 10,
      builder: (context) {
        return Column(
          children: [
            Row(
              children: [
                CommonText.bold(
                  "Verify Account",
                  size: 24,
                  color: context.colorScheme.onSurface,
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(top: context.topPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24.0, top: 10),
                  child: CommonText.semiBold(
                    "Create account",
                    size: 28,
                  ),
                ),
                const Gap(8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: CommonText.regular(
                      "Enter your details below & free sign up"),
                ),
                const Gap(14),
                Divider(
                  color: context.colorScheme.inverseSurface,
                ),
                const Gap(25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.medium(
                        "Full Name *",
                        color: context.colorScheme.tertiary,
                        size: 14,
                      ),
                      const CommonTextField(),
                      const Gap(21),
                      CommonText.medium(
                        "Phone Number *",
                        color: context.colorScheme.tertiary,
                        size: 14,
                      ),
                      MobileNumberField(
                        country: state.country ??
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
                          cubit.countrySelect(country, context);

                          print("country:: ${country.displayName}");
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 24, vertical: context.bottomPadding + 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: state.isSelect,
                      onChanged: (value) {
                        cubit.isSelect(value ?? true);
                      },
                      activeColor: context.colorScheme.primary,
                    ),
                    //  const Gap(7.5),
                    Expanded(
                      child: CommonText.regular(
                        "By creating an account you have to agree with our them & condition.",
                        color: context.colorScheme.tertiary,
                        size: 12,
                      ),
                    ),
                  ],
                ),
                const Gap(11),
                PrimaryButton(
                  onPressed: () {
                    context.navigator.pushNamed(CompleteProfileView.routeName);
                    /*showModalBottomSheet(
                      enableDrag: true,
                      useSafeArea: true,
                      isDismissible: false,
                      context: context,
                      isScrollControlled: false,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      )),
                      // elevation: 10,
                      builder: (context) {
                        return Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 24.0,
                                right: 24.0,
                                top: 24.0,
                                bottom: context.bottomInset + 24),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonText.bold(
                                        "Verify Account",
                                        size: 24,
                                        color: context.colorScheme.onSurface,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context.navigator.pop();
                                        },
                                        child: const SvgImageFromAsset(
                                            AppIcons.close),
                                      )
                                    ],
                                  ),
                                  const Gap(24),
                                  const CommonText.semiBold(
                                    "Phone OTP",
                                    size: 14,
                                  ),
                                  const Gap(5),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'Enter the 6-digit verification code sent to ',
                                          style: TextStyle(
                                            color: context.colorScheme.tertiary,
                                            fontFamily: AppTheme.kFontFamily,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                        TextSpan(
                                          text: getMaskedPhoneNumber(
                                              "9876543210"),
                                          style: TextStyle(
                                            color: context.colorScheme.tertiary,
                                            fontFamily: AppTheme.kFontFamily,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(16.51),
                                  OtpInputField(
                                    controller: state.otpController,
                                    length: 6,
                                    *//*  onChanged: (value) {
                                      print("Changed: $value");
                                    },
                                    onCompleted: (value) {
                                      print("Completed: $value");
                                    },*//*
                                    validator: (value) {
                                      if (value == null || value.length < 6) {
                                        return 'Please enter all 6 digits';
                                      }
                                      return null;
                                    },
                                  ),
                                  const Gap(16.76),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                       *//* height: 21,
                                        width: 88,*//*
                                        padding: const EdgeInsets.symmetric(horizontal: 19.81,vertical: 4.92,),
                                        decoration: BoxDecoration(
                                          color: context
                                              .colorScheme.onSurfaceVariant,
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        child: Row(
                                          children: [
                                            const SvgImageFromAsset(
                                              AppIcons.watchIcon,
                                              height: 12.15,
                                              width: 12.15,
                                            ),
                                            const Gap(3.83),
                                            CommonText.regular(
                                              "$remainingSeconds Sec",
                                              color: context.colorScheme
                                                  .tertiaryContainer,
                                              size: 10.21,
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                              'Didn’t receive the code!',
                                              style: TextStyle(
                                                color: context.colorScheme.outline,
                                                fontFamily: AppTheme.kFontFamily,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                decoration: TextDecoration.underline,
                                                decorationColor: context.colorScheme.outline,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " Resend",
                                              recognizer: TapGestureRecognizer()..onTap = (){

                                              },
                                              style: TextStyle(
                                                color: context.colorScheme.primary,
                                                fontFamily: AppTheme.kFontFamily,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                decoration: TextDecoration.underline,
                                                decorationColor: context.colorScheme.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(24),
                                  PrimaryButton(
                                    onPressed: () {},
                                    label: "Continue",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );*/
                    //verifyAccountSheet(context);
                  },
                  label: "Verify with OTP",
                ),
                const Gap(7.17),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText.regular(
                      "Already have an account",
                      color: context.colorScheme.tertiary,
                      size: 12,
                    ),
                    CommonText.bold(
                      "Log in",
                      color: context.colorScheme.onSecondary,
                      size: 12,
                      decoration: TextDecoration.underline,
                      decorationColor: context.colorScheme.onSecondary,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
