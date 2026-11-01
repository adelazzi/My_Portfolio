// Pure Dart (no Flutter imports) so tool/validate_career.dart can reuse it.

/// Text written in several languages. Falls back to English, then to any
/// language that exists, so a missing translation never breaks the page.
class LocalizedText {
  const LocalizedText(this.values);

  final Map<String, String> values;

  String of(String lang) =>
      values[lang] ?? values['en'] ?? (values.isEmpty ? '' : values.values.first);

  bool get isEmpty => values.values.every((v) => v.trim().isEmpty);

  static LocalizedText? tryParse(Object? raw) {
    if (raw is String) return LocalizedText({'en': raw});
    if (raw is Map) {
      final map = <String, String>{};
      raw.forEach((k, v) {
        if (v is String) map['$k'] = v;
      });
      return map.isEmpty ? null : LocalizedText(map);
    }
    return null;
  }
}

class LocalizedList {
  const LocalizedList(this.values);

  final Map<String, List<String>> values;

  List<String> of(String lang) => values[lang] ?? values['en'] ?? const [];

  static LocalizedList tryParse(Object? raw) {
    if (raw is List) return LocalizedList({'en': raw.whereType<String>().toList()});
    if (raw is Map) {
      final map = <String, List<String>>{};
      raw.forEach((k, v) {
        if (v is List) map['$k'] = v.whereType<String>().toList();
      });
      return LocalizedList(map);
    }
    return const LocalizedList({});
  }
}

/// A month on the timeline, written as "YYYY-MM" (or "YYYY") in career.json.
class YearMonth implements Comparable<YearMonth> {
  const YearMonth(this.year, this.month);

  final int year;
  final int month;

  static YearMonth now() {
    final d = DateTime.now();
    return YearMonth(d.year, d.month);
  }

  static YearMonth? tryParse(Object? raw) {
    if (raw is int) return YearMonth(raw, 1);
    if (raw is! String) return null;
    final m = RegExp(r'^(\d{4})(?:-(\d{1,2}))?$').firstMatch(raw.trim());
    if (m == null) return null;
    final month = int.parse(m.group(2) ?? '1');
    if (month < 1 || month > 12) return null;
    return YearMonth(int.parse(m.group(1)!), month);
  }

  /// Position on a continuous axis, in years.
  double get value => year + (month - 1) / 12;

  @override
  int compareTo(YearMonth other) => value.compareTo(other.value);

  bool operator <(YearMonth other) => compareTo(other) < 0;
}

class CareerLink {
  const CareerLink(this.label, this.url);

  final LocalizedText label;
  final String url;
}

class CareerTrack {
  const CareerTrack({required this.id, required this.title, this.isMain = false});

  final String id;
  final LocalizedText title;
  final bool isMain;
}

class PathEntry {
  const PathEntry({
    required this.id,
    required this.track,
    required this.start,
    required this.end,
    required this.label,
    required this.title,
    required this.place,
    this.details,
    this.highlights = const LocalizedList({}),
    this.logo,
    this.link,
    this.links = const [],
  });

  final String id;
  final String track;
  final YearMonth start;

  /// Null means the entry is still going on.
  final YearMonth? end;
  final String label;
  final LocalizedText title;
  final LocalizedText place;
  final LocalizedText? details;
  final LocalizedList highlights;
  final String? logo;
  final String? link;
  final List<CareerLink> links;

  bool get isCurrent => end == null;
  YearMonth get endOrNow => end ?? YearMonth.now();
}

class Project {
  const Project({
    required this.id,
    required this.date,
    required this.title,
    required this.summary,
    this.image,
    this.tech = const [],
    this.award,
    this.links = const [],
  });

  final String id;
  final YearMonth date;
  final LocalizedText title;
  final LocalizedText summary;
  final String? image;
  final List<String> tech;
  final LocalizedText? award;
  final List<CareerLink> links;
}

enum SkillLevel { daily, familiar }

class Skill {
  const Skill({required this.name, required this.area, required this.level});

  final String name;
  final String area;
  final SkillLevel level;
}

class Role {
  const Role({required this.since, required this.title});

  final int since;
  final LocalizedText title;
}

class CareerData {
  const CareerData({
    required this.tracks,
    required this.roles,
    required this.path,
    required this.projects,
    required this.skills,
    required this.warnings,
    this.photo,
  });

  static const empty = CareerData(
      tracks: [], roles: [], path: [], projects: [], skills: [], warnings: []);

  /// Portrait shown in the About section; null hides it.
  final String? photo;

  final List<CareerTrack> tracks;
  final List<Role> roles;

  /// Sorted oldest first.
  final List<PathEntry> path;

  /// Sorted newest first.
  final List<Project> projects;
  final List<Skill> skills;

  /// Problems found while reading career.json. Bad entries are skipped.
  final List<String> warnings;

  CareerTrack? get mainTrack {
    for (final t in tracks) {
      if (t.isMain) return t;
    }
    return tracks.isEmpty ? null : tracks.first;
  }

