final shemaLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: colorShemaCream,

  colorScheme: const ColorScheme.light(
    primary: colorShemaTile,
    secondary: colorShemaBlue,
    tertiary: colorShemaGreenLight,
    surface: colorWhite,
    background: colorShemaCream,
    onPrimary: colorShemaCream,
    onSurface: colorShemaBlack,
    outline: colorShemaSand,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: colorShemaCream,
    foregroundColor: colorShemaBlack,
    elevation: 0,
  ),

  cardTheme: CardTheme(
    color: colorWhite,
    elevation: 2,
    shadowColor: colorShemaBlack.withOpacity(0.1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: colorShemaSand, width: 0.5),
    ),
  ),
);
