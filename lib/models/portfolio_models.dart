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
}

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
}

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
}

class Skill {
  final String name;
  final double proficiency; // 0 to 1
  final String category; // e.g., "Frontend", "Backend", "DevOps"

  Skill({
    required this.name,
    required this.proficiency,
    required this.category,
  });
}

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
}
