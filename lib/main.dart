import 'dart:io';

void main() {
  var treeMap = File('lib/tree_map.txt')
      .readAsLinesSync()
      .map((e) => e.split(''))
      .toList();

  var total = 1;
  for (var slope in [
    [1, 1],
    [1, 3],
    [1, 5],
    [1, 7],
    [2, 1]
  ]) {
    var nTrees = countTrees(treeMap, slope[0], slope[1]);
    print(nTrees);
    total *= nTrees;
  }
  print(total);
}

int countTrees(List<List<String>> treeMap, int down, int right) {
  var nRows = treeMap.length;
  var nColumns = treeMap[0].length;
  var nTrees = 0;

  var c = 0;
  for (var r = 0; r < nRows; r += down) {
    if (treeMap[r][c] == '#') nTrees++;
    c = (c + right) % nColumns;
  }
  return nTrees;
}
