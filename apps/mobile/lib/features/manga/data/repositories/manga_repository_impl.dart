import '../../../core/network/api_client.dart';
import '../../domain/entities/manga.dart';
import '../../domain/repositories/manga_repository.dart';

class MangaRepositoryImpl implements MangaRepository {
  MangaRepositoryImpl(this._client);

  final ApiClient _client;

  @override
  Future<Manga?> getById(String id) async {
    final json = await _client.get<Map<String, dynamic>>('/api/v1/manga/$id');
    if (json == null) return null;
    return Manga(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      coverPath: json['coverPath'] as String?,
    );
  }

  @override
  Future<List<Manga>> getPopular({int limit = 20}) async {
    final items = await _client.get<List<dynamic>>(
      '/api/v1/manga/popular?limit=$limit',
    );
    return (items ?? const <dynamic>[])
        .map((item) => _fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  @override
  Future<List<Manga>> search(String query, {int limit = 20}) async {
    final items = await _client.get<List<dynamic>>(
      '/api/v1/search?q=${Uri.encodeQueryComponent(query)}&limit=$limit',
    );
    return (items ?? const <dynamic>[])
        .map((item) => _fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  Manga _fromJson(Map<String, dynamic> json) => Manga(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String?,
        coverPath: json['coverPath'] as String?,
      );
}
