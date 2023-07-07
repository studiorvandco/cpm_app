import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';
import 'package:cpm/utils/constants_globals.dart';

import '../../models/episode/episode.dart';

class SelectEpisodeService extends SelectService {
  SupabaseTable table = SupabaseTable.episode;

  Future<List<Episode>> selectEpisodes(int? projectId) async {
    return await select<Episode>(
      await supabase.from(table.name).select('*').eq('project', projectId),
      Episode.fromJson,
    );
  }
}
