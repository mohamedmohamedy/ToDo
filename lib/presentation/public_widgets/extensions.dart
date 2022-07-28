import 'package:flutter/material.dart';

extension ColorExtension on String {
  Color toColor() {
    return Color(int.parse(this));
  }
}

extension TextStyleExtension on String {
  Text toTitle() {
    return Text(this, style: const TextStyle(fontSize: 20));
  }
}
