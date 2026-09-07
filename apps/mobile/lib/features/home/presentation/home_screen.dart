import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/shikaze_components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(index: 0, onChanged: (i) {
        const routes = ['/', '/library', '/history', '/profile'];
        context.go(routes[i]);
      }),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(22, 14, 22, 0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    const Text('ShiKaze', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, letterSpacing: -0.7)),
                    const Spacer(),
                    const RoundIconButton(icon: Icons.search_rounded),
                    const SizedBox(width: 8),
                    RoundIconButton(icon: Icons.wb_sunny_outlined, onTap: () {}),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(14, 18, 14, 0),
              sliver: SliverToBoxAdapter(child: _HeroBanner(onContinue: () => context.push('/reader'))),
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(22, 22, 22, 0),
              sliver: SliverToBoxAdapter(child: SectionHeader(title: 'Продолжить', action: 'Все')),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              sliver: SliverToBoxAdapter(child: _ContinueCard(onTap: () => context.push('/reader'))),
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(22, 22, 22, 10),
              sliver: SliverToBoxAdapter(child: SectionHeader(title: 'Популярное', action: 'Смотреть все')),
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              sliver: SliverToBoxAdapter(child: _PopularRow()),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 22)),
          ],
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.onContinue});
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      decoration: BoxDecoration(
        color: const Color(0xFFEFE9DF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6E0D6)),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: MangaArt(height: 235, radius: 18, dark: false, label: '漫')),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.white.withValues(alpha: 0.96), Colors.white.withValues(alpha: 0.66), Colors.transparent],
                  stops: const [0, 0.48, 1],
                ),
              ),
            ),
          ),
          Positioned(
            left: 18,
            top: 22,
            width: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('MANGA READER', style: TextStyle(fontSize: 11, letterSpacing: 0.5, color: Color(0xFF55514A))),
                const SizedBox(height: 8),
                const Text('Читай там,\nгде удобно.', style: TextStyle(fontSize: 27, height: 1.02, fontWeight: FontWeight.w800, letterSpacing: -0.8)),
                const SizedBox(height: 12),
                const Text('Продолжай чтение, открывай\nновые серии и сохраняй любимую\nмангу в одном месте.', style: TextStyle(fontSize: 12.5, height: 1.35, color: Color(0xFF68645D))),
                const SizedBox(height: 17),
                FilledButton.icon(
                  onPressed: onContinue,
                  style: FilledButton.styleFrom(backgroundColor: const Color(0xFF171717), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  icon: const Icon(Icons.arrow_forward_rounded, size: 17),
                  label: const Text('Продолжить чтение', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          const Positioned(right: 28, top: 65, child: _CircleMark()),
        ],
      ),
    );
  }
}

class _CircleMark extends StatelessWidget {
  const _CircleMark();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94,
      height: 94,
      decoration: const BoxDecoration(color: Color(0xFFF8F5EE), shape: BoxShape.circle),
      child: const Center(child: Text('漫', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w300))),
    );
  }
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 122,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE9E6DF))),
          child: Row(
            children: [
              const SizedBox(width: 105, height: 102, child: MangaArt(height: 102, radius: 10, label: '呪')),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Последнее чтение', style: TextStyle(fontSize: 10, color: Color(0xFF77736B))),
                    SizedBox(height: 5),
                    Text('Jujutsu Kaisen', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(height: 5),
                    Text('Chapter 271', style: TextStyle(fontSize: 12, color: Color(0xFF45423D))),
                    SizedBox(height: 10),
                    ClipRRect(borderRadius: BorderRadius.all(Radius.circular(9)), child: LinearProgressIndicator(value: 0.68, minHeight: 4, backgroundColor: Color(0xFFE7E4DE), valueColor: AlwaysStoppedAnimation(Color(0xFF252525)))),
                    SizedBox(height: 6),
                    Text('68% прочитано', style: TextStyle(fontSize: 10, color: Color(0xFF706C65))),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(width: 36, height: 36, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF4F2ED)), child: const Icon(Icons.arrow_forward_rounded, size: 19)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopularRow extends StatelessWidget {
  const _PopularRow();

  @override
  Widget build(BuildContext context) {
    const items = [('Jujutsu Kaisen', 'Chapter 271', '呪'), ('One Piece', 'Chapter 1160', '航'), ('Chainsaw Man', 'Chapter 221', '刃')];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MangaArt(height: 190, radius: 11, label: items[i].$3, dark: i == 0),
                const SizedBox(height: 8),
                Text(items[i].$1, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(items[i].$2, style: const TextStyle(fontSize: 10.5, color: Color(0xFF69655E))),
              ],
            ),
          ),
          if (i < items.length - 1) const SizedBox(width: 10),
        ],
      ],
    );
  }
}
