import 'dart:io';

abstract interface class ImageStorage {
  Future<void> put({required String path, required File file});
  Future<void> delete(String path);
  String publicUrl(String path);
}
