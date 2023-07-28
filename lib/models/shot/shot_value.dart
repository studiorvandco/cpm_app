import 'dart:ui';

enum ShotValue {
  full('Full', Color(0xFFff69b4)),
  mediumFull('Medium full', Color(0xFF7f0000)),
  cowboy('Cowboy', Color(0xFF008000)),
  medium('Medium', Color(0xFF000080)),
  mediumCloseup('Medium closeup', Color(0xFFff8c00)),
  closeup('Closeup', Color(0xFFffff00)),
  extremeCloseup('Extreme closeup', Color(0xFF00ff00)),
  insert('Insert', Color(0xFF00ffff)),
  sequence('Sequence', Color(0xFFff00ff)),
  landscape('Landscape', Color(0xFF1e90ff)),
  drone('Drone', Color(0xFFffdead)),
  other('Other', Color(0xFF2f4f4f)),
  ;

  final String label;
  final Color color;

  const ShotValue(this.label, this.color);
}
