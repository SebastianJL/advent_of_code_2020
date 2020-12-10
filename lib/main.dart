import 'dart:io';

void main() {
  var colorRules = File('lib/color_rules.txt').readAsLinesSync().map((line) =>
      line
          .split(RegExp(' bags?( contain [0-9] |[,.]( [0-9] )?)'))
          .where((element) => element.isNotEmpty)
          .toList());

  print(colorRules);

//   var colorRelations = <String, Set<String>>{};
//   for (var colorRule in colorRules) {
//     colorRelations
//         .putIfAbsent(colorRule[0], () => <String>{})
//         .addAll(colorRule.sublist(1));
//   }
//
//   var containingBags = findNumberOfContainedBags('shiny gold', colorRelations);
//
//   print(containingBags);
//   print(containingBags.length);
}
//
// Set<String> findNumberOfContainedBags(
//     String containedColor, Map<String, Set<String>> colorRelations) {
//   var nContainedBags = 0;
//
//   for (var color in colorRelations[containedColor] ?? {}) {
//     containingBags.add(color);
//     containingBags.addAll(findNumberOfContainedBags(color, colorRelations));
//   }
//
//   return containingBags;
// }

class BagRule {
  String color;
  List<BagQuantity> containedBags;

  BagRule(this.color, this.containedBags);
}

class BagQuantity {
  String color;
  int quantity;

  BagQuantity(this.color, this.quantity);
}