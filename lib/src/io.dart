import 'dart:io';

void matrixPrint<E>(List<List<E>> matrix, {String sep = ''}) {
  for (var row in matrix) {
    stdout.writeAll(row, sep);
    print('');
  }
  print('');
}