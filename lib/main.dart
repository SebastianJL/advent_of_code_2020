import 'dart:io';

void main() {
  var tree_map = File('lib/tree_map.txt')
      .readAsLinesSync()
      .map((e) => e.split(''))
      .toList();

  var nRows = tree_map.length;
  var nColumns = tree_map[0].length;
  var nTrees = 0;

  var c = 0;
  for (var r = 0; r < nRows; r++) {
    if (tree_map[r][c] == '#') nTrees++;
    c = (c+3) % nColumns;
  }
  print(nTrees);
}