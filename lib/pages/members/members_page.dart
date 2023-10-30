import 'package:cpm/common/actions/add_action.dart';
import 'package:cpm/common/actions/delete_action.dart';
import 'package:cpm/common/menus/menu_action.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/widgets/model_tile.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/providers/members/members.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/string_validators.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MembersPage extends ConsumerStatefulWidget {
  const MembersPage({super.key});

  @override
  ConsumerState<MembersPage> createState() => _MembersState();
}

class _MembersState extends ConsumerState<MembersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddAction<Member>().add(context, ref),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(membersProvider).when(
        data: (members) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final member = members[index];

              return ModelTile<Member>(
                delete: () => DeleteAction<Member>().delete(context, ref, id: member.id),
                model: member,
                leadingIcon: Icons.person,
                title: member.fullName,
                subtitle: member.phoneAndEmail,
                trailing: [
                  IconButton(
                    icon: Icon(MenuAction.call.icon),
                    onPressed: member.phone != null && member.phone!.isValidPhone
                        ? () => MenuAction.call.function!(member.phone!)
                        : null,
                  ),
                ],
                menuActions: [
                  if (member.phone != null && member.phone!.isNotEmpty && member.phone!.isValidPhone)
                    MenuAction.message,
                  if (member.email != null && member.email!.isNotEmpty && member.email!.isValidEmail) MenuAction.email,
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(padding: Paddings.padding4.vertical);
            },
            itemCount: members.length,
            padding: Paddings.withFab(Paddings.custom.page),
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return requestPlaceholderError;
        },
        loading: () {
          return requestPlaceholderLoading;
        },
      ),
    );
  }
}
