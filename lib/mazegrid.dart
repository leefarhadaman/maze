import 'package:flutter/material.dart';

class MazeGrid extends StatelessWidget {
  final List<List<int>> grid;
  final Function(int, int) onTap;

  MazeGrid({required this.grid, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: grid[0].length, // Columns
      ),
      itemCount: grid.length * grid[0].length,
      itemBuilder: (context, index) {
        int row = index ~/ grid[0].length;
        int col = index % grid[0].length;
        return GestureDetector(
          onTap: () => onTap(row, col),
          child: Container(
            margin: EdgeInsets.all(1),
            color: _getCellColor(grid[row][col]),
          ),
        );
      },
    );
  }

  Color _getCellColor(int value) {
    switch (value) {
      case 0: return Colors.white;
      case 1: return Colors.black;
      case 2: return Colors.green;
      case 3: return Colors.red;
      case 4: return Colors.blue.withOpacity(0.5); // Visited
      case 5: return Colors.yellow; // Path
      default: return Colors.grey;
    }
  }
}
