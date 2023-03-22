import 'package:flutter/material.dart';

import '../models/episode.dart';
import '../models/sequence.dart';

class Sequences extends StatefulWidget {
  const Sequences({super.key, required this.openShots, required this.episode});

  final void Function(Sequence sequence) openShots;

  final Episode episode;

  @override
  State<Sequences> createState() => _SequencesState();
}

class _SequencesState extends State<Sequences> {
  @override
  Widget build(BuildContext context) {
    return Text('TODO');
    /*
    return Expanded(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addSequence,
        child: const Icon(Icons.add),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: <Widget>[
              if (widget.project.isMovie())
                InfoHeaderProject(project: widget.project)
              else
                InfoHeaderEpisode(projectID: widget.project.id, episode: widget.episode),
              if (widget.episode.sequences.isEmpty)
                Expanded(
                  child: RequestPlaceholder(placeholder: Text('sequences.no_sequences'.tr())),
                )
              else
                Expanded(
                    child: ListView(
                        padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64),
                        children: <SequenceCard>[
                      ...widget.episode.sequences.map((Sequence sequence) {
                        return SequenceCard(
                          sequence: sequence,
                          openShots: () {
                            widget.openShots(sequence);
                          },
                        );
                      })
                    ]))
            ],
          );
        },
      ),
    ));

     */
  }

  void addSequence() {
    print('TODO');
  }
}
