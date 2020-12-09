import 'dart:io';

void main() {
  var answersByGroupAndMember = File('lib/answer_sheet.txt')
      .readAsStringSync()
      .split('\n\n')
      .map((e) => e.split('\n'));

  var correctAnswers = 0;
  for (var group in answersByGroupAndMember) {
    var allAnswers = Set.from(group.join().split(''));

    for (var answer in allAnswers) {
      var answeredCorrectlyByEveryone = true;
      for (var member in group) {
        if (!member.split('').contains(answer)) {
          answeredCorrectlyByEveryone = false;
          break;
        }
      }
      if (answeredCorrectlyByEveryone) {
        correctAnswers += 1;
      }
    }
  }

  print(correctAnswers);
}
