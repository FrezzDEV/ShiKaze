class Manga {
  const Manga({
    required this.id,
    required this.title,
    this.description,
    this.coverPath,
  });

  final String id;
  final String title;
  final String? description;
  final String? coverPath;
}
