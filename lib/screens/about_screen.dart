import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../widgets/optimized_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  // Function to download and open the CV
  Future<void> _downloadCV(BuildContext context) async {
    try {
      // URL of your CV file (replace with your actual hosted CV)
      const String cvUrl = AppConstants.cvUrl;
      final Uri url = Uri.parse(cvUrl);

      // For all platforms, open CV in external application/browser
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint('Error downloading CV: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error downloading CV: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ResponsiveContainer(
        child: Column(
          children: [
            const OptimizedSectionTitle(title: AppConstants.aboutTitle),

            // About Content (Responsive Layout)
            isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Image
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/profile.jpg',
            width: 250,
            height: 250,
            fit: BoxFit.cover,
          ),
        ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0),

        const SizedBox(height: 32),

        // About Text
        _buildAboutContent(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Image
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/profile.jpg',
                height: 400,
                fit: BoxFit.cover,
              ),
            ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2, end: 0),
          ),
        ),

        // About Text
        Expanded(
          flex: 6,
          child: _buildAboutContent(context),
        ),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Greeting
        Text(
          'Hello There!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.2, end: 0),

        const SizedBox(height: 16),

        // About Text
        Text(
          AppConstants.aboutMe,
          style: Theme.of(context).textTheme.bodyLarge,
        ).animate().fadeIn(duration: 1000.ms),

        const SizedBox(height: 32),

        // Personal Information
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoItem(
                      context, Icons.email, 'Email:', AppConstants.email),
                  _buildInfoItem(
                      context, Icons.phone, 'Phone:', AppConstants.phone),
                ],
              ),
            ),

            // Right Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoItem(context, Icons.location_on, 'Location:',
                      AppConstants.location),
                  _buildInfoItem(context, Bootstrap.github, 'GitHub:',
                      'https://github.com/adelazzi'),
                ],
              ),
            ),
          ],
        ).animate().fadeIn(duration: 1200.ms),

        const SizedBox(height: 32),

        // Download CV Button
        ElevatedButton.icon(
          onPressed: () => _downloadCV(context),
          icon: const Icon(Icons.download),
          label: const Text('Download CV'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ).animate().fadeIn(duration: 1400.ms),
      ],
    );
  }

  Widget _buildInfoItem(
      BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
