import 'dart:collection';
import 'dart:io';

import 'dart:math';

void main() {
  var data =
      File('lib/data.xmas').readAsLinesSync().map((e) => int.parse(e)).toList();
  var n = 400480901;
  var sum = 0;
  var contiguousRange = Queue<int>();

  for (var number in data) {
    sum += number;
    contiguousRange.addLast(number);

    while (sum > n) {
      sum -= contiguousRange.removeFirst();
    }
    if (sum == n) {
      break;
    }
  }
  print(sum);
  var minimum = contiguousRange.reduce(min);
  var maximum = contiguousRange.reduce(max);
  print(minimum + maximum);
}
