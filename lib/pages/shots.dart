import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shot.dart';
import '../providers/shots.dart';
import '../widgets/cards/shot.dart';
import '../widgets/info_headers/sequence.dart';
import '../widgets/request_placeholder.dart';

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
            body: ref.watch(currentShotsProvider).when(data: (List<Shot> shots) {
              return Column(
                children: <Widget>[
                  const InfoHeaderSequence(),
                  ...shots.map((Shot shot) => ShotCard(shot: shot, onPressed: () {}))
                ],
              );
            }, error: (Object error, StackTrace stackTrace) {
              return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
            }, loading: () {
              return const RequestPlaceholder(placeholder: CircularProgressIndicator());
            })));
  }

  void addShot() {
    print('TODO');
  }
}
