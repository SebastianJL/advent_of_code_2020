import 'dart:io';

void main() {
  var numbers_file = File('lib/numbers.txt');
  var numbers =
      numbers_file.readAsLinesSync().map((e) => int.parse(e)).toList();
  var number1;
  var number2;

  outer:
  for (var i=0; i<numbers.length; i++) {
    number1 = numbers[i];
    for (var j=i+1; j<numbers.length; j++) {
      number2 = numbers[j];
      if (number1 + number2 == 2020) {
        break outer;
      }
    }
  }

  print(number1);
  print(number2);
  print(number1 + number2);
  print(number1 * number2);
}
