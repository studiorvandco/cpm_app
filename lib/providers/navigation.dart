import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/constants_globals.dart';

part 'navigation.g.dart';

@riverpod
class HomePageNavigation extends _$HomePageNavigation {
  @override
  HomePage build() {
    return HomePage.projects;
  }

  void set(HomePage page) {
    state = page;
  }
}
