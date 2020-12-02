import 'dart:io';

void main() {
  var password_file = File('lib/passwords.txt');
  var n_valid_passwords = password_file
      .readAsLinesSync()
      .map((e) => e.split(RegExp('[- ]')))
      .map((e) => is_valid(
          int.parse(e[0]), int.parse(e[1]), e[2].substring(0, 1), e[3]))
      .reduce((sum, e) => sum + e);

  print(n_valid_passwords);
}

int is_valid(int min, int max, String character, String password) {
  var counter = 0;
  var valid = true;
  for (var c in password.split('')) {
    if (c == character) counter++;
  }
  if (counter < min) valid = false;
  if (counter > max) valid = false;
  return valid ? 1 : 0;
}