  static CareerData parse(Object? json) {
    final warnings = <String>[];
    if (json is! Map) {
      return const CareerData(
          tracks: [], roles: [], path: [], projects: [], skills: [],
          warnings: ['career.json must contain a JSON object']);
    }

    List<Map> listOf(String key) {
      final raw = json[key];
      if (raw == null) return const [];
      if (raw is! List) {
        warnings.add('"$key" must be a list');
        return const [];
      }
      return raw.whereType<Map>().toList();
    }

    List<CareerLink> linksOf(Object? raw, String where) {
      if (raw == null) return const [];
      final out = <CareerLink>[];
      for (final l in raw is List ? raw : const []) {
        final label = l is Map ? LocalizedText.tryParse(l['label']) : null;
        final url = l is Map ? l['url'] : null;
        if (label == null || url is! String || Uri.tryParse(url) == null) {
          warnings.add('$where: each link needs "label" and a valid "url"');
          continue;
        }
        out.add(CareerLink(label, url));
      }
      return out;
    }

    final tracks = <CareerTrack>[];
    for (final t in listOf('tracks')) {
      final id = t['id'];
      final title = LocalizedText.tryParse(t['title']);
      if (id is! String || title == null) {
        warnings.add('tracks: every track needs "id" and "title"');
        continue;
      }
      tracks.add(CareerTrack(id: id, title: title, isMain: t['main'] == true));
    }
    final trackIds = tracks.map((t) => t.id).toSet();

    final roles = <Role>[];
    for (final r in listOf('roles')) {
      final since = int.tryParse('${r['since']}');
      final title = LocalizedText.tryParse(r['title']);
      if (since == null || title == null) {
        warnings.add('roles: every role needs "since" (a year) and "title"');
        continue;
      }
      roles.add(Role(since: since, title: title));
    }

    final path = <PathEntry>[];
    final ids = <String>{};
    for (final e in listOf('path')) {
      final id = e['id'];
      final where = 'path "${id ?? '?'}"';
      final start = YearMonth.tryParse(e['start']);
      final hasEnd = e['end'] != null;
      final end = hasEnd ? YearMonth.tryParse(e['end']) : null;
      final title = LocalizedText.tryParse(e['title']);
      final place = LocalizedText.tryParse(e['place']);
      final problems = <String>[
        if (id is! String || id.isEmpty) 'missing "id"',
        if (id is String && ids.contains(id)) 'duplicate "id"',
        if (!trackIds.contains(e['track']))
          '"track" must be one of ${trackIds.join(', ')}',
        if (start == null) '"start" must look like 2024-09',
        if (hasEnd && end == null) '"end" must look like 2025-06, or be null for now',
        if (start != null && end != null && end < start) '"end" is before "start"',
        if (title == null) 'missing "title"',
        if (place == null) 'missing "place"',
      ];
      if (problems.isNotEmpty) {
        warnings.add('$where skipped: ${problems.join('; ')}');
        continue;
      }
      ids.add(id as String);
      path.add(PathEntry(
        id: id,
        track: e['track'] as String,
        start: start!,
        end: end,
        label: e['label'] is String ? e['label'] as String : place!.of('en'),
        title: title!,
        place: place!,
        details: LocalizedText.tryParse(e['details']),
        highlights: LocalizedList.tryParse(e['highlights']),
        logo: e['logo'] is String ? e['logo'] as String : null,
        link: e['link'] is String ? e['link'] as String : null,
        links: linksOf(e['links'], where),
      ));
    }
    path.sort((a, b) => a.start.compareTo(b.start));

    final projects = <Project>[];
    for (final p in listOf('projects')) {
      final id = p['id'];
      final date = YearMonth.tryParse(p['date']);
      final title = LocalizedText.tryParse(p['title']);
      final summary = LocalizedText.tryParse(p['summary']);
      if (id is! String || date == null || title == null || summary == null) {
        warnings.add('project "${id ?? '?'}" skipped: needs "id", "date", "title" and "summary"');
        continue;
      }
      projects.add(Project(
        id: id,
        date: date,
        title: title,
        summary: summary,
        image: p['image'] is String ? p['image'] as String : null,
        tech: (p['tech'] is List ? p['tech'] as List : const [])
            .whereType<String>()
            .toList(),
        award: LocalizedText.tryParse(p['award']),
        links: linksOf(p['links'], 'project "$id"'),
      ));
    }
    projects.sort((a, b) => b.date.compareTo(a.date));

    final skills = <Skill>[];
    for (final s in listOf('skills')) {
      final name = s['name'];
      final level = s['level'] == 'daily'
          ? SkillLevel.daily
          : s['level'] == 'familiar'
              ? SkillLevel.familiar
              : null;
      if (name is! String || level == null) {
        warnings.add('skill "${name ?? '?'}" skipped: "level" must be daily or familiar');
        continue;
      }
      skills.add(Skill(
          name: name, area: s['area'] is String ? s['area'] as String : '', level: level));
    }

    return CareerData(
      tracks: tracks,
      roles: roles,
      path: path,
      projects: projects,
      skills: skills,
      warnings: warnings,
      photo: json['photo'] is String ? json['photo'] as String : null,
    );
  }
}
