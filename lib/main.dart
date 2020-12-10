import 'dart:io';

void main() {
  var colorRules = File('lib/color_rules.txt')
      .readAsLinesSync()
      .map((line) => line
          .split(RegExp(' bags?( contain |, |.)|no other bags.'))
          .where((element) => element.isNotEmpty)
          .toList())
      .toList();

  var colorRelations = <String, List<BagQuantity>>{};
  for (var colorRule in colorRules) {
    colorRelations
        .putIfAbsent(colorRule[0], () => <BagQuantity>[])
        .addAll(colorRule.sublist(1).map((e) => BagQuantity.fromString(e)));
  }

  print(colorRelations);

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

class BagQuantity {
  late String color;
  late int quantity;

  BagQuantity(this.color, this.quantity);

  BagQuantity.fromString(String bagQuantity) {
    var a = bagQuantity.split(' ');
    quantity = int.parse(a[0]);
    color = a[1];
  }
}
