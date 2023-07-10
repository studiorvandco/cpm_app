import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';
import 'package:cpm/utils/constants_globals.dart';

class SelectShotService extends SelectService {
  SupabaseTable table = SupabaseTable.shot;

  Future<List<Shot>> selectShots(int? sequenceId) async {
    return await select<Shot>(
      await supabase.from(table.name).select('*').eq('sequence', sequenceId),
      Shot.fromJson,
    );
  }
}
