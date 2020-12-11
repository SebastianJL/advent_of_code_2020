import 'dart:io';

void main() {
  var program = File('lib/bytecode.txt').readAsStringSync();
  int? result;

  var jmpOrNop = RegExp(r'jmp|nop');
  var matches = jmpOrNop.allMatches(program);

  for (var match in matches) {
    var replacementInstruction = match.group(0) == 'jmp' ? 'nop' : 'jmp';
    var newProgram =
        program.replaceRange(match.start, match.end, replacementInstruction);
    result = Computer(newProgram).run();
    if (result != null) break;
  }

  print(result);
}

class Computer {
  final String bytecode;
  late final List<Instruction> _instructions;
  int _pointer = 0;
  int _accumulator = 0;
  final _visitedPointers = <int>{};

  Computer(this.bytecode) {
    _instructions = _initializeInstructions();
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
  ///
  /// The program halts as soon as it tries to read an instruction at a line of
  /// the bytecode that doesn't exist. Usually after advancing from the last
  /// line.
  /// If the computer hits the same line of the bytecode twice it halts and
  /// returns `null`.
  int? run() {
    Instruction instruction;

    while (true) {
      if (_visitedPointers.contains(_pointer)) {
        return null;
      }
      _visitedPointers.add(_pointer);
      try {
        instruction = _instructions[_pointer];
      } on RangeError {
        break;
      }
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

  @override
  String toString() {
    return '$name $argument';
  }
}
