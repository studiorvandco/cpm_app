enum Asset {
  flutter('logos/cpm_light_1024.png'),
  ;

  final _basePath = 'assets';

  final String filePath;

  const Asset(this.filePath);

  String get path => '$_basePath/$filePath';
}
