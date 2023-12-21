import 'package:lexo_rank_generator/lexo_rank_generator.dart';

class LexoRanker {
  static final LexoRanker _singleton = LexoRanker._internal();

  factory LexoRanker() {
    return _singleton;
  }

  LexoRanker._internal();

  final defaultRank = 'mmmmmmmmmm';

  late final LexoRank _lexoRank;

  Future<void> init() async {
    _lexoRank = const LexoRank();
  }

  String newRank({String? previous, String? next}) {
    if (previous == null && next == null) {
      return defaultRank;
    } else if (next == null) {
      final rank = previous!;

      return _lexoRank.nextLexo(previous!);
    } else if (previous == null) {
      return _lexoRank.prevLexo(next);
    } else {
      return _lexoRank.getRankBetween(firstRank: previous, secondRank: next);
    }
  }
}
