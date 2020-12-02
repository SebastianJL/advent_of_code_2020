import 'dart:convert';
import 'dart:io';

import 'package:advent_of_code_2020/src/operators.dart';

void main() {
  var password_file = File('lib/passwords.txt');
  password_file
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .map((e) => e.split(RegExp('[- ]')))
      .map((e) => isValid(
          int.parse(e[0]) - 1, int.parse(e[1]) - 1, e[2].substring(0, 1), e[3]))
      .reduce((sum, e) => sum + e)
      .then(print);
}

int isValid(int index1, int index2, String character, String password) {
  var valid = true;
  valid = xor(character == password[index1], character == password[index2]);
  return valid ? 1 : 0;
}
