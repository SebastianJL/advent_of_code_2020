import 'dart:io';

void main() {
  var passports = File('lib/passports.txt')
      .readAsStringSync()
      .split('\n\n')
      .toList()
      .map((e) => toMap(e));

  var nValidPassports =
      passports.where((passport) => validatePassport(passport)).length;

  print(nValidPassports);
}

Map<String, String> toMap(String passportString) {
  var passportEntries = passportString
      .split(RegExp(r'[ \n]'))
      .map((e) => e.split(':'))
      .map((e) => MapEntry(e[0], e[1]));
  return Map.fromEntries(passportEntries);
}

bool validatePassport(Map<String, String> passport) {
  var keys = ['ecl', 'pid', 'eyr', 'hcl', 'byr', 'iyr', 'hgt'];
  // Ignored key 'cid'

  if (passport.length < keys.length) return false;

  return keys.every((key) => passport.containsKey(key));
}
