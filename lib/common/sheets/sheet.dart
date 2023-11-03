import 'package:flutter/material.dart';

class Sheet extends StatefulWidget {
  Sheet({
    super.key,
    required this.tabs,
    this.icons,
  }) {
    if (icons != null && icons!.length != tabs.length) throw ArgumentError();
  }

  final List<Widget> tabs;
  final List<IconData>? icons;

  @override
  State<Sheet> createState() => _SheetState();
}

class _SheetState extends State<Sheet> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.icons == null) {
      return widget.tabs.first;
    } else {
      final tabController = TabController(length: widget.icons!.length, vsync: this);

      return DefaultTabController(
        length: widget.icons!.length,
        child: Wrap(
          children: [
            TabBar(
              controller: tabController,
              tabs: widget.icons!.map((icon) {
                return Tab(icon: Icon(icon));
              }).toList(),
            ),
            widget.tabs[tabController.index],
          ],
        ),
      );
    }
  }
}
