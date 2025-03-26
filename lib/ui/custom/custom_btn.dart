import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  double btnWidth;
  Color btnColor;
  Color btnTextColor;
  Color btnBorderColor;
  double btnBorderWidth;
  String btnText;
  double textSize;
  FontWeight textWeight;
  Function doThis;

  CustomBtn({
    super.key,
    required this.doThis,
    required this.btnText,
    required this.btnTextColor,
    required this.textSize,
    required this.textWeight,
    required this.btnWidth,
    required this.btnColor,
    required this.btnBorderWidth,
    required this.btnBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: btnWidth,
      onPressed: () => doThis(),
      shape: OutlineInputBorder(
          borderSide: BorderSide(width: btnBorderWidth, color: btnBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(23))),
      child: Text(
        btnText,
        style: TextStyle(
            color: btnTextColor, fontSize: textSize, fontWeight: textWeight),
      ),
      color: btnColor,
    );
  }
}
