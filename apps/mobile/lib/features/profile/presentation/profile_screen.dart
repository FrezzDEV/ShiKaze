import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/shikaze_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(index: 3, onChanged: (i) {
        const routes = ['/', '/library', '/history', '/profile'];
        context.go(routes[i]);
      }),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(22, 18, 22, 0), child: Text('Профиль', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, letterSpacing: -0.7))),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE9E6DF))),
                child: const Row(children: [CircleAvatar(radius: 25, backgroundColor: Color(0xFFEDE9E1), child: Icon(Icons.person_outline_rounded, color: Color(0xFF4D4A45))), SizedBox(width: 14), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Гость', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)), SizedBox(height: 4), Text('Настрой приложение под себя', style: TextStyle(fontSize: 12, color: Color(0xFF77736B)))])]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
