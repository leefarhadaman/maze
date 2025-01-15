import 'package:flutter/material.dart';

class MazeSolverApp extends StatefulWidget {
  @override
  _MazeSolverAppState createState() => _MazeSolverAppState();
}

class _MazeSolverAppState extends State<MazeSolverApp> {
  static const int empty = 0, wall = 1, start = 2, end = 3, visited = 4, path = 5;
  List<List<int>> grid = List.generate(10, (_) => List.filled(10, empty));
  String currentAction = "Add Walls"; // Default action
  int rows = 10;
  int cols = 10;

  void setCell(int row, int col) {
    setState(() {
      switch (currentAction) {
        case "Add Walls":
          grid[row][col] = wall;
          break;
        case "Set Start Point":
        // Ensure only one start point
          for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
              if (grid[i][j] == start) grid[i][j] = empty;
            }
          }
          grid[row][col] = start;
          break;
        case "Set End Point":
        // Ensure only one end point
          for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
              if (grid[i][j] == end) grid[i][j] = empty;
            }
          }
          grid[row][col] = end;
          break;
        default:
          break;
      }
    });
  }

  Color getCellColor(int value) {
    switch (value) {
      case empty:
        return Colors.white;
      case wall:
        return Colors.black;
      case start:
        return Colors.green;
      case end:
        return Colors.red;
      case visited:
        return Colors.blue.withOpacity(0.5);
      case path:
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  void clearGrid() {
    setState(() {
      grid = List.generate(rows, (_) => List.filled(cols, empty));
    });
  }

  void solveMaze() {
    // Add your maze-solving algorithm (DFS or BFS) here.
    // For now, this just marks some cells as visited for demo purposes.
    setState(() {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          if (grid[i][j] == empty) grid[i][j] = visited;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maze Solver"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => currentAction = "Add Walls"),
                  child: Text("Add Walls"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: currentAction == "Add Walls"
                          ? Colors.teal
                          : Colors.grey),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => currentAction = "Set Start Point"),
                  child: Text("Set Start Point"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: currentAction == "Set Start Point"
                          ? Colors.teal
                          : Colors.grey),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => currentAction = "Set End Point"),
                  child: Text("Set End Point"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: currentAction == "Set End Point"
                          ? Colors.teal
                          : Colors.grey),
                ),
                ElevatedButton(
                  onPressed: clearGrid,
                  child: Text("Clear Grid"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                ElevatedButton(
                  onPressed: solveMaze,
                  child: Text("Solve Maze"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ],
            ),
          ),

          // Legend
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LegendItem(color: Colors.white, label: "Empty"),
                LegendItem(color: Colors.black, label: "Wall"),
                LegendItem(color: Colors.green, label: "Start"),
                LegendItem(color: Colors.red, label: "End"),
                LegendItem(color: Colors.blue.withOpacity(0.5), label: "Visited"),
                LegendItem(color: Colors.yellow, label: "Path"),
              ],
            ),
          ),

          // Maze Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols, // Number of columns
              ),
              itemCount: rows * cols,
              itemBuilder: (context, index) {
                int row = index ~/ cols;
                int col = index % cols;
                return GestureDetector(
                  onTap: () => setCell(row, col),
                  child: Container(
                    margin: EdgeInsets.all(1),
                    color: getCellColor(grid[row][col]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Widget for Legend
class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}

