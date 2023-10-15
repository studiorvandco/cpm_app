enum RouterRoute {
  // Projects
  projects('Projects', '/projects'),
  episodes('Episodes', 'episodes'),
  sequences('Sequences', 'sequences'),
  shots('Shots', 'shots'),
  schedule('Schedule', 'schedule'),
  
  // Members
  members('members', 'members'),

  // Locations
  locations('locations', 'locations'),

  // Other
  settings('Settings', '/settings'),
  ;

  final String name;
  final String path;

  const RouterRoute(this.name, this.path);
}
