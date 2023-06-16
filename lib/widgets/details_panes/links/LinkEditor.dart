import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../models/project/link.dart';

class LinkEditor extends StatefulWidget {
  const LinkEditor({super.key, required this.link, required this.edit});

  final Link link;

  final Function(Link) edit;

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
    labelController = TextEditingController(text: widget.link.label);
    urlController = TextEditingController(text: widget.link.url);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Focus(
            onFocusChange: (bool hasFocus) {
              if (!hasFocus && labelController.text != widget.link.label) {
                widget.edit(Link(labelController.text, widget.link.url));
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
        Expanded(
          flex: 2,
          child: Focus(
            onFocusChange: (bool hasFocus) {
              if (!hasFocus && urlController.text != widget.link.url) {
                widget.edit(Link(widget.link.label, urlController.text));
              }
            },
            child: TextFormField(
              controller: urlController,
              decoration: InputDecoration.collapsed(hintText: 'URL'),
              maxLines: 1,
              focusNode: urlFocusNode,
            ),
          ),
        ),
        PopupMenuButton(itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.launch),
                title: Text('Open'),
                onTap: () {
                  launchUrlString(widget.link.url);
                  Navigator.of(context).pop();
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.remove),
                title: Text('Remove'),
                onTap: () {
                  Navigator.of(context).pop();
                  //widget.edit(null);
                },
              ),
            ),
          ];
        }),
      ],
    );
  }
}
