import 'dart:collection';
import 'dart:io';

void main() {
  var notes = File('lib/notes.txt')
      .readAsLinesSync()[0]
      .split(',')
      .map((e) => int.tryParse(e))
      .toList()
      .asMap();

  var offsetToInterval = SplayTreeMap<int, int>.fromIterable(
      notes.entries.where((entry) => entry.value != null),
      key: (e) => e.key,
      value: (e) => e.value);

  var incr = offsetToInterval.remove(offsetToInterval.firstKey())!;
  var value = 0;

  for (var entry in offsetToInterval.entries) {
    var offset = entry.key;
    var interval = entry.value;
    while ((value + offset) % interval != 0) {
      value += incr;
    }
    incr = lcm(incr, interval);
  }

  print(value);
}

/// Returns greatest common divisor of [a] and [b].
int gcd(int a, int b) {
  return a.gcd(b);
}

/// Returns least common multiple of [a] and [b].
int lcm(int a, int b) {
  return (a * b).abs() ~/ gcd(a, b);
}
