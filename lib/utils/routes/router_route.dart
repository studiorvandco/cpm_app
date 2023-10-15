enum RouterRoute {
  home('Home', '/home'),
  settings('Settings', '/settings'),
  ;

  final String name;
  final String path;

  const RouterRoute(this.name, this.path);
}
