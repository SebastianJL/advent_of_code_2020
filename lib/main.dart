import 'dart:io';

void main() {
  var numbers_file = File('lib/numbers.txt');
  var numbers =
      numbers_file.readAsLinesSync().map((e) => int.parse(e)).toList();
  var number1;
  var number2;
  var number3;

  outer:
  for (var i=0; i<numbers.length; i++) {
    number1 = numbers[i];
    for (var j=i+1; j<numbers.length; j++) {
      number2 = numbers[j];
      for (var k=i+1; k<numbers.length; k++) {
        number3 = numbers[k];
        if (number1 + number2 + number3 == 2020) {
          break outer;
        }
      }
    }
  }

  print(number1);
  print(number2);
  print(number3);
  print(number1 + number2 + number3);
  print(number1 * number2 * number3);
}
