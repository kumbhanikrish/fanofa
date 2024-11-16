import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UnderlinedTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController? controller;
  final List<Tab> tabs;
  final ValueChanged<int>? onTap;
  final bool isScrollable;

  const UnderlinedTabBar({super.key, this.controller, required this.tabs, this.onTap, this.isScrollable = true});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQueryPadding = MediaQuery.of(context).padding;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.tertiary)),
      ),
      child: Material(
        borderRadius: BorderRadius.zero,
        color: colorScheme.background,
        child: TabBar(
          controller: controller,
          isScrollable: isScrollable,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: colorScheme.primary,
          indicatorWeight: 2,
          onTap: onTap,
          padding: EdgeInsets.only(
            left: math.max(mediaQueryPadding.left, 12),
            right: math.max(mediaQueryPadding.right, 12),
          ),
          tabs: List.generate(
            tabs.length,
            (index) => Container(
              width: null,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Tab(
                height: tabs[index].height ?? 28,
                text: tabs[index].text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController? controller;
  final List<Tab> tabs;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;

  const RoundedTabBar({super.key, this.controller, required this.tabs, this.onTap, this.backgroundColor});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: backgroundColor ?? colorScheme.background,
      child: TabBar(
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        controller: controller,
        isScrollable: false,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: colorScheme.onPrimary,
        indicatorWeight: 2,
        onTap: onTap,
        indicator: BoxDecoration(color: colorScheme.secondary, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        tabs: List.generate(
          tabs.length,
          (index) => Tab(
            height: tabs[index].height ?? 32,
            text: tabs[index].text,
          ),
        ),
      ),
    );
  }
}

class TabBarItem {
  final String label;
  final Widget view;

  const TabBarItem({required this.label, required this.view});
}

class UnderlinedTabBarView extends StatelessWidget {
  final TabController? controller;
  final List<TabBarItem> tabs;
  final ValueChanged<int>? onTap;
  final bool isScrollable;

  const UnderlinedTabBarView({super.key, this.controller, required this.tabs, this.onTap, this.isScrollable = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(16),
        UnderlinedTabBar(
          controller: controller,
          onTap: onTap,
          isScrollable: isScrollable,
          tabs: [for (var item in tabs) Tab(text: item.label)],
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [for (var item in tabs) item.view],
          ),
        ),
      ],
    );
  }
}
