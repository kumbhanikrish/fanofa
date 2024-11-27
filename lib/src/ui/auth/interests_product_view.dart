import 'package:core/core.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/ui/home/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';

class InterestsProductView extends StatefulWidget {
  const InterestsProductView({super.key});

  static String routeName = "/interests_product_view";
  static Widget builder(BuildContext context) {
    return const InterestsProductView();
  }

  @override
  State<InterestsProductView> createState() => InterestsStateProductView();
}

class InterestsStateProductView extends State<InterestsProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: context.topPadding),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 15.57,
                ),
                child: CommonText.semiBold(
                  "Get started by picking some interests.",
                  size: 16,
                ),
              ),
              const Gap(26.34),
              Expanded(
                child: MasonryGridView.count(
                  itemCount: image.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: const Color(
                            0xff3a3a3a1a,
                          ),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Color(0x0A000000),
                            offset: Offset(0, 2),
                            blurRadius: 6,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Color(0x0A000000),
                            offset: Offset(0, 10),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // height: (index % 2 + 2) * 100,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: CommonText.semiBold(
                              'Cars & Vehicles',
                              size: 15,
                            ),
                          ),
                          ImageFromAsset(
                            image[index],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 24, vertical: context.bottomPadding + 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    borderRadius: BorderRadius.circular(16),
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color(0xFF343434),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    label: 'Skip',
                    textColor: const Color(0xFF343434),
                  ),
                ),
                const Gap(13.22),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      context.navigator
                          .pushNamed(BottomNavigationView.routeName);
                    },
                    label: 'Continue',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List image = [
  'assets/images/Electronics 06.png',
  'assets/images/Music 01.png',
  'assets/images/Music 01.png',
  'assets/images/Electronics 06.png',
  'assets/images/Electronics 06.png',
  'assets/images/Music 01.png',
];
