import '../entities/manga.dart';

abstract interface class MangaRepository {
  Future<Manga?> getById(String id);
  Future<List<Manga>> getPopular({int limit = 20});
  Future<List<Manga>> search(String query, {int limit = 20});
}
