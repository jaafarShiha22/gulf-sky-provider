import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulf_sky_provider/core/utils/app_colors.dart';

class AppTextStyle {
  static const double _xSmallFontSize = 13.0;
  static const double _smallFontSize = 15.0;
  static const double _regularFontSize = 18.0;
  static const double _largeFontSize = 32.0;

  ///Black
  static final TextStyle interSmallBoldBlack = GoogleFonts.inter(
    color: AppColors.black,
    fontSize: _smallFontSize,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle interSmallBlack = GoogleFonts.inter(
    color: AppColors.black,
    fontSize: _smallFontSize,
  );

  static final TextStyle interXSmallBlack = GoogleFonts.inter(
    color: AppColors.black,
    fontSize: _xSmallFontSize,
  );

  static final TextStyle interLargeBoldBlack = GoogleFonts.inter(
    color: AppColors.black,
    fontSize: _largeFontSize,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle interRegularBlack = GoogleFonts.inter(
    color: AppColors.black,
    fontSize: _regularFontSize,
  );

  static final TextStyle interRegularBoldBlack = GoogleFonts.inter(
    color: AppColors.black,
    fontSize: _regularFontSize,
    fontWeight: FontWeight.bold,
  );
  ///White
  static final TextStyle interRegularBoldWhite = GoogleFonts.inter(
    color: AppColors.white,
    fontSize: _regularFontSize,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle interSmallBoldWhite = GoogleFonts.inter(
    color: AppColors.white,
    fontSize: _smallFontSize,
    fontWeight: FontWeight.bold,
  );


  static final TextStyle interSmallWhite = GoogleFonts.inter(
    color: AppColors.white,
    fontSize: _smallFontSize,
  );
  static final TextStyle interXSmallWhite = GoogleFonts.inter(
    color: AppColors.white,
    fontSize: _xSmallFontSize,
  );
  ///Orange
  static final TextStyle interUnderlinedSmallBoldOrange = GoogleFonts.inter(
    color: AppColors.orange,
    fontSize: _smallFontSize,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline
  );


  static final TextStyle interRegularBoldOrange = GoogleFonts.inter(
    color: AppColors.orange,
    fontSize: _regularFontSize,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle interSmallBoldOrange = GoogleFonts.inter(
    color: AppColors.orange,
    fontSize: _smallFontSize,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle interSmallOrange = GoogleFonts.inter(
    color: AppColors.orange,
    fontSize: _smallFontSize,
  );
  static final TextStyle interLargeBoldOrange = GoogleFonts.inter(
      color: AppColors.orange,
      fontSize: _largeFontSize,
      fontWeight: FontWeight.bold,
  );

  static final TextStyle interRegularOrange = GoogleFonts.inter(
    color: AppColors.orange,
    fontSize: _regularFontSize,
  );
}
