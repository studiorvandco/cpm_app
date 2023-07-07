import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/utils/constants_globals.dart';

import '../models/base_model.dart';

class InsertService {
  Future<void> insert(SupabaseTable table, BaseModel model) async {
    await supabase.from(table.name).insert(model.toJson());
  }
}
