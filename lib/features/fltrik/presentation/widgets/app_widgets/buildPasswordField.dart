import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:flutter/material.dart';

Widget buildPasswordField(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: TextStyle(color: ColorsAssets.textLight),
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: ColorsAssets.textMedium),
        suffixIcon: Icon(Icons.visibility, color: ColorsAssets.primaryColor),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsAssets.textMedium),borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsAssets.primaryColor),borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }