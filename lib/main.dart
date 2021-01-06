import 'dart:io';

void main() {
  var numbers = File('lib/numbers.txt')
      .readAsStringSync()
      .split(',')
      .map((e) => int.parse(e))
      .toList();

  var before = <int, int>{};

  for (var i = 0; i < numbers.length - 1; i++) {
    var number = numbers[i];
    before[number] = i;
  }
  int index;
  while ((index = numbers.length - 1) + 1 < 2020) {
    var previousIndex = before[numbers.last];
    int nextNumber;

    if (previousIndex == null) {
      nextNumber = 0;
    } else {
      nextNumber = index - previousIndex;
    }
    before[numbers.last] = index;
    numbers.add(nextNumber);
  }

  print(numbers.last);
}
