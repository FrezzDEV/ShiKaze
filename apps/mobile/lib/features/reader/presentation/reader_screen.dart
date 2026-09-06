import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/shikaze_components.dart';

class ReaderScreen extends StatelessWidget {
  const ReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 68),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 415,
                          decoration: BoxDecoration(border: Border.all(color: const Color(0xFF49433F))),
                          child: const MangaArt(height: 415, radius: 0, label: '呪', dark: true),
                        ),
                        Container(
                          height: 128,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(16),
                          color: const Color(0xFFEDE5D8),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Container(height: 10, width: 165, decoration: BoxDecoration(color: const Color(0xFFC4B8A8), borderRadius: BorderRadius.circular(10))),
                            const SizedBox(height: 13),
                            Container(height: 9, width: 285, decoration: BoxDecoration(color: const Color(0xFFC4B8A8), borderRadius: BorderRadius.circular(10))),
                            const SizedBox(height: 13),
                            Container(height: 9, width: 230, decoration: BoxDecoration(color: const Color(0xFFC4B8A8), borderRadius: BorderRadius.circular(10))),
                            const SizedBox(height: 13),
                            Container(height: 9, width: 170, decoration: BoxDecoration(color: const Color(0xFFC4B8A8), borderRadius: BorderRadius.circular(10))),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        Container(margin: const EdgeInsets.symmetric(horizontal: 10), height: 420, child: const MangaArt(height: 420, radius: 0, label: '呪', dark: true)),
                        const SizedBox(height: 90),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  RoundIconButton(icon: Icons.arrow_back_ios_new_rounded, dark: true, onTap: () => context.pop()),
                  const Spacer(),
                  const Column(children: [Text('Jujutsu Kaisen', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)), SizedBox(height: 3), Text('Chapter 271', style: TextStyle(color: Color(0xFFB9B5B0), fontSize: 11))]),
                  const Spacer(),
                  RoundIconButton(icon: Icons.more_vert_rounded, dark: true, onTap: () {}),
                ],
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 10,
              child: Row(
                children: [
                  RoundIconButton(icon: Icons.chevron_left_rounded, dark: true, onTap: () {}),
                  const Spacer(),
                  const Text('1 / 24', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  RoundIconButton(icon: Icons.chevron_right_rounded, dark: true, onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
