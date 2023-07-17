import '../models/project/link.dart';

extension ListHelpers<T> on List<T> {
  void move(int from, int to) {
    RangeError.checkValidIndex(from, this, "from", length);
    RangeError.checkValidIndex(to, this, "to", length);
    var element = this[from];
    if (from < to) {
      setRange(from, to, this, from + 1);
    } else {
      setRange(to + 1, from + 1, this, to);
    }
    this[to] = element;
  }

  int get nextIndex {
    assert(runtimeType == List<Link>);

    if (length == 0) {
      return 1;
    }

    int maxIndex = 2;
    forEach((link) {
      if ((link as Link).index != null && link.index! > maxIndex) {
        maxIndex = link.index!;
      }
    });

    return maxIndex + 1;
  }
}
