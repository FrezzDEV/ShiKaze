import Fastify from 'fastify';
import { registerMangaRoutes } from './modules/manga/manga.routes.js';

const app = Fastify({ logger: true });

app.get('/health', async () => ({ status: 'ok', service: 'shikaze-api' }));
registerMangaRoutes(app);

const port = Number(process.env.PORT ?? 3000);
const host = process.env.HOST ?? '0.0.0.0';

await app.listen({ port, host });
