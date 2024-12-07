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
  bool hoverCell = false;

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
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            hoverCell = true;
          });
        },
        onExit: (_) {
          setState(() {
            hoverCell = false;
          });
        },
        child: GestureDetector(
          onTap: () {
            setState(() {
              color = widget.onTap(widget.x, widget.y) ? Colors.green : Colors.white;
            });
          },
          child: Stack(
            children: [
              SizedBox(
                height: widget.size,
                width: widget.size,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFF3F3F3)),
                    color: color,
                  ),
                ),
              ),

              // For hover effect
              if (hoverCell) Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
