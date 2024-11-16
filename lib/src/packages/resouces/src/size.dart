import 'package:flutter/material.dart';

abstract class Insets {
  static const double none = 0;
  static const double xSmall = 4;
  static const double small = 8;
  static const double medium = 12;
  static const double normal = 16;
  static const double large = 20;
  static const double extraLarge = 30;
  static const double xLarge = 24;
}

abstract class PaddingValue {
  static const EdgeInsets zero = EdgeInsets.zero;
  static const EdgeInsets xSmall = EdgeInsets.all(Insets.xSmall);
  static const EdgeInsets small = EdgeInsets.all(Insets.small);
  static const EdgeInsets medium = EdgeInsets.all(Insets.medium);
  static const EdgeInsets normal = EdgeInsets.all(Insets.normal);
  static const EdgeInsets large = EdgeInsets.all(Insets.large);
  static const EdgeInsets xLarge = EdgeInsets.all(Insets.xLarge);
}

abstract class RadiusValue {
  static const double xSmall = 4;
  static const double small = 8;
  static const double medium = 12;
  static const double normal = 16;
  static const double large = 20;
  static const double xLarge = 24;
  static const double extraLarge = 30;
}

abstract class ShapeRadius {
  static const Radius zero = Radius.zero;
  static const Radius xSmall = Radius.circular(RadiusValue.xSmall);
  static const Radius small = Radius.circular(RadiusValue.small);
  static const Radius medium = Radius.circular(RadiusValue.medium);
  static const Radius normal = Radius.circular(RadiusValue.normal);
  static const Radius large = Radius.circular(RadiusValue.large);
  static const Radius xLarge = Radius.circular(RadiusValue.xLarge);
  static const Radius extraLarge = Radius.circular(RadiusValue.extraLarge);
}

abstract class ShapeBorderRadius {
  static const BorderRadius zero = BorderRadius.zero;
  static const BorderRadius xSmall = BorderRadius.all(ShapeRadius.xSmall);
  static const BorderRadius small = BorderRadius.all(ShapeRadius.small);
  static const BorderRadius medium = BorderRadius.all(ShapeRadius.medium);
  static const BorderRadius normal = BorderRadius.all(ShapeRadius.normal);
  static const BorderRadius extraLarge = BorderRadius.all(ShapeRadius.extraLarge);
  static const BorderRadius large = BorderRadius.all(ShapeRadius.large);
  static const BorderRadius xLarge = BorderRadius.all(ShapeRadius.xLarge);
}

abstract class TextSize {
  static const double heading = 20;
  static const double appBarTitle = 18;
  static const double appBarSubTitle = 14;
  static const double title = 16;
  static const double subTitle = 14;
  static const double label = 14;
  static const double content = 12;
  static const double body = 10;
  static const double largeText = 22;
}

abstract class TextWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}
