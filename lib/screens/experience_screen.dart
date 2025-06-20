import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../utils/constants.dart';
import '../widgets/portfolio_widgets.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PortfolioProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ResponsiveContainer(
        child: Column(
          children: [
            const SectionTitle(title: AppConstants.experienceTitle),
            const SizedBox(height: 24),

            // Experience intro text
            Text(
              'My professional journey includes work with various companies and freelance projects:',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            // Professional Experience
            ...provider.experienceList.asMap().entries.map((entry) {
              final index = entry.key;
              final experience = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: ExperienceCard(
                  position: experience.position,
                  company: experience.company,
                  period: experience.period,
                  description: experience.description,
                  logoUrl: experience.logoUrl,
                  responsibilities: experience.responsibilities,
                ),
              ).animate().fadeIn(delay: Duration(milliseconds: 200 * index));
            }).toList(),

            const SizedBox(height: 48),

            // University Club Activities Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'University Club Activities',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ).animate().fadeIn(duration: 800.ms),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 24),

            // Club Activities
            ...provider.clubActivities.asMap().entries.map((entry) {
              final index = entry.key;
              final club = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: ClubActivityCard(
                  name: club.name,
                  role: club.role,
                  period: club.period,
                  description: club.description,
                  logoUrl: club.logoUrl,
                  achievements: club.achievements,
                ),
              )
                  .animate()
                  .fadeIn(delay: Duration(milliseconds: 200 * index + 400));
            }).toList(),
          ],
        ),
      ),
    );
  }
}
