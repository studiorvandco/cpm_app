import 'package:flutter/material.dart';

class LinkEditor extends StatefulWidget {
  const LinkEditor({super.key, required this.link, required this.edit});

  final MapEntry<String, String> link;

  final Function(MapEntry<String, String>) edit;

  @override
  State<LinkEditor> createState() => _LinkEditorState();
}

class _LinkEditorState extends State<LinkEditor> {
  late TextEditingController labelController;
  late TextEditingController urlController;
  final urlFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController(text: widget.link.key);
    urlController = TextEditingController(text: widget.link.value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Focus(
            onFocusChange: (bool hasFocus) {
              if (!hasFocus && labelController.text != widget.link.key) {
                widget.edit(MapEntry(labelController.text, widget.link.value));
              }
            },
            child: TextFormField(
              controller: labelController,
              decoration: InputDecoration.collapsed(hintText: 'Label'),
              maxLines: 1,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                urlFocusNode.requestFocus();
              },
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
        const Icon(Icons.link),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
        Expanded(
          flex: 2,
          child: Focus(
            onFocusChange: (bool hasFocus) {
              if (!hasFocus && urlController.text != widget.link.value) {
                widget.edit(MapEntry(widget.link.key, urlController.text));
              }
            },
            child: TextFormField(
              controller: urlController,
              decoration: InputDecoration.collapsed(hintText: 'Label'),
              maxLines: 1,
              focusNode: urlFocusNode,
            ),
          ),
        ),
      ],
    );
  }
}
