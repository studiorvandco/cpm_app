import 'package:flutter/material.dart';

class SnackBarManager {
  static final SnackBarManager _instance = SnackBarManager._internal();

  factory SnackBarManager() {
    return _instance;
  }

  SnackBarManager._internal();

  void show(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
