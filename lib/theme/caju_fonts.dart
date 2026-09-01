import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_scanner/theme/app_palette.dart';

TextTheme cuteTextTheme(TextTheme base, AppTypeface typeface) {
  switch (typeface) {
    case AppTypeface.system:
      return base;
    case AppTypeface.rounded:
      return GoogleFonts.mPlusRounded1cTextTheme(base);
    case AppTypeface.maru:
      return GoogleFonts.zenMaruGothicTextTheme(base);
    case AppTypeface.xiaowei:
      return GoogleFonts.zcoolXiaoWeiTextTheme(base);
    case AppTypeface.nunito:
      return GoogleFonts.nunitoTextTheme(base);
  }
}

TextStyle cutePreviewStyle(AppTypeface typeface, TextStyle? base) {
  final style = (base ?? const TextStyle()).copyWith(fontSize: 13);
  switch (typeface) {
    case AppTypeface.system:
      return style;
    case AppTypeface.rounded:
      return GoogleFonts.mPlusRounded1c(textStyle: style);
    case AppTypeface.maru:
      return GoogleFonts.zenMaruGothic(textStyle: style);
    case AppTypeface.xiaowei:
      return GoogleFonts.zcoolXiaoWei(textStyle: style);
    case AppTypeface.nunito:
      return GoogleFonts.nunito(textStyle: style);
  }
}
