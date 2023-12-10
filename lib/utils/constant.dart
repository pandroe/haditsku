import 'package:flutter/widgets.dart';

class Constant {
  // regular = normal, small < regular < big
  static const double fontExtraSmall = 10.0;
  static const double fontSmall = 12.0;
  static const double fontSemiSmall = 14.0;
  static const double fontRegular = 15.0;
  static const double fontSemiRegular = 16.0;
  static const double fontSemiBig = 18.0;
  static const double fontBig = 20.0;
  static const double fontExtraBig = 28.0;
  static const double fontTitle = 24.0;

  static const int witheColorBase = 0xFFFAFAFA;
  static const int witheColorNetral = 0xFFFFFFFF;
  static const int greenColorPrimary = 0xFF0B6051;
  static const int greenColorLight = 0xFF1BA345;
  static const int yellowColorSecondary = 0xFFF7DB5E;
  static const int redColorLight = 0xFFFF0000;
  static const int blackColorLight = 0xFF000000;
  static const int grayColorNetralDark = 0xFF797979;
  static const int grayColorNetralLight = 0xFFD1D3D2;

  final Size size;

  Constant(BuildContext context) : size = MediaQuery.of(context).size;
}
