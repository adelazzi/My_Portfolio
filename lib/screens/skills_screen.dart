import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../models/portfolio_models.dart';
import '../providers/portfolio_provider.dart';
import '../utils/constants.dart';
import '../widgets/optimized_widgets.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final provider = Provider.of<PortfolioProvider>(context);

    // Group skills by category
    Map<String, List<Skill>> skillsByCategory = {};
    for (var skill in provider.skillsList) {
      if (!skillsByCategory.containsKey(skill.category)) {
        skillsByCategory[skill.category] = [];
      }
      skillsByCategory[skill.category]!.add(skill);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      child: ResponsiveContainer(
        child: Column(
          children: [
            const OptimizedSectionTitle(title: AppConstants.skillsTitle),
            const SizedBox(height: 24),

            // Short intro text about skills
            Text(
              'As a Full Stack Developer, I\'ve developed expertise in various technologies and tools. '
              'Here\'s a breakdown of my technical skills:',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            // Skills Categories
            isMobile
                ? _buildMobileSkillsLayout(context, skillsByCategory)
                : _buildDesktopSkillsLayout(context, skillsByCategory),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileSkillsLayout(
      BuildContext context, Map<String, List<Skill>> skillsByCategory) {
    return Column(
      children: skillsByCategory.entries.map((entry) {
        return _buildSkillCategory(context, entry.key, entry.value);
      }).toList(),
    );
  }

  Widget _buildDesktopSkillsLayout(
      BuildContext context, Map<String, List<Skill>> skillsByCategory) {
    // Divide skills into two columns
    List<String> categories = skillsByCategory.keys.toList();
    int midPoint = (categories.length / 2).ceil();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: categories.sublist(0, midPoint).map((category) {
              return _buildSkillCategory(
                  context, category, skillsByCategory[category]!);
            }).toList(),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            children: categories.sublist(midPoint).map((category) {
              return _buildSkillCategory(
                  context, category, skillsByCategory[category]!);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillCategory(
      BuildContext context, String category, List<Skill> skills) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Title
          Text(
            category,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 16),

          // Skills List
          ...skills.map((skill) {
            return OptimizedSkillBar(
              skillName: skill.name,
              proficiency: skill.proficiency,
            );
          }).toList(),
        ],
      ),
    );
  }
}
