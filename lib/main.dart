import 'dart:io';

void main() {
  var nAnswers = File('lib/answer_sheet.txt')
      .readAsStringSync()
      .split('\n\n')
      .map((e) => e.replaceAll('\n', '').split(''))
      .map((e) => Set<String>.from(e))
      .fold(0, (int previousValue, element) => previousValue + element.length);

  print(nAnswers);
}
