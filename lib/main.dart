import 'dart:io';
import 'dart:math';

void main() {
  var boardingPasses = File('lib/boarding_passes.txt').readAsLinesSync();

  var maxSeatId = boardingPasses
      .map((e) => decodeSeatId(e))
      .reduce((value, element) => max(value, element));

  print(maxSeatId);
}

int decodeSeatId(String seatString) {
  var row = int.parse(
      seatString
          .substring(0, 7)
          .split('')
          .map((letter) => letter == 'B' ? 1 : 0)
          .join(),
      radix: 2);

  var col = int.parse(
      seatString
          .substring(7)
          .split('')
          .map((letter) => letter == 'R' ? 1 : 0)
          .join(),
      radix: 2);

  return row * 8 + col;
}
