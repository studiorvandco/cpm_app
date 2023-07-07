import 'package:cpm/services/delete_service.dart';
import 'package:cpm/services/insert_service.dart';
import 'package:cpm/services/select/select_episode_service.dart';
import 'package:cpm/services/select/select_project_service.dart';
import 'package:cpm/services/update_service.dart';

mixin BaseProvider {
  final SelectProjectService selectProjectService = SelectProjectService();
  final SelectEpisodeService selectEpisodeService = SelectEpisodeService();

  final InsertService insertService = InsertService();

  final UpdateService updateService = UpdateService();

  final DeleteService deleteService = DeleteService();
}
