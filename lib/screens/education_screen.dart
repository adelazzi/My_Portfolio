import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/portfolio_provider.dart';
import '../utils/constants.dart';
import '../widgets/portfolio_widgets.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PortfolioProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Theme.of(context).brightness == Brightness.light
          ? const Color(0xFFF9F9F9)
          : const Color(0xFF0D1117),
      child: ResponsiveContainer(
        child: Column(
          children: [
            const SectionTitle(title: AppConstants.educationTitle),
            const SizedBox(height: 24),

            // Education intro text
            Text(
              'My educational background that has shaped my skills and knowledge:',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            // Education Timeline
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.educationList.length,
              itemBuilder: (context, index) {
                final education = provider.educationList[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: EducationCard(
                    degree: education.degree,
                    institution: education.institution,
                    period: education.period,
                    description: education.description,
                    logoUrl: education.logoUrl,
                  ),
                ).animate().fadeIn(delay: Duration(milliseconds: 200 * index));
              },
            ),

            const SizedBox(height: 48),

            // Certifications Section
            Text(
              'Certifications',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 800.ms),
            const SizedBox(height: 24),

            // Sample Certifications
            _buildCertifications(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCertifications(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Sample certifications data
    final certifications = [
      {
        'name': 'Licensed Computer Scientist',
        'issuer': 'USTHB',
        'date': 'juin 2024',
        'credential':
            'https://drive.google.com/file/d/1TRhmmKkNHx_toEhfd8XvQ33pbhOnLwaY/view?usp=drive_link',
      },
      {
        'name': 'Valteer Arab Games 2023',
        'issuer': 'Algeria',
        'date': 'juilly 2022',
        'credential':
            'https://drive.google.com/file/d/1TTnSF_7Z5bXIhf-0Pb97UOdDXy-B6aQQ/view?usp=drive_link',
      },
      {
        'name': 'Hoska Dev Training',
        'issuer': 'Hoska Dev',
        'date': '2023 - 2025',
        'credential':
            'https://drive.google.com/file/d/1TTkK1Swgf5DdmtcWS5jjf50DYq3xiArq/view?usp=drive_link',
      },
    ];

    return isMobile
        ? Column(
            children: certifications.map((cert) {
              return _buildCertificationCard(context, cert);
            }).toList(),
          )
        : Row(
            children: certifications.map((cert) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildCertificationCard(context, cert),
                ),
              );
            }).toList(),
          );
  }

  Widget _buildCertificationCard(
      BuildContext context, Map<String, String> cert) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Certificate Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.workspace_premium,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),

            // Certificate Name
            Text(
              cert['name']!,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Issuer & Date
            Text(
              '${cert['issuer']} • ${cert['date']}',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // View Certificate Button
            OutlinedButton(
              onPressed: () async {
                final uri = Uri.parse(cert['credential'].toString());
                const mode = LaunchMode.externalApplication;

                if (!await launchUrl(uri, mode: mode)) {
                  debugPrint('Could not launch ${cert['credential']}');
                }
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('View Certificate'),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }
}
