import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';

enum MenuAction {
  edit(Icons.edit),
  delete(Icons.delete),
  ;

  final IconData icon;

  const MenuAction(this.icon);

  String get title {
    switch (this) {
      case edit:
        return localizations.menu_edit;
      case delete:
        return localizations.menu_delete;
    }
  }
}
