import 'package:cpm/common/model_generic.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/constants/sizes.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:flutter/material.dart';

class AddDialog<T> extends StatelessWidget with ModelGeneric<T> {
  AddDialog({
    super.key,
    required this.fields,
    required this.cancel,
    required this.add,
  });

  final Function() cancel;
  final Function() add;

  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    return PlatformManager().isMobile
        ? Dialog.fullscreen(
            child: Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: cancel,
                  ),
                  title: Text(localizations.dialog_add_item(item, gender.name)),
                  actions: [
                    TextButton(
                      onPressed: add,
                      child: Text(localizations.button_add),
                    ),
                    Padding(padding: Paddings.padding4.horizontal),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: Paddings.padding16.all,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...fields,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Dialog(
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: Sizes.custom.dialog,
              child: Padding(
                padding: Paddings.padding16.all,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.dialog_add_item(item, gender.name),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Padding(padding: Paddings.padding16.vertical),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: fields,
                        ),
                      ),
                    ),
                    Padding(padding: Paddings.padding8.vertical),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: cancel,
                          child: Text(localizations.button_cancel),
                        ),
                        TextButton(
                          onPressed: add,
                          child: Text(localizations.button_add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
