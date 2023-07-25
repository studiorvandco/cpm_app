import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';

class SelectSequenceService extends SelectService {
  SupabaseTable table = SupabaseTable.sequence;

  Future<List<Sequence>> selectSequences(int? episodeId) async {
    return await select<Sequence>(
      await supabase.from(table.name).select('*').eq('episode', episodeId).order('index', ascending: true),
      Sequence.fromJson,
      addNumberByIndex: true,
    );
  }
}
