import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/shikaze_components.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(index: 1, onChanged: (i) {
        const routes = ['/', '/library', '/history', '/profile'];
        context.go(routes[i]);
      }),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(22, 18, 22, 0),
              child: Align(alignment: Alignment.centerLeft, child: Text('Библиотека', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, letterSpacing: -0.7))),
            ),
            Expanded(child: EmptyState(icon: Icons.grid_view_rounded, title: 'Библиотека', message: 'Здесь будут твои\nсохранённые серии.')),
          ],
        ),
      ),
    );
  }
}
