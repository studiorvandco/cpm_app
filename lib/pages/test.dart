import 'package:flutter/material.dart';

import '../dialogs/new_edit_location.dart';
import '../dialogs/new_edit_member.dart';
import '../dialogs/new_episode.dart';
import '../dialogs/new_project.dart';
import '../dialogs/new_sequence.dart';
import '../dialogs/new_shot.dart';
import '../widgets/tabbed_info_sheet.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const TabbedInfoSheet();
                });
          },
          child: const Text('Bottom sheet')),
      TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const NewSequenceDialog(locations: [
                    'Maison de Bastien1',
                    'Maison de Bastien2',
                    'Maison de Bastien3',
                    'Maison de Bastien4',
                    'Maison de Bastien5',
                    'Maison de Bastien6',
                  ]);
                });
          },
          child: const Text('New Sequence')),
      TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const NewProjectDialog();
                });
          },
          child: const Text('New Project')),
      TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const NewShotDialog();
                });
          },
          child: const Text('New Shot')),
      TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const NewEpisodeDialog();
                });
          },
          child: const Text('New episode')),
      TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const MemberDialog(edit: false);
                });
          },
          child: const Text('New member')),
      TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MemberDialog(
                      edit: true,
                      name: 'Damian',
                      telephone: '0836656565',
                      image: Image.asset('assets/logo-cpm-alpha.png'));
                });
          },
          child: const Text('Edit member')),
      TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const LocationDialog(
                    edit: false,
                  );
                });
          },
          child: const Text('New location')),
      TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LocationDialog(
                    edit: true,
                    name: 'Tour Perret',
                    link: 'https://goo.gl/maps/h781vPcmbBjHhqmY9',
                  );
                });
          },
          child: const Text('Edit location')),
    ]);
  }
}
