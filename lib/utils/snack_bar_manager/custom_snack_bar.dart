import 'package:flutter/material.dart';

class CustomSnackBar {
  static SnackBar getInfoSnackBar(String message) {
    return SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
  }

  static SnackBar getErrorSnackBar(String error) {
    return SnackBar(
      content: Text('Error: $error'),
      behavior: SnackBarBehavior.floating,
    );
  }
}
