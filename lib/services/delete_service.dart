import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/utils/constants_globals.dart';

class DeleteService {
  Future<void> delete(SupabaseTable table, int? id) async {
    await supabase.from(table.name).delete().match({'id': id});
  }
}
