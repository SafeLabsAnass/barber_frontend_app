import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DefaultPage extends StatelessWidget {
  final Widget child;
  final int index;
  final double yOffset;
  final double xOffset;
  final double scaleFactor;
  final bool isDrawerOpen;
  const DefaultPage(
      {super.key,
      required this.child,
      required this.index,
      required this.yOffset,
      required this.xOffset,
      required this.scaleFactor,
      required this.isDrawerOpen});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: const Duration(milliseconds: 400),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isDrawerOpen ? 30 : 0.0),
        child: DefaultTabController(
          length: 4,
          initialIndex: index,
          child: child,
        ),
      ),
    );
  }
}
