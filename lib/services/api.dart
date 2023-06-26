import 'config.dart';

class API {
  final String authorization = 'Authorization';
  final String bearer = 'Bearer ';

  late final String login;
  late final String projects;
  late final String episodes;
  late final String sequences;
  late final String shots;
  late final String members;
  late final String locations;

  late final String _apiUrl;

  API() {
    String configApiUrl = Config.get('api')['url'] as String;
    _apiUrl = '$configApiUrl${configApiUrl.endsWith('/') ? '' : '/'}';
    login = '${_apiUrl}Login/login';
    projects = '${_apiUrl}Projects';
    episodes = '${_apiUrl}Episodes';
    sequences = '${_apiUrl}Sequences';
    shots = '${_apiUrl}Shots';
    members = '${_apiUrl}Members';
    locations = '${_apiUrl}Locations';
  }
}
