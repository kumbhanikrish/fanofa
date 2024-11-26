import 'dart:async';
import 'dart:math';

import 'package:core/core.dart';
import 'package:fanofa/src/assets_path/assets_images.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:fanofa/src/ui/auth/other_location_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class YourLocationView extends StatefulWidget {
  const YourLocationView({super.key});
  static String routeName = "/your_location_view";

  static Widget builder(BuildContext context) {
    return const YourLocationView();
  }

  @override
  State<YourLocationView> createState() => _YourLocationViewState();
}

class _YourLocationViewState extends State<YourLocationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(20),
                    const SvgImageFromAsset(
                      AppIcons.locationFrame,
                      height: 109,
                      width: 109,
                    ),
                    const Gap(30),
                    const CommonText.semiBold(
                      "Where is your location ?",
                      size: 17,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    const CommonText.semiBold(
                      "Enjoy a personalized selling and buying experience by telling us your locaion",
                      size: 12,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                    PrimaryButton(
                      onPressed: () {
                        // context.navigator
                        //     .pushNamed(LoginVerificationView.routeName);
                      },
                      label: "Set automatically",
                    ),
                    const Gap(20),
                    SecondaryButton(
                      backgroundColor: const Color(0xFFF5F4F7),
                      onPressed: () {
                        context.navigator
                            .pushNamed(OtherLocationView.routeName);
                      },
                      label: "Other Locations",
                      textColor: const Color(0xFF333333),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
