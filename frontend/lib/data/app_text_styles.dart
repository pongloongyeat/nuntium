import 'package:flutter/material.dart';
import 'package:frontend/data/data.dart';

final class AppTextStyles {
  const AppTextStyles._();

  static const buttonTextPrimary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const buttonTextSecondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.greyDark,
  );
  static const heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
  );
  static const caption = TextStyle(fontSize: 16, color: AppColors.greyPrimary);
}
