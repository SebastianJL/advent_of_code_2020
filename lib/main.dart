import 'dart:io';

void main() {
  var colorRules = File('lib/color_rules.txt').readAsLinesSync().map((line) =>
      line
          .split(RegExp(' bags?( contain [0-9] |[,.]( [0-9] )?)'))
          .where((element) => element.isNotEmpty)
          .toList());

  var colorRelations = <String, Set<String>>{};
  for (var colorRule in colorRules) {
    for (var color in colorRule.sublist(1)) {
      colorRelations.putIfAbsent(color, () => <String>{}).add(colorRule[0]);
    }
  }

  var containingBags = findContainingBags('shiny gold', colorRelations);

  print(containingBags);
  print(containingBags.length);
}


Set<String> findContainingBags(
    String containedColor, Map<String, Set<String>> colorRelations) {
  var containingBags = <String>{};

  for (var color in colorRelations[containedColor] ?? {}) {
    containingBags.add(color);
    containingBags.addAll(findContainingBags(color, colorRelations));
  }

  return containingBags;
}
