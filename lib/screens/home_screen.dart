import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../utils/constants.dart';
import '../widgets/portfolio_widgets.dart';
import 'about_screen.dart';
import 'skills_screen.dart';
import 'projects_screen.dart';
import 'experience_screen.dart';
import 'education_screen.dart';
import 'contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(6, (index) => GlobalKey());
  int _currentIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    _currentIndex = index;
    final sectionKey = _sectionKeys[index];

    if (sectionKey.currentContext != null) {
      Scrollable.ensureVisible(
        sectionKey.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: const Text('Portfolio'),
              actions: [
                IconButton(
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  onPressed: () {
                    Provider.of<PortfolioProvider>(context, listen: false)
                        .toggleTheme();
                  },
                ),
              ],
            )
          : null,
      drawer: isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppConstants.fullName,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          AppConstants.shortBio,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white70,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  _buildDrawerItem(0, 'Home', Icons.home),
                  _buildDrawerItem(1, 'About', Icons.person),
                  _buildDrawerItem(2, 'Skills', Icons.code),
                  _buildDrawerItem(3, 'Projects', Icons.work),
                  _buildDrawerItem(4, 'Experience', Icons.business),
                  _buildDrawerItem(5, 'Education', Icons.school),
                  _buildDrawerItem(6, 'Contact', Icons.email),
                ],
              ),
            )
          : null,
      body: Stack(
        children: [
          // Main Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Hero Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[0],
                  height: size.height,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                    child: ResponsiveContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Profile Image
                          const AnimatedProfileImage(
                            imagePath: 'assets/images/profile.jpg',
                            size: 180,
                          ),
                          const SizedBox(height: 32),

                          // Name
                          Text(
                            AppConstants.fullName,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          )
                              .animate()
                              .fadeIn(duration: 800.ms)
                              .slideY(begin: 0.3, end: 0),

                          const SizedBox(height: 16),

                          // Animated Role Text
                          SizedBox(
                            height: 50,
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'Full Stack Developer',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Colors.white70,
                                      ),
                                  speed: const Duration(milliseconds: 100),
                                ),
                                TypewriterAnimatedText(
                                  'Mobile App Developer',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Colors.white70,
                                      ),
                                  speed: const Duration(milliseconds: 100),
                                ),
                                TypewriterAnimatedText(
                                  'UI/UX Enthusiast',
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Colors.white70,
                                      ),
                                  speed: const Duration(milliseconds: 100),
                                ),
                              ],
                              totalRepeatCount: 3,
                              pause: const Duration(milliseconds: 1000),
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Social Icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSocialIcon(
                                  Logo(Logos.github), AppConstants.github),
                              _buildSocialIcon(
                                  Logo(Logos.linkedin), AppConstants.linkedin),
                              _buildSocialIcon(
                                  Logo(Logos.twitter), AppConstants.twitter),
                            ],
                          ).animate().fadeIn(duration: 1200.ms),

                          const SizedBox(height: 48),

                          // Call to Action Button
                          ElevatedButton.icon(
                            onPressed: () => _scrollToSection(1),
                            icon: const Icon(Icons.arrow_downward),
                            label: const Text('View My Work'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                            ),
                          ).animate().fadeIn(duration: 1500.ms).scale(
                                begin: const Offset(0.8, 0.8),
                                end: const Offset(1, 1),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // About Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[1],
                  child: const AboutScreen(),
                ),
              ),

              // Skills Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[2],
                  child: const SkillsScreen(),
                ),
              ),

              // Projects Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[3],
                  child: const ProjectsScreen(),
                ),
              ),

              // Experience Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[4],
                  child: const ExperienceScreen(),
                ),
              ),

              // Education Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[5],
                  child: const EducationScreen(),
                ),
              ),

              // Contact Section
              SliverToBoxAdapter(
                child: Container(
                  child: const ContactScreen(),
                ),
              ),
            ],
          ),

          // Desktop Navigation
          if (!isMobile)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              const AssetImage('assets/images/profile.jpg'),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          AppConstants.fullName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),

                    // Navigation Links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildNavLink(0, 'Home'),
                        _buildNavLink(1, 'About'),
                        _buildNavLink(2, 'Skills'),
                        _buildNavLink(3, 'Projects'),
                        _buildNavLink(4, 'Experience'),
                        _buildNavLink(5, 'Education'),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () => _scrollToSection(6),
                          child: const Text('Contact Me'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: Icon(
                            Theme.of(context).brightness == Brightness.light
                                ? Icons.dark_mode
                                : Icons.light_mode,
                          ),
                          onPressed: () {
                            Provider.of<PortfolioProvider>(context,
                                    listen: false)
                                .toggleTheme();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavLink(int index, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () => _scrollToSection(index),
        style: TextButton.styleFrom(
          foregroundColor: _currentIndex == index
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).textTheme.titleMedium?.color,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight:
                _currentIndex == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(int index, String label, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: _currentIndex == index,
      selectedColor: Theme.of(context).colorScheme.secondary,
      onTap: () {
        Navigator.pop(context);
        _scrollToSection(index);
      },
    );
  }

  Widget _buildSocialIcon(Widget icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: IconButton(
        icon: icon,
        iconSize: 32,
        onPressed: () {},
        color: Colors.white,
      ),
    );
  }
}
