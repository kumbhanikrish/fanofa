import 'package:core/core.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:fanofa/src/packages/resouces/src/gradient_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});
  static String routeName = "/bottom_navigation_view";
  static Widget builder(BuildContext context) {
    return const BottomNavigationView();
  }

  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Page ${_selectedIndex + 1}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Container(
            height: 65.01,
            width: 65.01,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.of(context).enabledButton),
          ),
          Positioned(
            bottom: 5,
            right: 0,
            left: 0,
            child: Container(
              height: 54.26,
              width: 54.26,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.add,
                color: context.colorScheme.primary,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipPath(
        clipper: CustomBottomAppBarClipper(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                width: 1,
                color: context.colorScheme.primary,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.59),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavItem(
                        icon: AppIcons.home,
                        label: 'Home',
                        index: 0,
                      ),
                      _buildNavItem(
                        icon: AppIcons.user,
                        label: 'Account',
                        index: 1,
                      )
                    ],
                  ),
                ),
                const Gap(34),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(50),
                    CommonText.regular(
                      'Post Ads',
                      size: 10,
                    ),
                    Gap(18.86)
                  ],
                ),
                const Gap(25),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavItem(
                        icon: AppIcons.videoHorizontal,
                        label: 'My Ads',
                        index: 2,
                      ),
                      _buildNavItem(
                        icon: AppIcons.menu,
                        label: 'Category',
                        index: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      {required String icon, required String label, required int index}) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isSelected
              ? Container(
                  height: 4.92,
                  width: 38,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(4.31),
                      bottomRight: Radius.circular(4.31),
                    ),
                  ),
                )
              : Container(),
          const Gap(15.36),
          SvgImageFromAsset(
            icon,
            height: 22,
            width: 22,
            color: isSelected
                ? context.colorScheme.primary
                : const Color(0xFF505050),
          ),
          const Gap(8.36),
          CommonText.regular(
            label,
            size: 10,
            color: isSelected
                ? context.colorScheme.primary
                : const Color(0xFF505050),
          ),
          const Gap(15),
        ],
      ),
    );
  }
}

class CustomBottomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double notchRadius =
        35.0; // Radius for the floating action button notch
    const double curveDepth = 30.0; // Depth of the side curves
    final double notchCenterX = size.width / 2;

    Path path = Path();
    path.lineTo(notchCenterX - notchRadius - curveDepth, 0);

    // Left curve
    path.quadraticBezierTo(
      notchCenterX - notchRadius, // Control point x
      0, // Control point y
      notchCenterX - notchRadius + 5, // End x
      curveDepth, // End y
    );

    // Top of the notch
    path.arcToPoint(
      Offset(notchCenterX + notchRadius - 5, curveDepth),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );

    // Right curve
    path.quadraticBezierTo(
      notchCenterX + notchRadius, // Control point x
      0, // Control point y
      notchCenterX + notchRadius + curveDepth, // End x
      0, // End y
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
