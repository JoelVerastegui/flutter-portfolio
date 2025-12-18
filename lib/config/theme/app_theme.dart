import 'package:flutter/material.dart';

import 'package:my_portfolio/config/constants/app_colors.dart';

class AppTheme {

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.primary,
    scaffoldBackgroundColor: AppColors.dark,
    fontFamily: 'DMSans',
  );

}