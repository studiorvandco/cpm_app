import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shot.dart';
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
    return Expanded(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(onPressed: addShot, child: const Icon(Icons.add)),
            body: ref.watch(shotsProvider).when(data: (List<Shot> shots) {
              return Column(
                children: <Widget>[
                  const InfoHeaderSequence(),
                  ...shots.map((Shot shot) => ShotCard(shot: shot, onPressed: () {}))
                ],
              );
            }, error: (Object error, StackTrace stackTrace) {
              return requestPlaceholderError;
            }, loading: () {
              return requestPlaceholderLoading;
            })));
  }

  void addShot() {
    print('TODO');
  }
}
