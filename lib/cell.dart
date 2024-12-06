import 'package:flutter/material.dart';

class Cell extends StatefulWidget {
  const Cell({
    super.key,
    required this.x,
    required this.y,
    required this.size,
    required this.onTap,
    required this.isAlive,
  });

  final int x;
  final int y;
  final double size;
  final bool isAlive;
  final Function(int, int) onTap;

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  Color color = Colors.white;

  @override
  initState() {
    super.initState();
    color = widget.isAlive ? Colors.green : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.x * widget.size,
      top: widget.y * widget.size,
      child: GestureDetector(
        onTap: () {
          setState(() {
            color = widget.onTap(widget.x, widget.y) ? Colors.green : Colors.white;
          });
        },
        child: SizedBox(
          height: widget.size,
          width: widget.size,
          child: ColoredBox(
            color: color,
            child: Center(
              child: Text('${widget.x}, ${widget.y}', style: const TextStyle(fontSize: 8),),
            ),
          ),
        ),
      ),
    );
  }
}
