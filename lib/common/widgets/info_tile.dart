import 'package:cpm/common/menus/menu_action.dart';
import 'package:cpm/common/widgets/icon_image_provider.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/constants/radiuses.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.edit,
    required this.delete,
    required this.leadingIcon,
    this.leadingImage,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final Function() edit;
  final Function() delete;

  final IconData leadingIcon;
  final ImageProvider? leadingImage;
  final String title;
  final String? subtitle;
  final List<Widget>? trailing;

  void _onMenuSelected(MenuAction action) {
    switch (action) {
      case MenuAction.edit:
        edit();
      case MenuAction.delete:
        delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: IconImageProvider(leadingIcon),
          foregroundImage: leadingImage,
        ),
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: subtitle != null && subtitle!.isNotEmpty
            ? Text(
                subtitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...?trailing,
            PopupMenuButton(
              icon: Icon(
                Icons.more_horiz,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              itemBuilder: (BuildContext context) {
                return MenuAction.values.map((action) {
                  return PopupMenuItem<MenuAction>(
                    value: action,
                    child: ListTile(
                      leading: Icon(action.icon),
                      title: Text(action.title),
                      contentPadding: Paddings.custom.zero,
                    ),
                  );
                }).toList();
              },
              onSelected: _onMenuSelected,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: Radiuses.radius8.circular),
      ),
    );
  }
}
