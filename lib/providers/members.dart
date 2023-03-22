import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/member.dart';
import '../services/member.dart';

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
    final List<dynamic> result = await MemberService().getMembers();
    state = AsyncData<List<Member>>(result[1] as List<Member>);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[2] as int};
  }

  Future<Map<String, dynamic>> add(Member member) async {
    final List<dynamic> result = await MemberService().addMember(member);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> edit(Member member) async {
    final List<dynamic> result = await MemberService().editMember(member);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> delete(String id) async {
    final List<dynamic> result = await MemberService().deleteMember(id);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }
}
