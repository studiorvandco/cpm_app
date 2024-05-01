import 'package:cpm/common/dialogs/model_dialog.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:flutter/material.dart';

class AddLocationDialog extends StatefulWidget {
  const AddLocationDialog({super.key});

  @override
  State<AddLocationDialog> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends State<AddLocationDialog> {
  final TextEditingController name = TextEditingController();
  final TextEditingController position = TextEditingController();

  void _add(BuildContext context) {
    Navigator.pop(
      context,
      Location(
        name: name.text,
        position: position.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModelDialog(
      submit: () => _add(context),
      title: localizations.dialog_add_item(localizations.item_location(1), Gender.male.name),
      action: localizations.button_add,
      fields: [
        TextField(
          controller: name,
          textInputAction: TextInputAction.next,
          autofocus: true,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_name,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
        Padding(padding: Paddings.padding8.vertical),
        TextField(
          controller: position,
          autofocus: true,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_position,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
      ],
    );
  }
}
