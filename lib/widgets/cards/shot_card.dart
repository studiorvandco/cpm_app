import 'package:cpm/models/shot/shot.dart';
import 'package:flutter/material.dart';

class ShotCard extends StatefulWidget {
  const ShotCard({super.key, required this.shot});

  final Shot shot;

  @override
  State<ShotCard> createState() => _ShotCardState();
}

class _ShotCardState extends State<ShotCard> {
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
                    textColor: widget.shot.value!.color.computeLuminance() > 0.5
                        ? Theme.of(context).colorScheme.onInverseSurface
                        : Theme.of(context).colorScheme.onSurface,
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
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container();
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
