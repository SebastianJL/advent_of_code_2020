import 'dart:io';

void main() {
  var chargers = File('lib/chargers.txt')
      .readAsLinesSync()
      .map((e) => int.parse(e))
      .toList();

  chargers.sort();
  chargers = [0, ...chargers, chargers[chargers.length - 1] + 3];
  print(chargerCombinations(chargers));
}

int chargerCombinations(Iterable<int> chargers) {
  var combinations = 0;
  var first = chargers.first;
  var possibleNext =
      chargers.skip(1).takeWhile((value) => first >= value - 3).length;

  if (chargers.length == 1) {
    return 1;
  }

  for (var i = 0; i < possibleNext; i++) {
    combinations += chargerCombinations(chargers.skip(i+1));
  }

  return combinations;
}
