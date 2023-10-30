import 'package:cpm/common/menus/menu_action.dart';
import 'package:cpm/common/sheets/member/member_sheet.dart';
import 'package:cpm/common/sheets/sheets.dart';
import 'package:cpm/common/widgets/icon_image_provider.dart';
import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/providers/members/members.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/constants/radiuses.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InfoTile<T extends BaseModel> extends ConsumerStatefulWidget {
  const InfoTile({
    super.key,
    required this.model,
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

  final T model;
  final IconData leadingIcon;
  final ImageProvider? leadingImage;
  final String title;
  final String? subtitle;
  final List<Widget>? trailing;

  @override
  ConsumerState<InfoTile> createState() => _InfoTileState<T>();
}

class _InfoTileState<T extends BaseModel> extends ConsumerState<InfoTile> {
  void _showSheet(BuildContext context) {
    Widget sheet;

    switch (T) {
      case const (Member):
        ref.read(currentMemberProvider.notifier).set(widget.model as Member);
        sheet = const MemberSheet();
      case const (Location):
        ref.read(currentLocationProvider.notifier).set(widget.model as Location);
        sheet = const MemberSheet();
      default:
        throw Exception();
    }

    Sheets().showSheet(context, sheet);
  }

  void _onMenuSelected(MenuAction action) {
    switch (action) {
      case MenuAction.edit:
        widget.edit();
      case MenuAction.delete:
        widget.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: IconImageProvider(widget.leadingIcon),
          foregroundImage: widget.leadingImage,
        ),
        title: Text(
          widget.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: widget.subtitle != null && widget.subtitle!.isNotEmpty
            ? Text(
                widget.subtitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...?widget.trailing,
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
        onTap: () => _showSheet(context),
      ),
    );
  }
}
