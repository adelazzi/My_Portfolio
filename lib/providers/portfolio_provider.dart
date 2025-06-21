import 'package:flutter/material.dart';
import '../models/portfolio_models.dart';

class PortfolioProvider extends ChangeNotifier {
  // Sample Education Data
  final List<Education> educationList = [
    Education(
      degree: "Licentiate degree in Computer Science",
      institution: "USTHB University",
      period: "2020 - 2024",
      description:
          "Four-year degree focusing on algorithm development, data structures, and multiple programming languages. Developed strong problem-solving skills through competitive programming challenges and complex project implementations.",
      logoUrl: "assets/images/university_logo.png",
    ),
    Education(
      degree: "HPC Master's Program",
      institution: "USTHB",
      period: "2025",
      description:
          "One of the top-performing students in this advanced program. Focusing on optimizing performance in computing clusters and parallel handling of huge data sets. Learning cutting-edge techniques for high-performance computing applications and distributed systems architecture.",
      logoUrl: "assets/images/university_logo.png",
    ),
  ];

  // Sample Experience Data
  final List<Experience> experienceList = [
    Experience(
      position: "Flutter developer",
      company: "Hiske Dev",
      period: "2024 - 2025",
      description:
          "Developed mobile applications for business clients with focus on enterprise solutions and integration with existing systems.",
      logoUrl: "assets/images/hoskadev.png",
      responsibilities: [
        "Developed responsive front-end interfaces using Flutter GetX",
        "Led data preprocessing and cleaning initiatives for real projects",
        "Joined the mobile development team to create custom applications for external clients",
        "Collaborated with UX/UI designers to implement modern interfaces",
      ],
    ),
    Experience(
      position: "Full Stack Developer",
      company: "Matrix software Solutions",
      period: "6 months",
      description:
          "Developed full-stack mobile apps with Django APIs and Flutter frontends. Implemented authentication systems and responsive UIs with seamless backend integration.",
      logoUrl: "assets/images/matrix.png",
      responsibilities: [
        "Developed Flutter mobile apps with responsive UI and clean architecture",
        "Built RESTful APIs using Django for backend services and data management",
        "Implemented Dijkstra's algorithm for efficient route finding in a delivery tracking app",
        "Optimized path-finding algorithms for real-time navigation with reduced computational overhead",
        "Integrated Django ORM with spatial databases to support geolocation features",
      ],
    ),
    Experience(
      position: "Class Delegate",
      company: "USTHB University",
      period: "2022 - 2024",
      description:
          "Served as the primary liaison between students and professors, facilitating effective communication and ensuring academic concerns were addressed promptly.",
      logoUrl: "assets/images/university_logo.png",
      responsibilities: [
        "Coordinated class schedules and exam logistics with department administration",
        "Organized study groups and collaborative learning sessions for complex subjects",
        "Mediated conflicts and represented student interests in departmental meetings",
        "Maintained communication channels between faculty and students for announcements and feedback",
        "Facilitated resolution of academic issues affecting student performance and well-being",
      ],
    ),
    Experience(
      position: "Logistics Volunteer",
      company: "Arab Games",
      period: "2023",
      description:
          "Volunteered as part of the logistics team for this prestigious international sporting event, ensuring smooth operations and coordination between various stakeholders.",
      logoUrl: "assets/images/arab_games_logo.png",
      responsibilities: [
        "Coordinated equipment and supplies distribution across multiple event venues",
        "Assisted with transportation logistics for athletes and officials",
        "Supported venue setup and breakdown operations for different sporting competitions",
        "Collaborated with international teams to resolve logistical challenges",
        "Helped manage scheduling and resource allocation during the event",
      ],
    ),
  ];

