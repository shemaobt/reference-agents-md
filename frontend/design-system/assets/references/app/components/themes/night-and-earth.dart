final shemaDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: colorShemaBlack,

  colorScheme: const ColorScheme.dark(
    primary: colorShemaTile,
    secondary: colorShemaBlue,
    tertiary: colorShemaGreenLight,
    surface: colorShemaBlack,
    background: colorShemaBlack,
    onPrimary: colorShemaCream,
    onSurface: colorShemaCream,
    onSurfaceVariant: colorShemaSand,
    outline: colorShemaGreenDark,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: colorShemaBlack,
    foregroundColor: colorShemaCream,
    elevation: 0,
  ),

  cardTheme: CardTheme(
    color: colorShemaBlack,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(
        color: colorShemaGreenDark,
        width: 1.5,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: colorShemaGreenDark.withOpacity(0.2),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: colorShemaGreenDark),
    ),
    hintStyle: const TextStyle(color: colorShemaSand),
  ),
);
