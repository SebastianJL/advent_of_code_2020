// @dart=2.9
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';

const noSeat = '.';
const free = 'L';
const occupied = '#';

void main() {
  var seatLayout = File('lib/seat_layout.txt')
      .readAsLinesSync()
      .map((e) => e.split(''))
      .toList();
  var seatLayoutCopy =
      List.filled(seatLayout.length, List.filled(seatLayout[0].length, ''));
  Function deepEquals = const DeepCollectionEquality().equals;

  do {
    deepCopy(seatLayout, seatLayoutCopy);

    // matrixPrint(seatLayout);
    // print('---------------------------');

    for (var row = 0; row < seatLayout.length; row++) {
      for (var col = 0; col < seatLayout[0].length; col++) {
        if (seatLayoutCopy[row][col] == noSeat) continue;

        var n = countOccupiedAdjacentSeats(row, col, seatLayoutCopy);

        if (n == 0) seatLayout[row][col] = occupied;
        if (n >= 4) seatLayout[row][col] = free;
      }
    }
  } while (!deepEquals(seatLayout, seatLayoutCopy));

  // matrixPrint(seatLayoutCopy);
  print(countOccupiedSeats(seatLayout));
}

int countOccupiedAdjacentSeats(
    int row, int col, List<List<String>> seatLayout) {
  var n = 0;
  var iMin = max(row - 1, 0);
  var iMax = min(row + 2, seatLayout.length);
  var jMin = max(col - 1, 0);
  var jMax = min(col + 2, seatLayout[0].length);

  for (var i = iMin; i < iMax; i++) {
    for (var j = jMin; j < jMax; j++) {
      n += (seatLayout[i][j] == occupied) ? 1 : 0;
    }
  }
  if (seatLayout[row][col] == occupied) n -= 1;
  return n;
}

int countOccupiedSeats(List<List<String>> seatLayout) {
  return seatLayout
      .expand((element) => element)
      .where((element) => element == occupied)
      .length;
}

void matrixPrint<E>(List<List<E>> matrix) {
  for (var row in matrix) {
    stdout.writeAll(row);
    print('');
  }
  print('');
}

void deepCopy(List<List<String>> origin, List<List<String>> target) {
  for (var i = 0; i < origin.length; i++) {
    target[i] = List.from(origin[i]);
  }
}
