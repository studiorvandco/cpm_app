import 'package:cpm/common/actions/add_action.dart';
import 'package:cpm/common/actions/delete_action.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/widgets/info_tile.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/pages/members/member_dialog.dart';
import 'package:cpm/providers/members/members.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/string_validators.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MembersPage extends ConsumerStatefulWidget {
  const MembersPage({super.key});

  @override
  ConsumerState<MembersPage> createState() => _MembersState();
}

class _MembersState extends ConsumerState<MembersPage> {
  Future<void> _edit(Member member) async {
    final editedMember = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MemberDialog(member: member);
      },
    );
    if (editedMember is Member) {
      final edited = await ref.read(membersProvider.notifier).edit(editedMember);
      SnackBarManager().show(
        edited
            ? getInfoSnackBar(
                localizations.snack_bar_edit_success_item(localizations.item_member, Gender.male.name),
              )
            : getErrorSnackBar(
                localizations.snack_bar_edit_fail_item(localizations.item_member, Gender.male.name),
              ),
      );
    }
  }

  void _call(Member member) {
    launchUrlString('tel:${member.phone}');
  }

  void _message(Member member) {
    launchUrlString('sms:${member.phone}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => add<Member>(context, ref),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(membersProvider).when(
        data: (List<Member> members) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final member = members[index];

              return InfoTile(
                edit: () => _edit(member),
                delete: () => delete(
                  context,
                  ref,
                  id: member.id,
                ),
                leadingIcon: Icons.person,
                title: member.fullName,
                subtitle: member.phone,
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.call),
                    onPressed: member.phone != null && member.phone!.isValidPhone ? () => _call(member) : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.message),
                    onPressed: member.phone != null && member.phone!.isValidPhone ? () => _message(member) : null,
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(padding: Paddings.padding4.vertical);
            },
            itemCount: members.length,
            padding: Paddings.custom.fab,
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
