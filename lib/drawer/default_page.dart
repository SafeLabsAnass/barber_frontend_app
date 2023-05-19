import 'package:flutter/material.dart';


class DefaultPage extends StatelessWidget {
  final Widget child;
  final int index;
  final double yOffset;
  final double xOffset;
  final double scaleFactor;
  final bool isDrawerOpen;
  final VoidCallback onClose;
  const DefaultPage(
      {super.key,
      required this.child,
      required this.index,
      required this.yOffset,
      required this.xOffset,
      required this.scaleFactor,
      required this.isDrawerOpen,
       required this.onClose}
     );
      

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: const Duration(milliseconds: 400),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isDrawerOpen ? 30 : 0.0),
        child: Stack(
          children: [
            DefaultTabController(
            length: 4,
            initialIndex: index,
            child: child,
          ),
              if (isDrawerOpen)
      GestureDetector(
        onTap: () {
         
          onClose(); 
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
        ),
      ),
          ]
        ),
      ),
    );
  }
}
