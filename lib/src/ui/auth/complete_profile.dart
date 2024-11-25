import 'package:core/core.dart';
import 'package:fanofa/src/common/horizontal_list.dart';
import 'package:fanofa/src/logic/auth/complete/complete_profile_cubit.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:fanofa/src/packages/resouces/src/gradient_colors.dart';
import 'package:fanofa/src/packages/resouces/src/theme/theme.dart';
import 'package:fanofa/src/ui/auth/sucess_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gcaptcha_v3/recaptca_config.dart';
import 'package:flutter_gcaptcha_v3/web_view.dart';
import 'package:flutter_recaptcha_v2_compat/recaptcha_v2.dart';
import 'package:gap/gap.dart';
import 'package:flutter_recaptcha_v2_compat/flutter_recaptcha_v2_compat.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  static String routeName = "/complete_profile_view";

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteProfileCubit(
        context,
        CompleteProfileState(
            /*   nameController: TextEditingController(),
          selectedValue: "",
          passwordController: TextEditingController(),
          formKey: GlobalKey<FormState>(),
          emailController: TextEditingController(),*/
            ),
      ),
      child: const CompleteProfileView(),
    );
  }

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView>
    with SingleTickerProviderStateMixin {
  CompleteProfileCubit get cubit =>
      BlocProvider.of<CompleteProfileCubit>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
        builder: (context, state) {
          double progress = state.currentStep / state.totalSteps;
          print(progress);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Gap(context.topPadding + 20),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Step ${state.currentStep}',
                              style: TextStyle(
                                color: context.colorScheme.primary,
                                fontFamily: AppTheme.kFontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: " of ${state.totalSteps}",
                              style: TextStyle(
                                color: context.colorScheme.onInverseSurface,
                                fontFamily: AppTheme.kFontFamily,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(5.78),
                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 24),
                    child: Container(
                      height: 3.8,
                      decoration: BoxDecoration(
                        gradient: AppGradients.of(context).enabledButton,
                        borderRadius: BorderRadius.circular(18.98),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.98),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 3.8,
                          backgroundColor: context.colorScheme.shadow,
                          // color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const Gap(39.42),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                        child: CommonText.semiBold(
                          state.currentStep == 1
                              ? "Complete your account"
                              : "Country/region and Language",
                          size: 18,
                        ),
                      ),
                      const Gap(7),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                        child: CommonText.regular(
                          state.currentStep == 1
                              ? "Enter your details below"
                              : "Which country/region and language do you want to shop in?",
                          size: 12,
                        ),
                      ),
                      const Gap(9.49),
                      if (state.currentStep == 1) ...[
                        const Divider(),
                      ],
                      const Gap(21.44),
                      state.currentStep == 1
                          ? _step1()
                          : _step2(),
                    ],
                  ),
                ),
              ),

              /* state.currentStep == 1 ?
             _step1() : _step1(),*/
            ],
          );
        },
      ),
    );
  }

  Widget _buildRadioOption(String gender) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              value: gender,
              groupValue: state.selectedGender,
              onChanged: (value) {
                cubit.handleGenderChange(value);
              },
              activeColor: Colors.blue,
            ),
            const Gap(5.33),
            CommonText.regular(
              gender,
              size: 14,
            ),
          ],
        );
      },
    );
  }

  Widget _step1() {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.95),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.medium(
                "Phone Number *",
                color: context.colorScheme.tertiary,
                size: 14,
              ),
              const Gap(8),
              const Padding(
                padding: EdgeInsets.only(left: 7.0),
                child: PasswordField(),
              ),
              const Gap(21),
              CommonText.medium(
                "Confirm Password *",
                color: context.colorScheme.tertiary,
                size: 14,
              ),
              const Gap(8),
              const Padding(
                padding: EdgeInsets.only(left: 7.0),
                child: PasswordField(),
              ),
              const Gap(20),
              CommonText.medium(
                "Gender *",
                color: context.colorScheme.tertiary,
                size: 14,
              ),
              const Gap(11),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRadioOption("Male"),
                  _buildRadioOption("Female"),
                  _buildRadioOption("Others"),
                ],
              ),
              const Gap(37.77),
              CommonText.medium(
                "Age *",
                color: context.colorScheme.tertiary,
                size: 14,
              ),
              const Gap(11),
              HorizontalList(
                padding: EdgeInsets.zero,
                itemCount: state.ageList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      cubit.handleAgeChange(state.ageList[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.5,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        gradient: state.selectedAge == state.ageList[index]
                            ? AppGradients.of(context).enabledButton
                            : null,
                        borderRadius: BorderRadius.circular(6),
                        border: state.selectedAge != state.ageList[index]
                            ? Border.all(
                                color: context.colorScheme.inverseSurface,
                                width: 1,
                              )
                            : null,
                      ),
                      child: CommonText.regular(
                        state.ageList[index],
                        size: 14,
                        color: state.selectedAge == state.ageList[index]
                            ? context.colorScheme.surface
                            : context.colorScheme.surfaceTint,
                      ),
                    ),
                  );
                },
              ),
              const Gap(21),
              CommonText.medium(
                "Email *",
                color: context.colorScheme.tertiary,
                size: 14,
              ),
              const Gap(5),
              const CommonTextField(),
              const Gap(40.49),
              PrimaryButton(
                onPressed: () {
                  cubit.incrementStep();
                },
                label: "Continue",
              ),
              const Gap(21),
              GestureDetector(
                onTap: () {
                  cubit.decrement();
                },
                child: Center(
                  child: CommonText.regular(
                    "Back",
                    textAlign: TextAlign.center,
                    decoration: TextDecoration.underline,
                    decorationColor: context.colorScheme.surfaceTint,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _step2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.95),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.medium(
            "Country *",
            color: context.colorScheme.tertiary,
            size: 14,
          ),
          const Gap(4),
          const CommonTextField(
            readOnly: true,
            hintText: "Country",
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SvgImageFromAsset(
                AppIcons.downIcon,
                height: 5.83,
                width: 9.55,
              ),
            ),
          ),
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.medium(
                      "State *",
                      color: context.colorScheme.tertiary,
                      size: 14,
                    ),
                    const Gap(4),
                    const CommonTextField(
                      readOnly: true,
                      hintText: "State",
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0),
                        child: SvgImageFromAsset(
                          AppIcons.downIcon,
                          height: 5.83,
                          width: 9.55,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.medium(
                      "City *",
                      color: context.colorScheme.tertiary,
                      size: 14,
                    ),
                    const Gap(4),
                    const CommonTextField(
                      readOnly: true,
                      hintText: "City",
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0),
                        child: SvgImageFromAsset(
                          AppIcons.downIcon,
                          height: 5.83,
                          width: 9.55,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(24.49),
          CommonText.medium(
            "Language *",
            color: context.colorScheme.tertiary,
            size: 14,
          ),
          const Gap(4),
          CommonTextField(
            readOnly: true,
            hintText: "Language",
            onTap: (){

            },
            suffixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SvgImageFromAsset(
                AppIcons.downIcon,
                height: 5.83,
                width: 9.55,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(

            ),
          ),
          Gap(26),
          /*  RecaptchaV2Button(
                            apiKey: "6LfXp1UpAAAAAEku9BSeBt6JJxXrlvtYjh--X4D7",
                            apiSecret: "6LfXp1UpAAAAAIFVynIPkooVWZi5qN8u16SYJTVt",
                            pluginURL:
                            'https://recaptcha-flutter-plugin.firebaseapp.com/',
                            isErrorShowing: false,
                            onVerified: (val) {
                              print(' Verified $val');
                            },
                          ),*/
          /*SizedBox(
                            height: 74,
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                IgnorePointer(
                                  ignoring: true,
                                  child: ReCaptchaWebView(
                                    width: double.maxFinite,
                                    height: 200,
                                    onTokenReceived: (token){
                                      print("token");

                                    },
                                    url: 'https://emerald-eran-52.tiiny.site',
                                  ),
                                ),
                              ],
                            ),
                          ),*/
          const Gap(17),
          PrimaryButton(
            gradient: AppGradients.of(context).disabledButton,
            onPressed: () {
              context.navigator.pushNamed(SuccessView.routeName);
            },
            label: "Verify with OTP",
          ),
          const Gap(21),
          GestureDetector(
            onTap: () {
              cubit.decrement();
            },
            child: Center(
              child: CommonText.regular(
                "Back",
                textAlign: TextAlign.center,
                decoration: TextDecoration.underline,
                decorationColor: context.colorScheme.surfaceTint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
