import 'package:flutter/material.dart';
import 'package:maze/dfs_algo.dart';
import 'package:maze/mazegrid.dart';

class MazeSolverApp extends StatefulWidget {
  @override
  _MazeSolverAppState createState() => _MazeSolverAppState();
}

class _MazeSolverAppState extends State<MazeSolverApp> {
  List<List<int>> grid = List.generate(10, (_) => List.filled(10, 0));
  int startX = 0, startY = 0, endX = 9, endY = 9;

  void updateGrid() {
    setState(() {});
  }

  void onCellTap(int row, int col) {
    setState(() {
      if (grid[row][col] == 0) {
        grid[row][col] = 1; // Wall
      } else if (grid[row][col] == 1) {
        grid[row][col] = 0; // Empty
      }
    });
  }

  void solveMaze() {
    solveMazeDFS(grid, startX, startY, endX, endY, updateGrid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Maze Solver")),
      body: Column(
        children: [
          Expanded(child: MazeGrid(grid: grid, onTap: onCellTap)),
          ElevatedButton(onPressed: solveMaze, child: Text("Solve Maze")),
        ],
      ),
    );
  }
}
