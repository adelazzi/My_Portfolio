import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Reset form after submission
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _nameController.clear();
          _emailController.clear();
          _subjectController.clear();
          _messageController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Thank you for your message! I\'ll get back to you soon.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                  "Contact Me",
                  style: isExtraSmallScreen
                      ? textTheme.headlineSmall
                      : textTheme.displaySmall,
                ),
                const SizedBox(height: 16),
                Text(
                  "Let's discuss your project or opportunity.",
                  style: isExtraSmallScreen
                      ? textTheme.bodyMedium
                      : textTheme.bodyLarge,
                ),
                SizedBox(height: isExtraSmallScreen ? 24 : 32),

                isSmallScreen
                    ? Column(
                        children: [
                          _buildContactForm(context, isExtraSmallScreen),
                          SizedBox(height: isExtraSmallScreen ? 32 : 48),
                          _buildContactInfo(context, isExtraSmallScreen),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child:
                                _buildContactForm(context, isExtraSmallScreen),
                          ),
                          const SizedBox(width: 64),
                          Expanded(
                            flex: 2,
                            child:
                                _buildContactInfo(context, isExtraSmallScreen),
                          ),
                        ],
                      ),

                SizedBox(height: isExtraSmallScreen ? 40 : 64),

                // Footer
                _buildFooter(context, isExtraSmallScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context, bool isExtraSmallScreen) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Send a Message",
          style: isExtraSmallScreen
              ? textTheme.titleLarge
              : textTheme.headlineMedium,
        ),
        SizedBox(height: isExtraSmallScreen ? 16 : 24),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(isExtraSmallScreen ? 16.0 : 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name field
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(
                        Icons.person_outline,
                        size: isExtraSmallScreen ? 18 : 24,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: isExtraSmallScreen
                          ? EdgeInsets.symmetric(vertical: 10, horizontal: 12)
                          : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isExtraSmallScreen ? 12 : 16),

                  // Email field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: isExtraSmallScreen ? 18 : 24,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: isExtraSmallScreen
                          ? EdgeInsets.symmetric(vertical: 10, horizontal: 12)
                          : null,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      // Simple email validation
                      if (!RegExp(
                              r"^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isExtraSmallScreen ? 12 : 16),

                  // Subject field
                  TextFormField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      labelText: "Subject",
                      prefixIcon: Icon(
                        Icons.subject,
                        size: isExtraSmallScreen ? 18 : 24,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: isExtraSmallScreen
                          ? EdgeInsets.symmetric(vertical: 10, horizontal: 12)
                          : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a subject';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isExtraSmallScreen ? 12 : 16),

                  // Message field
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: "Message",
                      prefixIcon: Icon(
                        Icons.message_outlined,
                        size: isExtraSmallScreen ? 18 : 24,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignLabelWithHint: true,
                      contentPadding: isExtraSmallScreen
                          ? EdgeInsets.symmetric(vertical: 10, horizontal: 12)
                          : null,
                    ),
                    maxLines: isExtraSmallScreen ? 4 : 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isExtraSmallScreen ? 20 : 24),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    height: isExtraSmallScreen ? 42 : 50,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitForm,
                      child: _isSubmitting
                          ? SizedBox(
                              width: isExtraSmallScreen ? 16 : 20,
                              height: isExtraSmallScreen ? 16 : 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              "Send Message",
                              style: TextStyle(
                                fontSize: isExtraSmallScreen ? 14 : 16,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context, bool isExtraSmallScreen) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Information",
          style: isExtraSmallScreen
              ? textTheme.titleLarge
              : textTheme.headlineMedium,
        ),
        SizedBox(height: isExtraSmallScreen ? 16 : 24),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(isExtraSmallScreen ? 16.0 : 24.0),
            child: Column(
              children: [
                _buildContactInfoItem(
                  icon: Icons.email,
                  title: "Email",
                  content: "yourname@example.com",
                  context: context,
                  isExtraSmallScreen: isExtraSmallScreen,
                ),
                Divider(height: isExtraSmallScreen ? 24 : 32),
                _buildContactInfoItem(
                  icon: Icons.phone,
                  title: "Phone",
                  content: "+1234567890",
                  context: context,
                  isExtraSmallScreen: isExtraSmallScreen,
                ),
                Divider(height: isExtraSmallScreen ? 24 : 32),
                _buildContactInfoItem(
                  icon: Icons.location_on,
                  title: "Location",
                  content: "City, Country",
                  context: context,
                  isExtraSmallScreen: isExtraSmallScreen,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: isExtraSmallScreen ? 24 : 32),
        Text(
          "Connect with me",
          style: isExtraSmallScreen
              ? textTheme.titleLarge
              : textTheme.headlineMedium,
        ),
        SizedBox(height: isExtraSmallScreen ? 16 : 24),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(isExtraSmallScreen ? 16.0 : 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(
                  icon: Icons.language,
                  onPressed: () {},
                  context: context,
                  isExtraSmallScreen: isExtraSmallScreen,
                ),
                _buildSocialButton(
                  icon: Icons.code,
                  onPressed: () {},
                  context: context,
                  isExtraSmallScreen: isExtraSmallScreen,
                ),
                _buildSocialButton(
                  icon: Icons.business_center,
                  onPressed: () {},
                  context: context,
                  isExtraSmallScreen: isExtraSmallScreen,
                ),
                _buildSocialButton(
                  icon: Icons.chat_bubble,
                  onPressed: () {},
                  context: context,
                  isExtraSmallScreen: isExtraSmallScreen,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoItem({
    required IconData icon,
    required String title,
    required String content,
    required BuildContext context,
    required bool isExtraSmallScreen,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(isExtraSmallScreen ? 8 : 12),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: colorScheme.primary,
            size: isExtraSmallScreen ? 16 : 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: isExtraSmallScreen
                    ? textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold)
                    : textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: isExtraSmallScreen ? 2 : 4),
              Text(
                content,
                style: isExtraSmallScreen
                    ? textTheme.bodyMedium
                    : textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
    required BuildContext context,
    required bool isExtraSmallScreen,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      icon: Icon(
        icon,
        size: isExtraSmallScreen ? 24 : 32,
      ),
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: colorScheme.primary.withOpacity(0.1),
        foregroundColor: colorScheme.primary,
        padding: EdgeInsets.all(isExtraSmallScreen ? 8 : 12),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isExtraSmallScreen) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const Divider(),
        SizedBox(height: isExtraSmallScreen ? 8 : 16),
        isExtraSmallScreen
            ? Column(
                children: [
                  Text(
                    "© ${DateTime.now().year} Your Name",
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "HPC & Fullstack Developer",
                    style: textTheme.bodySmall,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "© ${DateTime.now().year} Your Name",
                    style: textTheme.bodyMedium,
                  ),
                  Text(
                    "HPC & Fullstack Developer",
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
      ],
    );
  }
}
