import '../models/base_model.dart';
import 'config/supabase_table.dart';
import 'service.dart';

class InsertService extends Service {
  Future<void> insert(SupabaseTable table, BaseModel model) async {
    await supabase.from(table.name).insert(model.toJson());
  }
}
