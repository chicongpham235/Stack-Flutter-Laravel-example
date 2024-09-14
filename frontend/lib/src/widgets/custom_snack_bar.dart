import 'package:flutter/material.dart';
import 'package:frontend/src/configs/constants/app_colors.dart';

SnackBar customSnackBar(BuildContext context, String message, bool error) {
  return SnackBar(
    backgroundColor: error ? AppColors.errorColor : AppColors.successColor,
    content: Text(
      message,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontStyle: FontStyle.normal,
      ),
      textAlign: TextAlign.center,
    ),
    duration: Duration(milliseconds: 500),
  );
}
