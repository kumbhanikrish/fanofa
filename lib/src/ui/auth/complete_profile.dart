import 'package:core/core.dart';
import 'package:fanofa/src/common/horizontal_list.dart';
import 'package:fanofa/src/logic/auth/complete/complete_profile_cubit.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/src/gradient_colors.dart';
import 'package:fanofa/src/packages/resouces/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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

class _CompleteProfileViewState extends State<CompleteProfileView> {
  CompleteProfileCubit get cubit =>
      BlocProvider.of<CompleteProfileCubit>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          text: 'Step 1',
                          style: TextStyle(
                            color: context.colorScheme.primary,
                            fontFamily: AppTheme.kFontFamily,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: " of 2",
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
                      value: 1,
                      minHeight: 3.8,
                      backgroundColor: context.colorScheme.shadow,
                      // color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const Gap(39.42),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.0),
                child: CommonText.semiBold(
                  "Complete your account",
                  size: 18,
                ),
              ),
              const Gap(3.07),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.0),
                child: CommonText.regular(
                  "Enter your details below",
                  size: 12,
                ),
              ),
              const Gap(9.49),
              const Divider(),
              const Gap(21.44),
              Padding(
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
                            onTap: (){},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18.5,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppGradients.of(context).enabledButton,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: context.colorScheme.inverseSurface,
                                  width: 1,
                                ),
                              ),
                              child: CommonText.regular(
                                state.ageList[index],
                                size: 14,
                                color: context.colorScheme.surface,
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
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
}
