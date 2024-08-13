class LogoModel {
  final String description;
  final String assetPath;
  final String roadmapPath;
  final String tag;

  LogoModel({
    required this.tag,
    required this.description,
    required this.roadmapPath,
    this.assetPath = '',
  });
}
