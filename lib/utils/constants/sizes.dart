enum Sizes {
  custom(0),
  size2(2),
  size4(4),
  size8(8),
  size16(16),
  size32(32),
  size64(64),
  size128(128),
  size256(256),
  size512(512),
  size1024(1024),
  ;

  final double size;

  double get zero => 0;

  double get infinity => double.infinity;

  double get dialog => 512;

  double get links => 34;

  const Sizes(this.size);
}
