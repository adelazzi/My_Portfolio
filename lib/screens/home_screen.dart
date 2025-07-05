import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/portfolio_provider.dart';
import '../utils/constants.dart';
import '../widgets/portfolio_widgets.dart';
import '../widgets/animated_background.dart';
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
  final List<GlobalKey> _sectionKeys = List.generate(7, (index) => GlobalKey());
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

  Widget _buildSocialIcon(Widget icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(
        onPressed: () async {
          final uri = Uri.parse(url);
          // Use external application mode for all platforms
          const mode = LaunchMode.externalApplication;

          if (!await launchUrl(uri, mode: mode)) {
            debugPrint('Could not launch $url');
          }
        },
        icon: icon,
        color: Colors.white,
        iconSize: 28,
        style: IconButton.styleFrom(
          backgroundColor: Colors.white10,
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(int index, String title, IconData icon) {
    final isSelected = _currentIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.accentColor : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.accentColor : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      onTap: () {
        _scrollToSection(index);
        Navigator.pop(context);
      },
    );
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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.altCardColor
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/pattern.png'),
                        opacity: 0.1,
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    margin: EdgeInsets.zero,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.accentColor.withOpacity(0.3),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 32,
                                backgroundImage:
                                    AssetImage('assets/images/profile.jpg'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppConstants.fullName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    AppConstants.shortBio,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.white.withOpacity(0.85),
                                          height: 1.3,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: [
                            Chip(
                              label: Text(AppConstants.roles[0],
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white)),
                              backgroundColor:
                                  AppColors.accentColor.withOpacity(0.7),
                              padding: EdgeInsets.zero,
                            ),
                            Chip(
                              label: Text(
                                  AppConstants.roles.length > 1
                                      ? AppConstants.roles[1]
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white)),
                              backgroundColor:
                                  AppColors.tertiaryColor.withOpacity(0.7),
                              padding: EdgeInsets.zero,
                            ),
                          ],
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
                    // Creative gradient background
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor.withOpacity(0.8),
                        AppColors.altCardColor,
                      ],
                    ),
                    // Subtle pattern overlay
                    image: const DecorationImage(
                      image: AssetImage('assets/images/pattern.png'),
                      opacity: 0.05,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: AnimatedBackground(
                    child: Center(
                        child: ResponsiveContainer(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 90),
                            // Creative profile image with gradient border
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.accentColor,
                                    AppColors.tertiaryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.accentColor.withOpacity(0.5),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const AnimatedProfileImage(
                                imagePath: 'assets/images/profile.jpg',
                                size: 180,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Creative tagline
                            const Text(
                              AppConstants.tagline,
                              style: TextStyle(
                                color: AppColors.accentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 3,
                              ),
                            ).animate().fadeIn(duration: 600.ms, delay: 300.ms),

                            const SizedBox(height: 16),

                            // Name with creative styling
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Colors.white, AppColors.accentColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: Text(
                                AppConstants.fullName,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      height: 1.1,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms)
                                .slideY(begin: 0.3, end: 0),

                            const SizedBox(height: 16),

                            // Animated Role Text with creative presentation
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.white30),
                              ),
                              child: SizedBox(
                                height: 40,
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: AppConstants.roles
                                      .map((role) => TyperAnimatedText(
                                            role,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                            speed: const Duration(
                                                milliseconds: 70),
                                          ))
                                      .toList(),
                                  pause: const Duration(milliseconds: 1000),
                                  displayFullTextOnTap: true,
                                  stopPauseOnTap: true,
                                ),
                              ),
                            ).animate().fadeIn(duration: 800.ms, delay: 500.ms),

                            const SizedBox(height: 40),

                            // Creative quote
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                AppConstants.aboutQuote,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 1000.ms, delay: 700.ms),

                            const SizedBox(height: 40),

                            // Social Icons with modern styling
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildSocialIcon(
                                    Logo(Logos.github), AppConstants.github),
                                _buildSocialIcon(Logo(Logos.linkedin),
                                    AppConstants.linkedin),
                              ],
                            ).animate().fadeIn(duration: 1200.ms),

                            const SizedBox(height: 48),

                            // Creative CTA buttons
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.accentColor.withOpacity(0.4),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  )
                                ],
                                gradient: const LinearGradient(
                                  colors: AppColors.accentGradient,
                                ),
                              ),
                              child: ElevatedButton.icon(
                                onPressed: () => _scrollToSection(1),
                                icon: const Icon(Icons.arrow_downward),
                                label: const Text(AppConstants.viewWorkCTA),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 1200.ms, delay: 800.ms)
                                .scale(
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1, 1),
                                ),
                            const SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: OutlinedButton.icon(
                                onPressed: () => _scrollToSection(6),
                                icon: const Icon(Icons.mail_outline),
                                label: const Text(AppConstants.hireMeCTA),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  foregroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 1200.ms, delay: 900.ms)
                                .scale(
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1, 1),
                                ),
                          ],
                        ),
                      ),
                    )),
                  ),
                ),
              ),

              // About Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[1],
                  child: AboutScreen(key: UniqueKey()),
                ),
              ),

              // Skills Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[2],
                  child: SkillsScreen(key: UniqueKey()),
                ),
              ),

              // Projects Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[3],
                  child: ProjectsScreen(key: UniqueKey()),
                ),
              ),

              // Experience Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[4],
                  child: ExperienceScreen(key: UniqueKey()),
                ),
              ),

              // Education Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[5],
                  child: EducationScreen(key: UniqueKey()),
                ),
              ),

              // Contact Section
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[6],
                  child: ContactScreen(key: UniqueKey()),
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
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: const Text('Contact Me'),
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
}
