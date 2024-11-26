import 'package:flutter/material.dart';

import 'circle.dart';
import 'cross.dart';

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth * 0.75;
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 9,
              itemBuilder: (context, index) {
                return _Box(
                  row: index ~/ 3,
                  column: index % 3,
                  size: size,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _Box extends StatelessWidget {
  final int row;
  final int column;
  final double size;
  const _Box(
      {super.key, required this.row, required this.column, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size / 3,
      height: size / 3,
      decoration: BoxDecoration(
        border: _getBorder(),
      ),
      child: Center(
        child: _getChild(),
      ),
    );
  }

  _getBorder() {
    return Border(
      top: row != 0
          ? const BorderSide(
              color: Colors.white,
            )
          : BorderSide.none,
      right:
          column != 2 ? const BorderSide(color: Colors.white) : BorderSide.none,
      bottom:
          row != 2 ? const BorderSide(color: Colors.white) : BorderSide.none,
      left:
          column != 0 ? const BorderSide(color: Colors.white) : BorderSide.none,
    );
  }

  _getChild() {
    if ((row + column) % 2 == 0) {
      return const Cross();
    } else {
      return const Circle();
    }
  }
}
