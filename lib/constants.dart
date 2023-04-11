import 'package:flutter/material.dart';

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