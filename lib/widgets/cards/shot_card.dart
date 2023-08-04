import 'package:cpm/extensions/color_helpers.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/widgets/info_sheets/shot_info_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShotCard extends ConsumerStatefulWidget {
  const ShotCard({super.key, required this.shot});

  final Shot shot;

  @override
  ConsumerState<ShotCard> createState() => _ShotCardState();
}

class _ShotCardState extends ConsumerState<ShotCard> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.shot.completed;
  }

  void _complete(bool? checked) {
    if (checked != null) {
      setState(() {
        isCompleted = checked;
      });
    }
  }

  Widget _buildCard([Widget? expansion]) {
    return Card(
      key: const ValueKey<bool>(true),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: _showDetails,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Badge(
                    label: Text(widget.shot.getNumber),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 4.0)),
                  Badge(
                    label: Text(widget.shot.getValue),
                    backgroundColor: widget.shot.value?.color,
                    textColor: widget.shot.value!.color.getColorByLuminance(context),
                  ),
                  const Spacer(),
                  Checkbox(value: isCompleted, onChanged: _complete),
                ],
              ),
              if (expansion != null) expansion,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansion() {
    return Text(
      widget.shot.getDescription,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }

  void _showDetails() {
    ref.read(currentShotProvider.notifier).set(widget.shot);
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return const ShotInfoSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 250),
      firstCurve: Curves.easeInOut,
      secondCurve: Curves.easeInOut,
      sizeCurve: Curves.easeInOut,
      firstChild: _buildCard(),
      secondChild: _buildCard(_buildExpansion()),
      crossFadeState: isCompleted ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
