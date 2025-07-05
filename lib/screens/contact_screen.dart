import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../widgets/portfolio_widgets.dart';
import 'package:http/http.dart' as http;

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Theme.of(context).colorScheme.primary,
      child: ResponsiveContainer(
        child: Column(
          children: [
            // Section Title
            Text(
              AppConstants.contactTitle,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Contact intro text
            Text(
              'Get in touch with me for collaborations, opportunities, or just to say hi!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            // Contact Form and Details
            isMobile
                ? _buildMobileContactLayout(context)
                : _buildDesktopContactLayout(context),

            const SizedBox(height: 80),

            // Footer
            const Divider(color: Colors.white24),
            const SizedBox(height: 24),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileContactLayout(BuildContext context) {
    return Column(
      children: [
        // Contact Form
        _buildContactForm(context),
        const SizedBox(height: 48),

        // Contact Details
        _buildContactDetails(context),
      ],
    );
  }

  Widget _buildDesktopContactLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact Form
        Expanded(
          flex: 3,
          child: _buildContactForm(context),
        ),
        const SizedBox(width: 48),

        // Contact Details
        Expanded(
          flex: 2,
          child: _buildContactDetails(context),
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send Me a Message',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),

              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Your Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Message Field
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Your Message',
                  prefixIcon: Icon(Icons.message),
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.send),
                  label: const Text('Send Message'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildContactDetails(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),

            // Email
            _buildContactInfo(
              context,
              Icons.email,
              'Email',
              AppConstants.email,
            ),
            const SizedBox(height: 16),

            // Phone
            _buildContactInfo(
              context,
              Icons.phone,
              'Phone',
              AppConstants.phone,
            ),
            const SizedBox(height: 16),

            // Location
            _buildContactInfo(
              context,
              Icons.location_on,
              'Location',
              AppConstants.location,
            ),
            const SizedBox(height: 32),

            // Social Media Links
            Text(
              'Connect With Me',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),

            // Social Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSocialButton(context, Logos.linkedin, 'LinkedIn'),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildContactInfo(
      BuildContext context, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
          size: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      BuildContext context, dynamic logoData, String platform) {
    return ElevatedButton.icon(
      onPressed: () async {
        final uri = Uri.parse(AppConstants.linkedin);
        const mode = LaunchMode.externalApplication;

        if (!await launchUrl(uri, mode: mode)) {
          debugPrint('Could not launch ${AppConstants.linkedin}');
        }
      },
      icon: Logo(logoData),
      label: Text(platform),
      style: ElevatedButton.styleFrom(
        backgroundColor: _getSocialColor(platform),
        foregroundColor: Colors.white,
      ),
    );
  }

  Color _getSocialColor(String platform) {
    switch (platform) {
      case 'GitHub':
        return const Color(0xFF333333);
      case 'LinkedIn':
        return const Color(0xFF0077B5);

      default:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Logo(Logos.github),
              color: Colors.white,
              onPressed: () async {
                final uri = Uri.parse(AppConstants.github);
                const mode = LaunchMode.externalApplication;

                if (!await launchUrl(uri, mode: mode)) {
                  debugPrint('Could not launch ${AppConstants.github}');
                }
              },
            ),
            IconButton(
              icon: Logo(Logos.linkedin),
              color: Colors.white,
              onPressed: () async {
                final uri = Uri.parse(AppConstants.linkedin);
                const mode = LaunchMode.externalApplication;

                if (!await launchUrl(uri, mode: mode)) {
                  debugPrint('Could not launch ${AppConstants.linkedin}');
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '© ${DateTime.now().year} ${AppConstants.fullName}. All rights reserved.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white70,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Built with Flutter with ❤️',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white70,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final message = _messageController.text;

      final uri = Uri.parse(
          'https://formspree.io/f/xgvyljqb'); // Replace with your form ID
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: '''{
          "name": "$name",
          "email": "$email",
          "message": "$message"
        }''',
      );
      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Thank you $name! Your message has been sent.'),
              backgroundColor: Colors.green,
            ),
          );
        }

        // Clear the form
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Oops! Something went wrong. Please try again later.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
