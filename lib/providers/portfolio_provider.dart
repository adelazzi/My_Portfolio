import 'package:flutter/material.dart';
import '../models/portfolio_models.dart';

class PortfolioProvider extends ChangeNotifier {
  // Sample Education Data
  final List<Education> educationList = [
    Education(
      degree: "B.Sc. in Computer Science",
      institution: "University of Technology",
      period: "2018 - 2022",
      description:
          "Graduated with honors. Specialized in Full Stack Development and Cloud Computing.",
      logoUrl: "assets/images/university_logo.png",
    ),
    Education(
      degree: "Full Stack Web Development Bootcamp",
      institution: "Tech Academy",
      period: "2021",
      description:
          "Intensive 6-month program focused on modern web development technologies.",
      logoUrl: "assets/images/bootcamp_logo.png",
    ),
  ];

  // Sample Experience Data
  final List<Experience> experienceList = [
    Experience(
      position: "Full Stack Developer",
      company: "TechCorp Inc.",
      period: "2022 - Present",
      description:
          "Working on enterprise-level web applications and microservices.",
      logoUrl: "assets/images/techcorp_logo.png",
      responsibilities: [
        "Developed responsive front-end interfaces using React and Angular",
        "Implemented RESTful APIs using Node.js and Express",
        "Optimized database queries and improved application performance",
        "Collaborated with UX/UI designers to implement modern interfaces",
      ],
    ),
    Experience(
      position: "Freelance Web Developer",
      company: "Self-employed",
      period: "2020 - 2022",
      description:
          "Worked with various clients to develop custom web solutions.",
      responsibilities: [
        "Built e-commerce platforms for small businesses",
        "Created content management systems for bloggers and content creators",
        "Optimized websites for search engine visibility and performance",
        "Provided ongoing maintenance and support for client websites",
      ],
    ),
  ];

  // Sample Project Data
  final List<Project> projectList = [
    Project(
      title: "E-commerce Platform",
      description:
          "A full-featured online store with payment integration, inventory management, and analytics.",
      imageUrl: "assets/images/projects/ecommerce.jpg",
      technologies: ["React", "Node.js", "MongoDB", "Stripe API"],
      liveUrl: "https://example-ecommerce.com",
      githubUrl: "https://github.com/yourusername/ecommerce",
    ),
    Project(
      title: "Task Management App",
      description:
          "A collaborative task manager with real-time updates, notifications, and progress tracking.",
      imageUrl: "assets/images/projects/taskmanager.jpg",
      technologies: ["Flutter", "Firebase", "Dart", "Google Cloud"],
      liveUrl: "https://task-manager-app.com",
      githubUrl: "https://github.com/yourusername/task-manager",
    ),
    Project(
      title: "Social Media Dashboard",
      description:
          "Analytics dashboard for social media managers with data visualization and automated reporting.",
      imageUrl: "assets/images/projects/dashboard.jpg",
      technologies: ["Vue.js", "D3.js", "Python", "Django", "PostgreSQL"],
      liveUrl: "https://social-dashboard.com",
      githubUrl: "https://github.com/yourusername/social-dashboard",
    ),
  ];

  // Sample Skills Data
  final List<Skill> skillsList = [
    // Frontend Skills
    Skill(name: "HTML/CSS", proficiency: 0.95, category: "Frontend"),
    Skill(name: "JavaScript", proficiency: 0.9, category: "Frontend"),
    Skill(name: "React", proficiency: 0.85, category: "Frontend"),
    Skill(name: "Angular", proficiency: 0.8, category: "Frontend"),
    Skill(name: "Flutter", proficiency: 0.85, category: "Frontend"),

    // Backend Skills
    Skill(name: "Node.js", proficiency: 0.9, category: "Backend"),
    Skill(name: "Python", proficiency: 0.8, category: "Backend"),
    Skill(name: "Django", proficiency: 0.75, category: "Backend"),
    Skill(name: "Express.js", proficiency: 0.85, category: "Backend"),

    // Database Skills
    Skill(name: "MongoDB", proficiency: 0.85, category: "Database"),
    Skill(name: "PostgreSQL", proficiency: 0.8, category: "Database"),
    Skill(name: "Firebase", proficiency: 0.9, category: "Database"),

    // DevOps Skills
    Skill(name: "Docker", proficiency: 0.7, category: "DevOps"),
    Skill(name: "AWS", proficiency: 0.65, category: "DevOps"),
    Skill(name: "CI/CD", proficiency: 0.7, category: "DevOps"),
  ];

  // Sample University Club Activities
  final List<ClubActivity> clubActivities = [
    ClubActivity(
      name: "Computer Science Society",
      role: "Tech Lead",
      period: "2019 - 2022",
      description:
          "Led the technical team in organizing hackathons and tech workshops.",
      logoUrl: "assets/images/cs_club_logo.png",
      achievements: [
        "Organized annual hackathon with 200+ participants",
        "Conducted weekly coding sessions for junior students",
        "Developed the club's website and management system",
      ],
    ),
    ClubActivity(
      name: "Entrepreneurship Club",
      role: "Member",
      period: "2020 - 2022",
      description:
          "Participated in startup competitions and networking events.",
      logoUrl: "assets/images/entrepreneur_club_logo.png",
      achievements: [
        "Won 2nd place in the university startup challenge",
        "Helped organize networking events with industry professionals",
        "Contributed to the club's annual business plan competition",
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
