import 'package:flutter/material.dart';

const uri = "https://cff0-2405-201-6834-3824-77-9ec0-f80c-da3f.in.ngrok.io/api/FAQ";

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

class colors {
  static const Color primaryColor = Color(0xffd4d5e2);
  static const Color secondaryColor = Color(0xff150050);
  static const Color tertiaryColor = Color(0xff000000);
  static const Color quaternaryColor = Color(0xff000000);
}