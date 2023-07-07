import 'package:cpm/models/project/link.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';
import 'package:cpm/utils/constants_globals.dart';

class SelectProjectService {
  Future<List<Project>> selectProjects() async {
    return await SelectService().select(
      await supabase.from(SupabaseTable.project.name).select('*'),
      Project.fromJson,
    );
  }

  Future<List<Link>> selectLinks(int id) async {
    return await SelectService().select(
      await supabase.from(SupabaseTable.link.name).select('*').eq('project', id),
      Link.fromJson,
    );
  }
}
