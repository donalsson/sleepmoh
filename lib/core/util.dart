import 'package:flutter/material.dart';

double baseHeight = 640.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

class PaypalColors {
  static const LightBlue = Colors.blue;
  static const DarkBlue = Color.fromRGBO(147, 0, 0, 1);
  static const LightGrey19 = Color.fromRGBO(112,112,112, 0.19);
  static const LightGrey = Color.fromRGBO(242, 242, 242, 1);
  static const Grey = Color.fromRGBO(157, 157, 157, 1);
  static const Black50 = Color.fromRGBO(0, 0, 0, 1);
  static const Black70 = Color.fromRGBO(0, 0, 0, 0.04);
  static const Green = Color.fromRGBO(61, 179, 158, 1);
  static const Primary = Colors.blue;
}

