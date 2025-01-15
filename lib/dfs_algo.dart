Future<void> solveMazeDFS(
    List<List<int>> grid, int startX, int startY, int endX, int endY, Function updateGrid) async {
  List<List<bool>> visited = List.generate(grid.length, (_) => List.filled(grid[0].length, false));

  bool dfs(int x, int y) {
    if (x < 0 || x >= grid.length || y < 0 || y >= grid[0].length || grid[x][y] == 1 || visited[x][y]) {
      return false;
    }
    if (x == endX && y == endY) {
      grid[x][y] = 5;
      return true;
    }

    visited[x][y] = true;
    grid[x][y] = 4; // Mark as visited
    updateGrid();
    Future.delayed(Duration(milliseconds: 100));

    // Explore neighbors
    if (dfs(x + 1, y) || dfs(x - 1, y) || dfs(x, y + 1) || dfs(x, y - 1)) {
      grid[x][y] = 5; // Mark as path
      return true;
    }
    return false;
  }

  dfs(startX, startY);
}
