import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  String Hint;
  Icon? sufIcon;

  CustomTextfield({required this.Hint, this.sufIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          prefixText: "    ",
          hintStyle: TextStyle(color: Colors.grey),
          hintText: Hint,
          filled: true,
          suffixIcon: sufIcon,
          fillColor: AppColor.whiteColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
