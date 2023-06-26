import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/member/member.dart';
import '../services/member_service.dart';

part 'members.g.dart';

@riverpod
class Members extends _$Members {
  @override
  FutureOr<List<Member>> build() {
    get();

    return <Member>[];
  }

  Future<Map<String, dynamic>> get() async {
    state = const AsyncLoading<List<Member>>();
    final List result = await MemberService().getMembers();
    state = AsyncData<List<Member>>(result[1] as List<Member>);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[2] as int};
  }

  Future<Map<String, dynamic>> add(Member member) async {
    final List result = await MemberService().addMember(member);
    await get(); // Get the members in order to get the new member's ID

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> edit(Member editedMember) async {
    final List result = await MemberService().editMember(editedMember);
    state = AsyncData<List<Member>>(<Member>[
      for (final Member member in state.value ?? <Member>[])
        if (member.id != editedMember.id) member else editedMember,
    ]);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> delete(String memberID) async {
    final List result = await MemberService().deleteMember(memberID);
    state = AsyncData<List<Member>>(<Member>[
      for (final Member members in state.value ?? <Member>[])
        if (members.id != memberID) members,
    ]);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }
}
