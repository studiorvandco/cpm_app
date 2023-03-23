import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils.dart';

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
