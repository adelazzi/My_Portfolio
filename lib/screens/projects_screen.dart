import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../utils/constants.dart';
import '../widgets/portfolio_widgets.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<PortfolioProvider>(context);

    // Determine grid layout based on screen size
    int crossAxisCount;
    if (screenWidth < 600) {
      crossAxisCount = 1; // Mobile: 1 column
    } else if (screenWidth < 900) {
      crossAxisCount = 2; // Tablet: 2 columns
    } else {
      crossAxisCount = 3; // Desktop: 3 columns
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Theme.of(context).brightness == Brightness.light
          ? const Color(0xFFF9F9F9)
          : const Color(0xFF0D1117),
      child: ResponsiveContainer(
        child: Column(
          children: [
            const SectionTitle(title: AppConstants.projectsTitle),
            const SizedBox(height: 24),

            // Projects intro text
            Text(
              'Here are some of my recent projects that showcase my skills and expertise:',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            // Projects grid
            MasonryGridView.count(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.projectList.length,
              itemBuilder: (context, index) {
                final project = provider.projectList[index];
                return ProjectCard(
                  title: project.title,
                  description: project.description,
                  imageUrl: project.imageUrl,
                  technologies: project.technologies,
                  liveUrl: project.liveUrl,
                  githubUrl: project.githubUrl,
                  onTap: () => _showProjectDetails(context, project),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showProjectDetails(BuildContext context, dynamic project) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Project Image
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    project.imageUrl,
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Title
                      Text(
                        project.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),

                      // Project Description
                      Text(
                        project.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),

                      // Technologies Used
                      Text(
                        'Technologies Used:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.technologies.map<Widget>((tech) {
                          return Chip(
                            label: Text(tech),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            labelStyle: const TextStyle(color: Colors.white),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Project Links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (project.githubUrl != null)
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.code),
                              label: const Text('View Code'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[800],
                              ),
                            ),
                          const SizedBox(width: 16),
                          if (project.liveUrl != null)
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('Live Preview'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
