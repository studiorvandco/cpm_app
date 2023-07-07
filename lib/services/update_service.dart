import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/utils/constants_globals.dart';

import '../models/base_model.dart';

class UpdateService {
  Future<void> update(SupabaseTable table, int id, BaseModel model) async {
    await supabase.from(table.name).update(model.toJson()).match({'id': id});
  }
}