  // Sample Project Data
  final List<Project> projectList = [
    Project(
      title: "Olivia - E-Commerce Mobile App",
      description:
          "A comprehensive e-commerce mobile application that connects marketers with admins. Features include product management, order processing, financial tracking, inventory management, and real-time analytics for sellers. Implemented secure payment gateways and user authentication.",
      imageUrl: "assets/images/projects/olivia.jpg",
      technologies: ["Flutter", "Firebase"],
      liveUrl: "",
      githubUrl: "",
    ),
    Project(
      title: "GIMDZ - Finance Mobile App",
      description:
          "A comprehensive personal finance application for managing credit cards, bank accounts, and budgeting. Features include expense tracking, bill reminders, financial insights dashboard, custom budget categories, and AI-driven savings recommendations for users to better manage their finances.",
      imageUrl: "assets/images/projects/gimdz.jpg",
      technologies: ["Flutter", "Firebase", "Dart", "Django"],
      liveUrl: "",
      githubUrl: "",
    ),
    Project(
      title: "Econnect - Internation Compition Mobile App",
      description:
          "An event organization app that allows users to find volunteers, purchase tickets, and manage event activities. Features include real-time volunteer management, secure ticket sales, analytics dashboard, and participant communication tools. Won first place in an international competition for its innovative approach to event coordination.",
      imageUrl: "assets/images/projects/ecconnect.jpg",
      technologies: ["flutter", "Dart"],
      liveUrl: "",
      githubUrl: "",
    ),
  ];

  // Sample Skills Data
  final List<Skill> skillsList = [
    // Frontend Skills
    Skill(name: "HTML/CSS", proficiency: 0.6, category: "Frontend"),
    Skill(name: "dart", proficiency: 0.8, category: "Frontend"),
    Skill(name: "flutter", proficiency: 0.85, category: "Frontend"),
    Skill(name: "Flutter GetX", proficiency: 0.75, category: "Frontend"),

    // Backend Skills
    Skill(name: "Python", proficiency: 0.8, category: "Backend"),
    Skill(name: "Django", proficiency: 0.75, category: "Backend"),

    // Database Skills
    Skill(name: "MongoDB", proficiency: 0.85, category: "Database"),
    Skill(name: "mysql", proficiency: 0.8, category: "Database"),
    Skill(name: "Firebase", proficiency: 0.9, category: "Database"),

    // DevOps Skills
    Skill(name: "Docker", proficiency: 0.7, category: "DevOps"),
    Skill(name: "github", proficiency: 0.65, category: "DevOps"),
    Skill(name: "Azure", proficiency: 0.3, category: "DevOps"),
    Skill(name: "Hadoop", proficiency: 0.5, category: "DevOps"),
  ];

  // Sample University Club Activities
  final List<ClubActivity> clubActivities = [
    ClubActivity(
      name: "OMC Club",
      role: "Team Leader",
      period: "2022 - present",
      description:
          "Started as a regular member and progressively grew to become a team leader through dedication and technical contributions. Now responsible for monitoring team progress and mentoring new members, representing significant professional growth within the organization.",
      logoUrl: "assets/images/omc_club.png",
      achievements: [
        "Organized hands-on workshops teaching Flutter and GetX to club members",
        "Coordinated multiple hackathons and served as a team mentor",
        "Won first place in an international competition with the club team",
      ],
    ),
    ClubActivity(
      name: "GDG Algeria",
      role: "Logitics Member",
      period: "2024 - present",
      description:
          "Responsible for coordinating event logistics, managing venue setup, and ensuring smooth execution of tech meetups and workshops. Collaborated with cross-functional teams to organize resources, handled equipment needs, and created detailed event plans to facilitate successful community gatherings and learning sessions.",
      logoUrl: "assets/images/gdgalgeria.png",
      achievements: [
        "Streamlined event logistics for 10+ tech conferences using custom calendar management systems",
        "Implemented task management workflows that improved team coordination by 40%",
        "Developed an event planning calendar that synchronized responsibilities across multiple organizing teams",
      ],
    ),
  ];

  // Theme mode
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
