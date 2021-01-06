import 'dart:io';
import 'dart:math';

import 'package:advent_of_code_2020/src/operators.dart';

void main() {
  var instructions = File('lib/instructions.txt')
      .readAsLinesSync()
      .map((e) => e.split(' = '))
      .toList();

  var memory = <int, int>{};
  late BitMask mask;

  for (var instruction in instructions) {
    var operation = instruction[0];
    var operand = instruction[1];

    if (operation == 'mask') {
      mask = BitMask(operand);
    } else {
      var match = RegExp(r'\[(\d+)\]').firstMatch(operation)!;
      var addr = int.parse(match.group(1)!);
      var floatingAddresses = mask.apply(addr);
      for (var floatingAddr in floatingAddresses) {
        memory[floatingAddr] = int.parse(operand);
      }
    }
  }
  var sum = memory.values.reduce(add);
  print(sum);
}

class BitMask {
  late final int ones;
  late final List<int> xPositions;
  late final int length;

  BitMask(String bitMask) {
    var onesBinaryString =
        bitMask.replaceAll('X', '0').split('').map((e) => int.parse(e)).join();

    ones = int.parse(onesBinaryString, radix: 2);

    xPositions =
        RegExp('X').allMatches(bitMask).map((match) => match.start).toList();

    length = bitMask.length;
  }

  List<int> apply(int value) {
    var maskedValue =
        ((value | ones)).toRadixString(2).padLeft(length, '0').split('');
    var floatingValues = <int>[];
    var nDigits = xPositions.length;
    var max = pow(2, nDigits) as int;

    for (var i = 0; i < max; i++) {
      var bits = i.toRadixString(2).padLeft(nDigits, '0');
      for (var j = 0; j < bits.length; j++) {
        maskedValue[xPositions[j]] = bits[j];
      }
      floatingValues.add(int.parse(maskedValue.join(), radix: 2));
    }
    return floatingValues;
  }
}
