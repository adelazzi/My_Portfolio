import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _selectedCategory = "All";
  final List<String> _categories = ["All", "Flutter", "Django", "HPC", "Web"];

  final List<ProjectModel> _projects = [
    ProjectModel(
      title: "E-Commerce Mobile App",
      description:
          "A cross-platform e-commerce application built with Flutter and Firebase. Features include user authentication, product browsing, shopping cart, and payment integration.",
      imageUrl: "assets/images/projects/ecommerce.png", // Placeholder
      technologies: ["Flutter", "Firebase", "Dart", "Stripe API"],
      categories: ["Flutter", "Mobile"],
      link: "https://github.com/yourusername/ecommerce-app",
      featured: true,
    ),
    ProjectModel(
      title: "CRM System",
      description:
          "A comprehensive Customer Relationship Management system built with Django. Includes customer data management, sales tracking, and reporting features.",
      imageUrl: "assets/images/projects/crm.png", // Placeholder
      technologies: ["Django", "Python", "PostgreSQL", "Docker"],
      categories: ["Django", "Web"],
      link: "https://github.com/yourusername/crm-system",
      featured: true,
    ),
    ProjectModel(
      title: "Parallel Data Processing Framework",
      description:
          "A high-performance computing framework for processing large datasets in parallel. Implemented using MPI and OpenMP for optimal performance.",
      imageUrl: "assets/images/projects/hpc.png", // Placeholder
      technologies: ["C++", "MPI", "OpenMP", "Python"],
      categories: ["HPC"],
      link: "https://github.com/yourusername/parallel-data-processing",
      featured: true,
    ),
    ProjectModel(
      title: "Task Management App",
      description:
          "A task management application with Flutter frontend and Django REST API backend. Features include task creation, assignment, progress tracking, and notifications.",
      imageUrl: "assets/images/projects/task.png", // Placeholder
      technologies: ["Flutter", "Django REST Framework", "PostgreSQL"],
      categories: ["Flutter", "Django", "Mobile", "Web"],
      link: "https://github.com/yourusername/task-manager",
      featured: false,
    ),
    ProjectModel(
      title: "Real Estate Platform",
      description:
          "A web platform for real estate listings with property search, filtering, and user accounts. Built with Django and JavaScript.",
      imageUrl: "assets/images/projects/realestate.png", // Placeholder
      technologies: ["Django", "JavaScript", "PostgreSQL", "Google Maps API"],
      categories: ["Django", "Web"],
      link: "https://github.com/yourusername/real-estate-platform",
      featured: false,
    ),
    ProjectModel(
      title: "GPU-Accelerated Simulation",
      description:
          "A physical simulation accelerated using CUDA for GPU computation. Significantly improved performance compared to CPU-only implementation.",
      imageUrl: "assets/images/projects/gpu.png", // Placeholder
      technologies: ["CUDA", "C++", "Python"],
      categories: ["HPC"],
      link: "https://github.com/yourusername/gpu-simulation",
      featured: false,
    ),
  ];

  List<ProjectModel> get filteredProjects {
    if (_selectedCategory == "All") {
      return _projects;
    }
    return _projects
        .where((project) => project.categories.contains(_selectedCategory))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 800;
    final isExtraSmallScreen = size.width < 480;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  isExtraSmallScreen ? 16.0 : (isSmallScreen ? 24.0 : 80.0),
              vertical: isExtraSmallScreen ? 20.0 : 40.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Projects",
                  style: isExtraSmallScreen
                      ? textTheme.headlineSmall
                      : textTheme.displaySmall,
                ),
                const SizedBox(height: 16),
                Text(
                  "Here are some of the projects I've worked on for clients and personal development.",
                  style: isExtraSmallScreen
                      ? textTheme.bodyMedium
                      : textTheme.bodyLarge,
                ),
                SizedBox(height: isExtraSmallScreen ? 24 : 32),

                // Categories filter - always scrollable to ensure it works on all screen sizes
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories
                        .map(
                          (category) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: FilterChip(
                              label: Text(category),
                              selected: _selectedCategory == category,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                              backgroundColor: Colors.transparent,
                              selectedColor:
                                  colorScheme.primary.withOpacity(0.2),
                              side: BorderSide(
                                color: _selectedCategory == category
                                    ? colorScheme.primary
                                    : colorScheme.onSurface.withOpacity(0.3),
                              ),
                              checkmarkColor: colorScheme.primary,
                              padding: EdgeInsets.symmetric(
                                horizontal: isExtraSmallScreen ? 4.0 : 8.0,
                              ),
                              labelStyle: isExtraSmallScreen
                                  ? const TextStyle(fontSize: 12)
                                  : null,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),

                // Featured Projects
                _buildFeaturedProjects(
                    context, isSmallScreen, isExtraSmallScreen),

                SizedBox(height: isExtraSmallScreen ? 24 : 32),

                // Other Projects Grid
                Text(
                  "Other Projects",
                  style: isExtraSmallScreen
                      ? textTheme.titleLarge
                      : textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                _buildProjectsGrid(context, isSmallScreen, isExtraSmallScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedProjects(
      BuildContext context, bool isSmallScreen, bool isExtraSmallScreen) {
    final textTheme = Theme.of(context).textTheme;
    final featuredProjects =
        filteredProjects.where((project) => project.featured).toList();

    if (featuredProjects.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured Projects",
          style: isExtraSmallScreen
              ? textTheme.titleLarge
              : textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        for (var i = 0; i < featuredProjects.length; i++)
          _buildFeaturedProjectCard(
            featuredProjects[i],
            context,
            isSmallScreen,
            i % 2 == 0, // alternate layout
            isExtraSmallScreen,
          ),
      ],
    );
  }

  Widget _buildProjectsGrid(
      BuildContext context, bool isSmallScreen, bool isExtraSmallScreen) {
    final otherProjects =
        filteredProjects.where((project) => !project.featured).toList();

    if (otherProjects.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            "No other projects in this category.",
            style: isExtraSmallScreen
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isExtraSmallScreen ? 1 : (isSmallScreen ? 2 : 3),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio:
            isExtraSmallScreen ? 1.3 : (isSmallScreen ? 1.4 : 0.9),
      ),
      itemCount: otherProjects.length,
      itemBuilder: (context, index) {
        final project = otherProjects[index];
        return _buildProjectCard(project, context, isExtraSmallScreen);
      },
    );
  }

  Widget _buildFeaturedProjectCard(
    ProjectModel project,
    BuildContext context,
    bool isSmallScreen,
    bool leftAligned,
    bool isExtraSmallScreen,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (isSmallScreen) {
      // Mobile layout
      return Card(
        elevation: 4,
        margin: EdgeInsets.only(bottom: isExtraSmallScreen ? 16.0 : 24.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: colorScheme.primary.withOpacity(0.1),
                child: const Center(
                  child: Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isExtraSmallScreen ? 12.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: isExtraSmallScreen
                        ? textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)
                        : textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: isExtraSmallScreen ? 8 : 12),
                  Text(
                    project.description,
                    style: isExtraSmallScreen
                        ? textTheme.bodySmall
                        : textTheme.bodyMedium,
                  ),
                  SizedBox(height: isExtraSmallScreen ? 12 : 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: project.technologies.map((tech) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Chip(
                            label: Text(
                              tech,
                              style: isExtraSmallScreen
                                  ? const TextStyle(fontSize: 10)
                                  : null,
                            ),
                            backgroundColor:
                                colorScheme.primary.withOpacity(0.1),
                            side: BorderSide(
                                color: colorScheme.primary.withOpacity(0.3)),
                            padding:
                                isExtraSmallScreen ? EdgeInsets.zero : null,
                            labelPadding: isExtraSmallScreen
                                ? const EdgeInsets.symmetric(horizontal: 4)
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: isExtraSmallScreen ? 12 : 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.open_in_new),
                    label: const Text("View Project"),
                    onPressed: () {
                      // Open project link
                    },
                    style: isExtraSmallScreen
                        ? ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            textStyle: const TextStyle(fontSize: 12),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // Desktop layout
      return Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leftAligned)
              Expanded(
                flex: 3,
                child: _buildProjectImage(colorScheme),
              ),
            SizedBox(width: leftAligned ? 32 : 0),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: leftAligned
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Text(
                    project.title,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: leftAligned ? TextAlign.left : TextAlign.right,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        project.description,
                        style: textTheme.bodyLarge,
                        textAlign:
                            leftAligned ? TextAlign.left : TextAlign.right,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment:
                        leftAligned ? WrapAlignment.start : WrapAlignment.end,
                    children: project.technologies.map((tech) {
                      return Chip(
                        label: Text(tech),
                        backgroundColor: colorScheme.primary.withOpacity(0.1),
                        side: BorderSide(
                          color: colorScheme.primary.withOpacity(0.3),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.open_in_new),
                    label: const Text("View Project"),
                    onPressed: () {
                      // Open project link
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: leftAligned ? 0 : 32),
            if (!leftAligned)
              Expanded(
                flex: 3,
                child: _buildProjectImage(colorScheme),
              ),
          ],
        ),
      );
    }
  }

  Widget _buildProjectImage(ColorScheme colorScheme) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.image,
          size: 50,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildProjectCard(
      ProjectModel project, BuildContext context, bool isExtraSmallScreen) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {
            // Open project details
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project image or placeholder
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: colorScheme.primary.withOpacity(0.1),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: isExtraSmallScreen ? 30 : 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(isExtraSmallScreen ? 12.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: isExtraSmallScreen
                            ? textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)
                            : textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isExtraSmallScreen ? 4 : 8),
                      Text(
                        project.description,
                        style: isExtraSmallScreen
                            ? textTheme.bodySmall
                            : textTheme.bodyMedium,
                        maxLines: isExtraSmallScreen ? 2 : 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            icon: Icon(Icons.open_in_new,
                                size: isExtraSmallScreen ? 14 : 16),
                            label: Text(
                              "View",
                              style: TextStyle(
                                  fontSize: isExtraSmallScreen ? 12 : 14),
                            ),
                            onPressed: () {
                              // Open project link
                            },
                          ),
                          Wrap(
                            spacing: 4,
                            children: project.categories
                                .take(isExtraSmallScreen ? 1 : 2)
                                .map((category) {
                              return Chip(
                                label: Text(
                                  category,
                                  style: TextStyle(
                                      fontSize: isExtraSmallScreen ? 8 : 10),
                                ),
                                backgroundColor:
                                    colorScheme.primary.withOpacity(0.1),
                                side: BorderSide(
                                  color: colorScheme.primary.withOpacity(0.3),
                                ),
                                padding: EdgeInsets.zero,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: isExtraSmallScreen ? 2 : 4,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class ProjectModel {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final List<String> categories;
  final String link;
  final bool featured;

  ProjectModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.categories,
    required this.link,
    required this.featured,
  });
}
