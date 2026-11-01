// Checks assets/portfolio/career.json before it ships.
//
//   dart run tool/validate_career.dart
//
// Exits with code 1 when an entry would be skipped on the site or a file it
// points to is missing. Missing translations are reported but don't fail.
import 'dart:convert';
import 'dart:io';

import 'package:my_portfolio/app/data/career_data.dart';

const languages = ['en', 'ar', 'fr', 'ru'];

void main() {
  final file = File('assets/portfolio/career.json');
  if (!file.existsSync()) {
    stderr.writeln('Cannot find ${file.path}. Run this from the project root.');
    exit(1);
  }

  Object? json;
  try {
    json = jsonDecode(file.readAsStringSync());
  } on FormatException catch (e) {
    stderr.writeln('career.json is not valid JSON: ${e.message} (offset ${e.offset})');
    exit(1);
  }

  final data = CareerData.parse(json);
  final errors = [...data.warnings];
  final notes = <String>[];

  void checkFile(String? path, String where) {
    if (path != null && !File(path).existsSync()) errors.add('$where: file not found: $path');
  }

  void checkLanguages(LocalizedText? text, String where) {
    if (text == null) return;
    final missing = languages.where((l) => !text.values.containsKey(l));
    if (missing.isNotEmpty) notes.add('$where: no ${missing.join(', ')} text, English is shown instead');
  }

  checkFile(data.photo, 'photo');
  if (data.mainTrack == null) errors.add('tracks: add at least one track and mark one "main": true');

  for (final e in data.path) {
    checkFile(e.logo, 'path "${e.id}" logo');
    checkLanguages(e.title, 'path "${e.id}" title');
    checkLanguages(e.place, 'path "${e.id}" place');
    checkLanguages(e.details, 'path "${e.id}" details');
  }
  for (final p in data.projects) {
    checkFile(p.image, 'project "${p.id}" image');
    checkLanguages(p.title, 'project "${p.id}" title');
    checkLanguages(p.summary, 'project "${p.id}" summary');
  }
  for (final r in data.roles) {
    checkLanguages(r.title, 'role since ${r.since}');
  }

  for (final n in notes) {
    stdout.writeln('note   $n');
  }
  for (final e in errors) {
    stdout.writeln('error  $e');
  }
  stdout.writeln(
      '${data.path.length} path entries, ${data.projects.length} projects, ${data.skills.length} skills, '
      '${errors.length} errors, ${notes.length} notes');
  if (errors.isNotEmpty) exit(1);
}
