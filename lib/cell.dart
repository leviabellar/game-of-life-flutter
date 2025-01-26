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

class _CellState extends State<Cell> with SingleTickerProviderStateMixin {
  Color color = Colors.white;
  bool hoverCell = false;
  late AnimationController _controller;

  @override
  initState() {
    super.initState();
    color = widget.isAlive ? Colors.green : Colors.white;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 250),
      value: 1,
    );
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
              if (widget.onTap(widget.x, widget.y)) {
                color = Colors.green;
                _controller.forward(from: 0);
              } else {
                _controller.reverse(from: 1).then((value) => color = Colors.white);
              }
            });
          },
          child: Stack(
            children: [
              ScaleTransition(
                scale: CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeOutCirc,
                  reverseCurve: Curves.easeOutQuint,
                ),
                child: SizedBox(
                  height: widget.size,
                  width: widget.size,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFF3F3F3)),
                      color: color,
                    ),
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
