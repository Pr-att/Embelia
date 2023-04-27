import 'package:flutter/material.dart';

const uri = "https://b3d0-103-77-186-50.in.ngrok.io/api/FAQ";

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

const kGradient = LinearGradient(colors: <Color>[
  Color(0xff000000),
  Color(0xff150050),
  Color(0xff000000),
  Color(0xff000000),
], );

class MyColor {
  static const Color primaryColor = Color(0xfff9e7ed);
  static const Color secondaryColor = Color(0xff150050);
  static const Color tertiaryColor = Color(0xff000000);
  static const Color quaternaryColor = Color(0xff000000);
  static const Color lightGreyShade = Color(0xffE6EDf5);
}