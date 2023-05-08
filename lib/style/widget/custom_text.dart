import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color/color.dart';
// import 'package:login_pages/style/color/color.dart';

class CustomText extends StatelessWidget {
  final String text;

  final double fontSize;

  final Color color;

  final Alignment alignment;

  final int maxLine;
  final double height;

  CustomText({
    this.text = '',
    this.fontSize = 16,
    this.color = tYalowColor,
    this.alignment = Alignment.topLeft,
     required this.maxLine,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          height: height,
          fontSize: fontSize,
        ),
        maxLines: maxLine,
        textAlign: TextAlign.right,
      ),
    );
  }
}