import 'dart:io';

void main() {
  var jolts =
      File('lib/jolts.txt').readAsLinesSync().map((e) => int.parse(e)).toList();

  jolts.sort();
  jolts = [0, ...jolts, jolts[jolts.length-1] + 3];
  var joltDifferences = <int>[];

  for (var i = 0; i < jolts.length - 1; i++) {
    joltDifferences.add(jolts[i + 1] - jolts[i]);
  }

  var difference3 = joltDifferences.where((element) => element == 3).length;
  var difference1 = joltDifferences.where((element) => element == 1).length;
  print(difference1*difference3);
}
