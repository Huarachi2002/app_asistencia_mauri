import 'package:app_asistencia_docente/config/theme/paletaColors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  ThemeData getTheme(){
    const seedColor = backgroundColor;
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedColor,
      listTileTheme: const ListTileThemeData(
        iconColor: seedColor,
      )
    );
  }
}