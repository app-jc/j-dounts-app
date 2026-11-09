import 'package:flutter/material.dart';

class StaggeredEntrance extends StatelessWidget {
  const StaggeredEntrance({
    required this.entrance,
    required this.child,
    super.key,
  });

  final Animation<double> entrance;
  final Widget child;

  @override
  Widget build(BuildContext context) => SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0, 0.14),
      end: Offset.zero,
    ).animate(entrance),
    child: FadeTransition(opacity: entrance, child: child),
  );
}
