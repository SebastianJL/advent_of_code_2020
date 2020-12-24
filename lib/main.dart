import 'dart:io';

void main() {
  var directions = File('lib/directions.txt')
      .readAsLinesSync()
      .map((e) => [e[0], int.parse(e.substring(1))])
      .toList();

  var position = Coordinate2D.origin();
  var waypoint = Coordinate2D(10, 1);

  for (var instruction in directions) {

    var opcode = instruction[0] as String;
    var arg = instruction[1] as int;
    switch (opcode) {
      case 'F':
        position.addPosition(waypoint, arg);
        break;
      case 'R':
        waypoint.rotate(-arg);
        break;
      case 'L':
        waypoint.rotate(arg);
        break;
      default:
        waypoint.add(opcode, arg);
    }
  }
  print(position);
  print(waypoint);
  print(position.east.abs() + position.north.abs());
}

class Coordinate2D {
  int east;
  int north;

  Coordinate2D(this.east, this.north);

  Coordinate2D.origin()
      : east = 0,
        north = 0;

  /// Rotate in anti-clockwise direction by [degrees].
  /// Only integer multiples of 90 are possible.
  void rotate(int degrees) {
    var sign = degrees.sign;
    for (var i = 0; i < (degrees.abs() ~/ 90); i++) {
      var tmp = north;
      north = sign * east;
      east = -sign * tmp;
    }
  }

  Coordinate2D addPosition(Coordinate2D other, [int factor = 1]) {
    east += factor * other.east;
    north += factor * other.north;
    return this;
  }

  void add(String direction, int distance) {
    switch (direction) {
      case 'E':
        east += distance;
        break;
      case 'N':
        north += distance;
        break;
      case 'W':
        east -= distance;
        break;
      case 'S':
        north -= distance;
    }
  }

  @override
  String toString() {
    return '(east:$east, north:$north)';
  }
}
