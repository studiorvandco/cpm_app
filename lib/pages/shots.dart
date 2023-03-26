import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/shot.dart';
import '../providers/navigation.dart';
import '../providers/shots.dart';
import '../utils/constants_globals.dart';
import '../widgets/cards/shot.dart';
import '../widgets/info_headers/sequence.dart';

class Shots extends ConsumerStatefulWidget {
  const Shots({super.key});

  @override
  ConsumerState<Shots> createState() => _ShotsState();
}

class _ShotsState extends ConsumerState<Shots> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackButton,
      child: Expanded(
          child: Scaffold(
              floatingActionButton: FloatingActionButton(onPressed: addShot, child: const Icon(Icons.add)),
              body: ref.watch(shotsProvider).when(data: (List<Shot> shots) {
                return Column(
                  children: <Widget>[
                    const InfoHeaderSequence(),
                    LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return MasonryGridView.count(
                          itemCount: shots.length,
                          padding: const EdgeInsets.only(
                              bottom: kFloatingActionButtonMargin + 64, top: 4, left: 4, right: 4),
                          itemBuilder: (BuildContext context, int index) {
                            return ShotCard(shot: shots[index], onPressed: () {});
                          },
                          crossAxisCount: getColumnsCount(constraints),
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        );
                      },
                    ),
                  ],
                );
              }, error: (Object error, StackTrace stackTrace) {
                return requestPlaceholderError;
              }, loading: () {
                return requestPlaceholderLoading;
              }))),
    );
  }

  Future<bool> handleBackButton() {
    ref.read(homePageNavigationProvider.notifier).set(HomePage.sequences);
    return Future<bool>(() => false);
  }

  void addShot() {
    print('TODO');
  }
}
