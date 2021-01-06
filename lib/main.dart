import 'dart:io';

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
      var value = int.parse(operand);
      memory[addr] = mask.apply(value);
    }
  }
  var sum = memory.values.reduce(add);
  print(sum);
}

class BitMask {
  late final int zeroes;
  late final int ones;

  BitMask(String bitMask) {
    var onesBinaryString =
        bitMask.replaceAll('X', '0').split('').map((e) => int.parse(e)).join();
    var zeroesBinaryString =
        bitMask.replaceAll('X', '1').split('').map((e) => int.parse(e)).join();

    ones = int.parse(onesBinaryString, radix: 2);
    zeroes = int.parse(zeroesBinaryString, radix: 2);
  }

  int apply(int value) {
    return (value | ones) & zeroes;
  }
}
