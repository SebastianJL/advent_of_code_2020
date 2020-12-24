import 'dart:io';

void main() {
  var directions = File('lib/directions.txt')
      .readAsLinesSync()
      .map((e) => [e[0], int.parse(e.substring(1))])
      .toList();

  print(directions);

  var heading = 'E';
  var position = Position();

  for (var instruction in directions) {
    // print(position);
    // print(heading);
    // print('');

    switch (instruction[0]) {
      case 'F':
        position.add(heading, instruction[1] as int);
        break;
      case 'R':
        heading = changeDirection(heading, -(instruction[1] as int));
        break;
      case 'L':
        heading = changeDirection(heading, instruction[1] as int);
        break;
      default:
        position.add(instruction[0] as String, instruction[1] as int);
    }
  }
  print(position);
  print(heading);
  print(position.x.abs() + position.y.abs());
}

String changeDirection(String direction, int degrees) {
  var directions = ['E', 'N', 'W', 'S'];
  var index = directions.indexOf(direction);
  return directions[(index + degrees ~/ 90) % 4];
}

class Position {
  var x = 0;
  var y = 0;

  Position add(String direction, int distance) {
    switch (direction) {
      case 'E':
        x += distance;
        break;
      case 'N':
        y += distance;
        break;
      case 'W':
        x -= distance;
        break;
      case 'S':
        y -= distance;
    }
    return this;
  }

  @override
  String toString() {
    return '($x,$y)';
  }
}