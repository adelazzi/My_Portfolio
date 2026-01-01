class Certafication {
  final String name;
  final String issuer;
  final String date;
  final String credential;
  Certafication({
    required this.name,
    required this.issuer,
    required this.date,
    required this.credential,
  });

  factory Certafication.fromJson(Map<String, dynamic> json) {
    return Certafication(
      name: _safeString(json['degree']),
      issuer: _safeString(json['institution']),
      date: _safeString(json['period']),
      credential: _safeString(json['description']),
    );
  }

  


  




}

// ✅ FIXED EDUCATION (add safeString)

class Education {
  final String degree;
  final String institution;
  final String period;
  final String description;
  final String? logoUrl;

  Education({
    required this.degree,
    required this.institution,
    required this.period,
    required this.description,
    this.logoUrl,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: _safeString(json['degree']),
      institution: _safeString(json['institution']),
      period: _safeString(json['period']),
      description: _safeString(json['description']),
      logoUrl: _safeString(json['logoUrl']).isEmpty
          ? null
          : _safeString(json['logoUrl']),
    );
  }
}

// ✅ FIXED EXPERIENCE (OK but add _safeString to ALL)
class Experience {
  final String position;
  final String company;
  final String period;
  final String description;
  final String? logoUrl;
  final List<String> responsibilities;

  Experience({
    required this.position,
    required this.company,
    required this.period,
    required this.description,
    this.logoUrl,
    required this.responsibilities,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      position: _safeString(json['position']),
      company: _safeString(json['company']),
      period: _safeString(json['period']),
      description: _safeString(json['description']),
      logoUrl: _safeString(json['logoUrl']).isEmpty
          ? null
          : _safeString(json['logoUrl']),
      responsibilities: _safeStringList(json['responsibilities']),
    );
  }
}

// ✅ FIXED PROJECT (BROKEN technologies!)
class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? liveUrl;
  final String? githubUrl;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.liveUrl,
    this.githubUrl,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: _safeString(json['title']),
      description: _safeString(json['description']),
      imageUrl: _safeString(json['imageUrl']),
      technologies: _safeStringList(json['technologies']),
      liveUrl: _safeString(json['liveUrl']).isEmpty
          ? null
          : _safeString(json['liveUrl']),
      githubUrl: _safeString(json['githubUrl']).isEmpty
          ? null
          : _safeString(json['githubUrl']),
    );
  }
}

// ✅ FIXED SKILL (add safeString)
class Skill {
  final String name;
  final double proficiency;
  final String category;

  Skill({
    required this.name,
    required this.proficiency,
    required this.category,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: _safeString(json['name']),
      proficiency: (json['proficiency'] as num?)?.toDouble() ?? 0.0,
      category: _safeString(json['category']),
    );
  }
}

// ✅ FIXED CLUBACTIVITY (nullable list fix)
class ClubActivity {
  final String name;
  final String role;
  final String period;
  final String description;
  final String? logoUrl;
  final List<String>? achievements;

  ClubActivity({
    required this.name,
    required this.role,
    required this.period,
    required this.description,
    this.logoUrl,
    this.achievements,
  });

  factory ClubActivity.fromJson(Map<String, dynamic> json) {
    return ClubActivity(
      name: _safeString(json['name']),
      role: _safeString(json['role']),
      period: _safeString(json['period']),
      description: _safeString(json['description']),
      logoUrl: _safeString(json['logoUrl']).isEmpty
          ? null
          : _safeString(json['logoUrl']),
      achievements: json['achievements'] != null
          ? _safeStringList(json['achievements'])
          : null,
    );
  }
}

// ✅ ADD THESE STATIC HELPERS AT BOTTOM (STATIC = KEY!)
String _safeString(dynamic value) {
  return value?.toString() ?? '';
}

List<String> _safeStringList(dynamic value) {
  if (value == null) return <String>[];
  if (value is List) {
    return value.map((e) => _safeString(e)).where((e) => e.isNotEmpty).toList();
  }
  return [_safeString(value)];
}
