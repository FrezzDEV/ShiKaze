export interface MangaSourceAdapter {
  readonly sourceId: string;
  search(query: string): Promise<SourceSearchResult[]>;
  getManga(externalId: string): Promise<SourceManga>;
  getChapters(externalMangaId: string): Promise<SourceChapter[]>;
  getPages(externalChapterId: string): Promise<SourcePage[]>;
}

export interface SourceSearchResult {
  externalId: string;
  title: string;
  url?: string;
}

export interface SourceManga {
  externalId: string;
  title: string;
  description?: string;
  coverUrl?: string;
}

export interface SourceChapter {
  externalId: string;
  number: number;
  title?: string;
  publishedAt?: string;
}

export interface SourcePage {
  number: number;
  url: string;
}
