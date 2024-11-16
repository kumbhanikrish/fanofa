import 'package:fanofa/src/packages/resouces/src/theme/app_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources.dart';

abstract class AppTheme {
  static const kFontFamily = "Poppins";

  static const AppColorTheme _appColorTheme = AppColorTheme(
      failure: Color(0xFFFF3B30),
      success: Color(0xFF33A64C),
      link: Color(0xFF47A0F2));

  static ThemeData get lightTheme {
    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF3EB1E0),
      onPrimary: Color(0xFF0E77CC),
      secondary: Color(0xFF3A3A3A),
      onSecondary: Color(0xFF3D5CFF),
      tertiary: Color(0xFF858597),
      onTertiary: Color(0xFF666666),
      scrim: Color(0xFF00A81D),
      error: Color(0xFFEC1E1E),
      onError: Color(0xFFFFFFFF),
      outline: Color(0xFF727272),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF000000),
      surfaceTint: Color(0xFF333333),
      inversePrimary: Color(0xFFBBBBBB),
      errorContainer: Color(0xFFD9D9D9),
      tertiaryContainer: Color(0xFF425466),
      inverseSurface: Color(0xFFB8B8D2),
      onSurfaceVariant: Color(0xFFD5F1FF),
      outlineVariant: Color(0xFF648DDB),
      onInverseSurface: Color(0xFF83898C),
      shadow: Color(0xFFF1F1F1)
    );
    return ThemeData(
      useMaterial3: false,
      brightness: colorScheme.brightness,
      primaryColor: colorScheme.primary,
      primaryColorDark: colorScheme.primary,
      primaryColorLight: colorScheme.primary,
      indicatorColor: colorScheme.primary,
      disabledColor: colorScheme.onSurface,
      shadowColor: colorScheme.shadow,
      scaffoldBackgroundColor: colorScheme.background,
      fontFamily: kFontFamily,
      colorScheme: colorScheme,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w500,
          color: colorScheme.surfaceTint,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.shifting,
      ),
      // bottomSheetTheme: bottomSheetTheme(colorScheme),
      dialogTheme: dialogTheme(colorScheme),
      cardTheme: CardTheme(
        shape:
            const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.small),
        margin: EdgeInsets.zero,
        color: colorScheme.background,
        shadowColor: colorScheme.shadow,
        elevation: 4,
        clipBehavior: Clip.hardEdge,
      ),
      appBarTheme: appBarTheme(colorScheme),
      elevatedButtonTheme: elevatedButtonTheme(colorScheme),
      outlinedButtonTheme: outlinedButtonTheme(colorScheme),
      textButtonTheme: textButtonTheme(colorScheme),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
        selectionColor: colorScheme.primary.withOpacity(0.3),
        selectionHandleColor: colorScheme.primary,
      ),
      inputDecorationTheme: inputDecorationTheme(colorScheme),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStatePropertyAll(colorScheme.onError),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        side: BorderSide(color: colorScheme.inverseSurface, width: 1),
        checkColor: WidgetStatePropertyAll(colorScheme.onError),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(colorScheme.surfaceTint),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
        )
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.primary,
        contentTextStyle: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 14,
            fontFamily: kFontFamily,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis),
        shape:
            const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.small),
        behavior: SnackBarBehavior.floating,
        elevation: 8,
        actionTextColor: colorScheme.secondary,
        disabledActionTextColor: colorScheme.onSurface,
      ),
      tabBarTheme: tabBarTheme(colorScheme),
      dividerTheme:
          DividerThemeData(color: colorScheme.surfaceTint.withOpacity(0.10), thickness: 1, space: 1),
      popupMenuTheme: popupMenuTheme(colorScheme),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: colorScheme.background,
        headerForegroundColor: colorScheme.background,
      //  rangePickerBackgroundColor: colorScheme.background,
       // rangePickerHeaderBackgroundColor: colorScheme.background,
          /*dayBackgroundColor: MaterialStatePropertyAll(
            colorScheme.background,
          ),*/
          headerHeadlineStyle: TextStyle(
          color: colorScheme.background,
        )
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        padding: EdgeInsets.zero,
        elevation: 8,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const CircleBorder(),
        elevation: 8,
      ),
      extensions: const [_appColorTheme],
      listTileTheme: ListTileThemeData(
        textColor: colorScheme.onBackground,
      ),
    );
  }

  static AppBarTheme appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.background,
      foregroundColor: colorScheme.onPrimary,
      centerTitle: true,
      titleSpacing: 0,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness:
            ThemeData.estimateBrightnessForColor(colorScheme.background),
        statusBarIconBrightness:
            ThemeData.estimateBrightnessForColor(colorScheme.onBackground),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      surfaceTintColor: colorScheme.background,
      scrolledUnderElevation: 8,
      //shadowColor: colorScheme.shadow,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.onBackground,
        fontFamily: kFontFamily,
      ),
    );
  }

  static BottomAppBarTheme bottomAppBarTheme(ColorScheme colorScheme) {
    return BottomAppBarTheme(color: colorScheme.background, elevation: 8);
  }

  static FloatingActionButtonThemeData floatingActionButtonTheme(
      ColorScheme colorScheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape:
          const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
      sizeConstraints: BoxConstraints.tight(const Size(48, 48)),
      elevation: 8,
    );
  }

  static CardTheme cardTheme(ColorScheme colorScheme) {
    return CardTheme(
      shape:
          const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.normal),
      margin: EdgeInsets.zero,
      color: colorScheme.background,
      shadowColor: colorScheme.shadow,
      elevation: 4,
      clipBehavior: Clip.hardEdge,
    );
  }

  static DialogTheme dialogTheme(ColorScheme colorScheme) {
    return DialogTheme(
      shape:
          const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.normal),
      backgroundColor: colorScheme.background,
      elevation: 4,
      titleTextStyle: TextStyle(
        fontSize: 16,
        color: colorScheme.onBackground,
        fontWeight: FontWeight.w500,
        fontFamily: kFontFamily,
      ),
      contentTextStyle: TextStyle(
        fontSize: 14,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
        fontFamily: kFontFamily,
      ),
    );
  }

  static BottomSheetThemeData bottomSheetTheme(ColorScheme colorScheme) {
    return BottomSheetThemeData(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: ShapeRadius.normal)),
      backgroundColor: colorScheme.background,
      modalBackgroundColor: colorScheme.background,
      elevation: 4,
      modalElevation: 8,
      clipBehavior: Clip.hardEdge,
    );
  }

  static TextSelectionThemeData textSelectionTheme(ColorScheme colorScheme) {
    return TextSelectionThemeData(
      cursorColor: colorScheme.primary,
      selectionColor: colorScheme.primary.withOpacity(0.3),
      selectionHandleColor: colorScheme.primary,
    );
  }

  static ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        textStyle:  TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, fontFamily: kFontFamily,color: colorScheme.background),
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.secondary,
        shape: const RoundedRectangleBorder(
            borderRadius: ShapeBorderRadius.normal),
        padding: const EdgeInsets.all(16),
        side: BorderSide(color: colorScheme.secondary, width: 1),
        textStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, fontFamily: kFontFamily),
      ),
    );
  }

  static TextButtonThemeData textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        padding: PaddingValue.small,
        shape:
            const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.large),
        textStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, fontFamily: kFontFamily),
      ),
    );
  }

  static InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) {

    const textStyle =
        TextStyle(fontWeight: FontWeight.w400, fontFamily: kFontFamily);

    return InputDecorationTheme(
      hintStyle: textStyle.copyWith(
        color: colorScheme.inverseSurface,
        fontSize: 10,
        height: 1.0,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: textStyle.copyWith(
        color: colorScheme.error,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      errorMaxLines: 3,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color:colorScheme.inverseSurface,)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.inverseSurface,)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.inverseSurface,)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.inverseSurface,)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.inverseSurface,)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.error,)),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      fillColor: colorScheme.surface,
      filled: true,
    );
  }

  static TabBarTheme tabBarTheme(ColorScheme colorScheme) {
    const labelStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, fontFamily: kFontFamily);
    return TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(100),
      ),
      labelStyle: labelStyle,
      unselectedLabelStyle:
          labelStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
      labelColor: colorScheme.onPrimary,
      unselectedLabelColor: colorScheme.surfaceTint,
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      dividerColor: Colors.transparent,
    );
  }

  static PopupMenuThemeData popupMenuTheme(ColorScheme colorScheme) {
    return PopupMenuThemeData(
      color: colorScheme.background,
      shape:
          const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
      elevation: 4,
      textStyle: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 14,
          fontFamily: kFontFamily,
          fontWeight: FontWeight.w600),
    );
  }
}
