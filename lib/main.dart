import 'dart:io';

void main() {
  var colorRules = File('lib/color_rules.txt')
      .readAsLinesSync()
      .map((line) => line
          .split(RegExp(' bags?( contain |, |.)|no other bags.'))
          .where((element) => element.isNotEmpty)
          .toList())
      .toList();

  var bagRelations = <String, List<BagQuantity>>{};
  for (var colorRule in colorRules) {
    bagRelations
        .putIfAbsent(colorRule[0], () => <BagQuantity>[])
        .addAll(colorRule.sublist(1).map((e) => BagQuantity.fromString(e)));
  }

  print(bagRelations);

  var nContainedBags = findNumberOfContainedBags('shiny gold', bagRelations);

  print(nContainedBags);
}

int findNumberOfContainedBags(
    String color, Map<String, List<BagQuantity>> bagRelations) {
  var nContainedBags = 0;
  var bagQuantities = bagRelations[color];

  if (bagQuantities == null) {
    throw (ArgumentError(
        'Color $color is not contained in bagRelations $bagRelations'));
  }

  for (var bagQuantity in bagQuantities) {
    nContainedBags += bagQuantity.quantity + bagQuantity.quantity *
        findNumberOfContainedBags(bagQuantity.color, bagRelations);
  }
  return nContainedBags;
}

class BagQuantity {
  final String color;
  final int quantity;

  BagQuantity(this.color, this.quantity);

  /// [bagQuantity] must be a string consisting of "integer color name".
  factory BagQuantity.fromString(String bagQuantity) {
    var match = RegExp(r'\d+').firstMatch(bagQuantity);
    if (match == null) {
      throw (ArgumentError.value(bagQuantity));
    }

    var quantity = int.parse(match.group(0).toString());
    var color = bagQuantity.substring(match.end + 1);
    return BagQuantity(color, quantity);
  }

  @override
  String toString() => '$quantity $color';
}
