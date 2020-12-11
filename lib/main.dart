import 'dart:io';

void main() {
  var program = File('lib/bytecode.txt').readAsStringSync();

  var c = Computer(program);

  var accState = c.runUntilLoop();
  print(accState);
}

class Computer {
  final String bytecode;
  late final List<Instruction> _instructions;
  int _pointer = 0;
  int _accumulator = 0;
  final _visitedPointers = <int>{};

  Computer(this.bytecode) {
    try {
      _instructions = _initializeInstructions();
    } on ArgumentError {
      rethrow;
    }
  }

  List<Instruction> _initializeInstructions() {
    return bytecode
        .split('\n')
        .map((instruction) => Instruction(
            name: instruction.substring(0, 3),
            argument: int.parse(instruction.substring(4))))
        .toList();
  }

  /// Runs the [bytecode] and returns the state of the internal [_accumulator].
  /// The program halts as soon as it hits the same line of the bytecode twice.
  int runUntilLoop() {
    while (true) {
      if (_visitedPointers.contains(_pointer)) {
        break;
      }
      _visitedPointers.add(_pointer);
      var instruction = _instructions[_pointer];
      _execute(instruction);
    }
    return _accumulator;
  }

  void _execute(Instruction instruction) {
    switch (instruction.name) {
      case 'nop':
        _pointer += 1;
        break;
      case 'acc':
        _accumulator += instruction.argument;
        _pointer += 1;
        break;
      case 'jmp':
        _pointer += instruction.argument;
        break;
      default:
        throw (ArgumentError.value(instruction.name));
    }
  }
}

class Instruction {
  final String name;
  final int argument;

  Instruction({required this.name, required this.argument});
}
