import 'package:core/core.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:fanofa/src/ui/auth/interests_product_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OtherLocationView extends StatefulWidget {
  const OtherLocationView({super.key});
  static String routeName = "/other_location_view";
  static Widget builder(BuildContext context) {
    return const OtherLocationView();
  }

  @override
  State<OtherLocationView> createState() => _OtherLocationViewState();
}

class _OtherLocationViewState extends State<OtherLocationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: CommonText.semiBold(
          "Location",
          size: 16,
        ),
      ),
      body: Column(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.95),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(19),
                const CommonText.regular(
                  "Search for area, street name, locality...",
                  size: 12,
                ),
                const Gap(22),
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
                const Gap(23),
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
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                const Gap(22),
                PrimaryButton(
                  onPressed: () {
                    context.navigator.pushNamed(InterestsProductView.routeName);
                  },
                  label: 'Continue',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
