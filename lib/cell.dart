import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  const Cell({
    super.key,
    required this.x,
    required this.y,
    required this.size,
  });

  final int x;
  final int y;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x * size,
      top: y * size,
      child: SizedBox(
        height: 30,
        width: 30,
        child: ColoredBox(
          color: Colors.white,
          child: Center(
            child: Text('$x, $y', style: const TextStyle(fontSize: 8),),
          ),
        ),
      ),
    );
  }
}
