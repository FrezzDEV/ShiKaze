import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/shikaze_components.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(index: 2, onChanged: (i) {
        const routes = ['/', '/library', '/history', '/profile'];
        context.go(routes[i]);
      }),
      body: SafeArea(
        bottom: false,
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(22, 18, 22, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'История',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, letterSpacing: -0.7),
                ),
              ),
            ),
            Expanded(
              child: EmptyState(
                icon: Icons.schedule_rounded,
                title: 'История',
                message: 'Здесь появится\nистория чтения.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
