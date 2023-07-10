import 'package:cpm/models/location/location.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';
import 'package:cpm/utils/constants_globals.dart';

class SelectLocationService extends SelectService {
  SupabaseTable table = SupabaseTable.shot;

  Future<List<Location>> selectLocations() async {
    return await select<Location>(
      await supabase.from(table.name).select('*'),
      Location.fromJson,
    );
  }
}
