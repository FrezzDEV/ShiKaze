import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_providers.dart';
import '../domain/entities/manga.dart';

final mangaViewModelProvider =
    AsyncNotifierProvider<MangaViewModel, List<Manga>>(MangaViewModel.new);

class MangaViewModel extends AsyncNotifier<List<Manga>> {
  @override
  Future<List<Manga>> build() {
    return ref.read(mangaRepositoryProvider).getPopular();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(mangaRepositoryProvider).getPopular(),
    );
  }
}
