import 'dart:io';

void main() {
  var passports = File('lib/passports.txt')
      .readAsStringSync()
      .split('\n\n')
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
  var requiredKeys = ['ecl', 'pid', 'eyr', 'hcl', 'byr', 'iyr', 'hgt'];
  // Ignored key 'cid'

  if (passport.length < requiredKeys.length) return false;
  if (!requiredKeys.every((key) => passport.containsKey(key))) return false;

  // byr (Birth Year) - four digits; at least 1920 and at most 2002.
  var birthYear = passport['byr']!;
  if (!RegExp(r'^(19[2-9][0-9]|200[0-2])$')
      .hasMatch(birthYear)) {
    return false;
  }

  // iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  var issueYear = passport['iyr']!;
  if (!RegExp(r'^(201[0-9]|2020)$')
      .hasMatch(issueYear)) {
    return false;
  }

  // eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  var expirationYear = passport['eyr']!;
  if (!RegExp(r'^(202[0-9]|2030)$')
      .hasMatch(expirationYear)) {
    return false;
  }

  // hgt (Height) - a number followed by either cm or in:
  // If cm, the number must be at least 150 and at most 193.
  // If in, the number must be at least 59 and at most 76.
  var height = passport['hgt']!;
  if (!RegExp(r'^(1([5-8][0-9]|9[0-3])cm|(59|6[0-9]|7[0-6])in)$')
      .hasMatch(height)) {
    return false;
  }

  // hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  var hairColor = passport['hcl']!;
  if (!RegExp(r'^#[0-9a-f]{6}$').hasMatch(hairColor)) {
    return false;
  }

  // ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  var eyeColor = passport['ecl']!;
  if (!RegExp(r'^(amb|blu|brn|gry|grn|hzl|oth)$')
      .hasMatch(eyeColor)) {
    return false;
  }

  // pid (Passport ID) - a nine-digit number, including leading zeroes.
  var passportID = passport['pid']!;
  if (!RegExp(r'^[0-9]{9}$')
      .hasMatch(passportID)) {
    return false;
  }

  // cid (Country ID) - ignored, missing or not.

  return true;
}
