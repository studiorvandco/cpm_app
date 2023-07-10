import 'package:cpm/models/member/member.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';
import 'package:cpm/utils/constants_globals.dart';

class SelectMemberService extends SelectService {
  SupabaseTable table = SupabaseTable.member;

  Future<List<Member>> selectMembers() async {
    return await select<Member>(
      await supabase.from(table.name).select('*'),
      Member.fromJson,
    );
  }
}
