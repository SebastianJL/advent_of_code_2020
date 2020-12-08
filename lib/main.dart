import 'dart:io';

void main() {
  var boardingPasses = File('lib/boarding_passes.txt').readAsLinesSync();

  var seatIDs = boardingPasses.map((e) => decodeSeatId(e)).toList();
  seatIDs.sort();

  for (var i=0; i<seatIDs.length-1; i++) {
    if (seatIDs[i+1] - seatIDs[i] == 2) {
      print(seatIDs[i]+1);
    };
  }
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
