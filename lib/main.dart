import 'dart:io';
import 'dart:math';

void main() {
  var notes = File('lib/notes.txt').readAsLinesSync();

  var arrivalTime = int.parse(notes[0]);
  var departureIntervals = notes[1]
      .split(',')
      .where((e) => e != 'x')
      .map((e) => int.parse(e))
      .toList();

  print(arrivalTime);
  print(departureIntervals);
  var nextDepartureTimes = departureIntervals
      .map((interval) => (arrivalTime / interval).ceil() * interval)
      .toList();
  var soonestDeparture = nextDepartureTimes.reduce(min);
  var busId = departureIntervals[nextDepartureTimes.indexOf(soonestDeparture)];
  print((soonestDeparture - arrivalTime) * busId);
}
