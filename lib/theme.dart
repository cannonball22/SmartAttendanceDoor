import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff091032),
      surfaceTint: Color(0xff565c82),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2a3053),
      onPrimaryContainer: Color(0xffb9bee9),
      secondary: Color(0xff865300),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffb75d),
      onSecondaryContainer: Color(0xff4e2e00),
      tertiary: Color(0xff5d5f5f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffffff),
      onTertiaryContainer: Color(0xff575859),
      error: Color(0xffa20010),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffdc2b2b),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff444748),
      outline: Color(0xff747878),
      outlineVariant: Color(0xffc4c7c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffbfc4ef),
      primaryFixed: Color(0xffdee0ff),
      onPrimaryFixed: Color(0xff13193a),
      primaryFixedDim: Color(0xffbfc4ef),
      onPrimaryFixedVariant: Color(0xff3f4468),
      secondaryFixed: Color(0xffffddb9),
      onSecondaryFixed: Color(0xff2b1700),
      secondaryFixedDim: Color(0xffffb962),
      onSecondaryFixedVariant: Color(0xff663e00),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff1a1c1c),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff454747),
      surfaceDim: Color(0xffddd9d8),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff091032),
      surfaceTint: Color(0xff565c82),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2a3053),
      onPrimaryContainer: Color(0xffeeedff),
      secondary: Color(0xff603a00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffa46700),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff414343),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff737575),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c000c),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffdc2b2b),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff404344),
      outline: Color(0xff5c6060),
      outlineVariant: Color(0xff787b7c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffbfc4ef),
      primaryFixed: Color(0xff6c7299),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff545a7f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffa46700),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff835100),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff737575),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5a5c5c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffddd9d8),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff091032),
      surfaceTint: Color(0xff565c82),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2a3053),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff341d00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff603a00),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff202323),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff414343),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0003),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c000c),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff212525),
      outline: Color(0xff404344),
      outlineVariant: Color(0xff404344),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffeaeaff),
      primaryFixed: Color(0xff3b4064),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff242a4d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff603a00),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff422700),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff414343),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2b2d2d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffddd9d8),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffbfc4ef),
      surfaceTint: Color(0xffbfc4ef),
      onPrimary: Color(0xff282e51),
      primaryContainer: Color(0xff141a3c),
      onPrimaryContainer: Color(0xffa0a5cf),
      secondary: Color(0xffffdbb4),
      onSecondary: Color(0xff472a00),
      secondaryContainer: Color(0xfff3a744),
      onSecondaryContainer: Color(0xff402500),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff2f3131),
      tertiaryContainer: Color(0xffd4d4d4),
      onTertiaryContainer: Color(0xff3e4040),
      error: Color(0xffffb4ac),
      onError: Color(0xff690006),
      errorContainer: Color(0xffd02124),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffc4c7c8),
      outline: Color(0xff8e9192),
      outlineVariant: Color(0xff444748),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff565c82),
      primaryFixed: Color(0xffdee0ff),
      onPrimaryFixed: Color(0xff13193a),
      primaryFixedDim: Color(0xffbfc4ef),
      onPrimaryFixedVariant: Color(0xff3f4468),
      secondaryFixed: Color(0xffffddb9),
      onSecondaryFixed: Color(0xff2b1700),
      secondaryFixedDim: Color(0xffffb962),
      onSecondaryFixedVariant: Color(0xff663e00),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff1a1c1c),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff454747),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc3c8f3),
      surfaceTint: Color(0xffbfc4ef),
      onPrimary: Color(0xff0d1335),
      primaryContainer: Color(0xff898eb7),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffdbb4),
      onSecondary: Color(0xff3d2300),
      secondaryContainer: Color(0xfff3a744),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff2f3131),
      tertiaryContainer: Color(0xffd4d4d4),
      onTertiaryContainer: Color(0xff1e2020),
      error: Color(0xffffbab2),
      onError: Color(0xff370002),
      errorContainer: Color(0xffff544c),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xfffefaf9),
      onSurfaceVariant: Color(0xffc8cbcc),
      outline: Color(0xffa0a3a4),
      outlineVariant: Color(0xff808484),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff40466a),
      primaryFixed: Color(0xffdee0ff),
      onPrimaryFixed: Color(0xff070e30),
      primaryFixedDim: Color(0xffbfc4ef),
      onPrimaryFixedVariant: Color(0xff2e3457),
      secondaryFixed: Color(0xffffddb9),
      onSecondaryFixed: Color(0xff1c0e00),
      secondaryFixedDim: Color(0xffffb962),
      onSecondaryFixedVariant: Color(0xff4f2f00),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff0f1112),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff343637),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffdfaff),
      surfaceTint: Color(0xffbfc4ef),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffc3c8f3),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffbe71),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffd4d4d4),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab2),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff8fbfc),
      outline: Color(0xffc8cbcc),
      outlineVariant: Color(0xffc8cbcc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff22284a),
      primaryFixed: Color(0xffe4e5ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc3c8f3),
      onPrimaryFixedVariant: Color(0xff0d1335),
      secondaryFixed: Color(0xffffe2c5),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffbe71),
      onSecondaryFixedVariant: Color(0xff231200),
      tertiaryFixed: Color(0xffe6e7e7),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffcacbcb),
      onTertiaryFixedVariant: Color(0xff141717),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
