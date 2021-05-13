import 'dart:io';

void main() {
  var notes = File('lib/notes.txt').readAsStringSync().split('\n\n');

  var categories = {
    for (var e in notes[0].split('\n').map((e) => e.split(': '))) e[0]: Interval(e[1])
  };
  var myTicket = notes[1];
  var nearbyTickets = notes[2];

  print(categories);
}

class Interval {
  final List<int> boundaries;

  Interval(String r)
      : boundaries =
            r.split(RegExp(r' or |-')).map((e) => int.parse(e)).toList();

  @override
  String toString() {
    return 'Interval($boundaries)';
  }

  bool contains(int n) {
    var found = false;
    for (var i=0; i<boundaries.length; i+=2) {
      if (n >= boundaries[i] && n <= boundaries[i+1]) {
        found = true;
        break;
      }
    }
    return found;
  }
}
