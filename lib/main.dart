// @dart=2.9
import 'dart:io';

import 'package:advent_of_code_2020/src/operators.dart';
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

        var n = countOccupiedVisibleSeats(row, col, seatLayoutCopy);

        if (n == 0) seatLayout[row][col] = occupied;
        if (n >= 5) seatLayout[row][col] = free;
      }
    }
  } while (!deepEquals(seatLayout, seatLayoutCopy));

  // matrixPrint(seatLayoutCopy);
  print(countOccupiedSeats(seatLayout));
}

int countOccupiedVisibleSeats(int row, int col, List<List<String>> seatLayout) {
  var seatsInAllDirections = [
    look(row, col, -1, -1, seatLayout),
    look(row, col, -1, 0, seatLayout),
    look(row, col, -1, 1, seatLayout),
    look(row, col, 0, 1, seatLayout),
    look(row, col, 1, 1, seatLayout),
    look(row, col, 1, 0, seatLayout),
    look(row, col, 1, -1, seatLayout),
    look(row, col, 0, -1, seatLayout),
  ];
  return seatsInAllDirections.reduce(add);
}

int countOccupiedSeats(List<List<String>> seatLayout) {
  return seatLayout
      .expand((element) => element)
      .where((element) => element == occupied)
      .length;
}

void deepCopy(List<List<String>> origin, List<List<String>> target) {
  for (var i = 0; i < origin.length; i++) {
    target[i] = List.from(origin[i]);
  }
}

int look(int row, int column, int vertical, int horizontal,
    List<List<String>> seatLayout) {
  var seen = noSeat;
  var i = row;
  var j = column;

  do {
    i += vertical;
    j += horizontal;
    try {
      seen = seatLayout[i][j];
    } on RangeError {
      break;
    }
  } while (seen == noSeat);

  return seen == occupied ? 1 : 0;
}
