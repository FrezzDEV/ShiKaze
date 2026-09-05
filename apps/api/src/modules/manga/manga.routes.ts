import type { FastifyInstance } from 'fastify';

export async function registerMangaRoutes(app: FastifyInstance): Promise<void> {
  app.get('/api/v1/manga/popular', async (request) => {
    const query = request.query as { limit?: string };
    const limit = Math.min(Math.max(Number(query.limit ?? 20), 1), 100);
    return [] as Array<{ id: string; title: string }>;
  });

  app.get('/api/v1/manga/:id', async () => null);

  app.get('/api/v1/search', async () => []);
}
