import 'package:flutter/material.dart';

class MangaArt extends StatelessWidget {
  const MangaArt({super.key, this.height = 160, this.radius = 16, this.label = '漫', this.dark = false});

  final double height;
  final double radius;
  final String label;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: dark
                ? const [Color(0xFF101010), Color(0xFF3F2826), Color(0xFF120F0E)]
                : const [Color(0xFFDDB6A7), Color(0xFF70463D), Color(0xFF161313)],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: -24,
              top: 22,
              child: Transform.rotate(
                angle: -0.23,
                child: Container(
                  width: 190,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.46),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -42,
              bottom: 24,
              child: Transform.rotate(
                angle: -0.72,
                child: Container(
                  width: 190,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9B58E).withOpacity(0.48),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.96),
                  fontSize: height * 0.34,
                  fontWeight: FontWeight.w300,
                  shadows: const [Shadow(blurRadius: 14, color: Colors.black54)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({super.key, required this.icon, this.onTap, this.dark = false});

  final IconData icon;
  final VoidCallback? onTap;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: dark ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.74),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: dark ? Colors.white : const Color(0xFF171717), size: 21),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.action});

  final String title;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const Spacer(),
        if (action != null)
          Text(action!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF303030))),
      ],
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  static const items = <(IconData, String)>[
    (Icons.home_rounded, 'Главная'),
    (Icons.grid_view_rounded, 'Библиотека'),
    (Icons.schedule_rounded, 'История'),
    (Icons.person_outline_rounded, 'Профиль'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(12, 6, 12, 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.84),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE7E4DE)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: index == i ? const Color(0xFFF1F0EC) : Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(items[i].$1, size: 22, color: index == i ? const Color(0xFF171717) : const Color(0xFF77736B)),
                        const SizedBox(height: 3),
                        Text(
                          items[i].$2,
                          style: TextStyle(
                            fontSize: 10,
                            color: index == i ? const Color(0xFF171717) : const Color(0xFF77736B),
                            fontWeight: index == i ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.title, required this.message});

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE9E6DF)),
              ),
              child: Icon(icon, size: 43, color: const Color(0xFFB8B4AC)),
            ),
            const SizedBox(height: 22),
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, height: 1.45, color: Color(0xFF66635D)),
            ),
          ],
        ),
      ),
    );
  }
}
