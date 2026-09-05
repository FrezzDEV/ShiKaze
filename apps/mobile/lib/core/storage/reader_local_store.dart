import 'dart:typed_data';

abstract interface class ReaderLocalStore {
  Future<void> savePage({
    required String chapterId,
    required int pageNumber,
    required Uint8List bytes,
  });

  Future<bool> hasPage({required String chapterId, required int pageNumber});

  Future<void> removeChapter(String chapterId);
}
