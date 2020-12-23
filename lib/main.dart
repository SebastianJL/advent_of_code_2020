import 'dart:io';

import 'package:advent_of_code_2020/src/operators.dart';

void main() {
  var chargers = File('lib/chargers.txt')
      .readAsLinesSync()
      .map((e) => int.parse(e))
      .toList();

  chargers.sort();
  chargers = [0, ...chargers, chargers[chargers.length - 1] + 3];
  print(chargerCombinations(chargers));
}

int chargerCombinations(List<int> chargers) {
  var combinations = List.filled(chargers.length, 0);
  combinations.last = 1;

  for (var i = chargers.length - 2; i >= 0; i--) {
    var first = chargers[i];
    var possibleNext =
        chargers.skip(i).takeWhile((value) => first >= value - 3).length;
    combinations[i] = combinations.skip(i).take(possibleNext).reduce(add);
  }
  return combinations[0];
}
