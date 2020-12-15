import 'dart:collection';
import 'dart:io';

void main() {
  var program =
      File('lib/data.xmas').readAsLinesSync().map((e) => int.parse(e)).toList();
  var n = 25;
  var previousNumbers = Queue.of(program.sublist(0, n));
  print(previousNumbers);

  outer:
  for (var number in program.sublist(n)) {
    for (var previous in previousNumbers) {
      if (previousNumbers.contains(number - previous)) {
        previousNumbers.removeFirst();
        previousNumbers.addLast(number);
        continue outer;
      }
    }
    print(number);
    break;
  }
}
