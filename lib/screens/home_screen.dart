import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/portfolio_provider.dart';
import '../utils/constants.dart';
import '../widgets/optimized_widgets.dart';
import '../widgets/optimized_background.dart';
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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 10),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
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
          iconSize: isMobile ? 24 : 28,
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.1),
            padding: EdgeInsets.all(isMobile ? 10 : 12),
          ),
          tooltip: url.contains('github') ? 'GitHub' : 'LinkedIn',
        ),
      ),
    );
  }

  Widget _buildDrawerItem(int index, String title, IconData icon) {
    final isSelected = _currentIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? AppColors.accentColor.withOpacity(0.1) : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Icon(
          icon,
          color: isSelected ? AppColors.accentColor : Colors.grey[600],
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.accentColor : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 15,
          ),
        ),
        onTap: () {
          _scrollToSection(index);
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        selected: isSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: Text(
                'Portfolio',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 18 : 20,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
              actions: [
                IconButton(
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.light
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    size: 24,
                  ),
                  onPressed: () {
                    Provider.of<PortfolioProvider>(context, listen: false)
                        .toggleTheme();
                  },
                  tooltip: 'Toggle theme',
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
                      // Subtle pattern overlay
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
                  // Mobile-optimized navigation items
                  _buildDrawerItem(0, 'Home', Icons.home_rounded),
                  _buildDrawerItem(1, 'About', Icons.person_rounded),
                  _buildDrawerItem(2, 'Skills', Icons.code_rounded),
                  _buildDrawerItem(3, 'Projects', Icons.work_rounded),
                  _buildDrawerItem(4, 'Experience', Icons.business_rounded),
                  _buildDrawerItem(5, 'Education', Icons.school_rounded),
                  _buildDrawerItem(6, 'Contact', Icons.email_rounded),

                  // Additional mobile actions
                  const Divider(color: Colors.white24),
                  ListTile(
                    leading: Icon(
                      Theme.of(context).brightness == Brightness.light
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      color: Colors.grey[600],
                    ),
                    title: Text(
                      'Toggle Theme',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    onTap: () {
                      Provider.of<PortfolioProvider>(context, listen: false)
                          .toggleTheme();
                      Navigator.pop(context);
                    },
                  ),
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
                  ),
                  child: OptimizedAnimatedBackground(
                    child: Center(
                        child: ResponsiveContainer(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 24,
                          vertical: isMobile ? 20 : 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: isMobile ? 60 : 90),
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
                                    blurRadius: isMobile ? 15 : 20,
                                    spreadRadius: isMobile ? 3 : 5,
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.all(4),
                              child: OptimizedProfileImage(
                                imagePath: 'assets/images/profile.jpg',
                                size: isMobile ? 140 : 180,
                              ),
                            ),
                            SizedBox(height: isMobile ? 24 : 32),

                            // Creative tagline
                            Text(
                              AppConstants.tagline,
                              style: TextStyle(
                                color: AppColors.accentColor,
                                fontSize: isMobile ? 14 : 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: isMobile ? 2 : 3,
                              ),
                              textAlign: TextAlign.center,
                            ).animate().fadeIn(duration: 600.ms, delay: 300.ms),

                            SizedBox(height: isMobile ? 12 : 16),

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
                                      fontSize: isMobile ? 32 : 48,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms)
                                .slideY(begin: 0.3, end: 0),

                            SizedBox(height: isMobile ? 12 : 16),

                            // Animated Role Text with creative presentation
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 12 : 16,
                                vertical: isMobile ? 6 : 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.white30),
                              ),
                              child: SizedBox(
                                height: isMobile ? 32 : 40,
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
                                                  fontSize: isMobile ? 18 : 24,
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

                            SizedBox(height: isMobile ? 30 : 40),

                            // Creative quote
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: isMobile ? 8 : 10,
                                horizontal: isMobile ? 16 : 0,
                              ),
                              child: Text(
                                AppConstants.aboutQuote,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontStyle: FontStyle.italic,
                                  fontSize: isMobile ? 14 : 16,
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 1000.ms, delay: 700.ms),

                            SizedBox(height: isMobile ? 30 : 40),

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

                            SizedBox(height: isMobile ? 36 : 48),

                            // Creative CTA buttons - Stacked on mobile
                            if (isMobile) ...[
                              // Mobile: Stack buttons vertically
                              _buildMobileCTAButton(
                                onPressed: () => _scrollToSection(1),
                                icon: Icons.arrow_downward_rounded,
                                label: AppConstants.viewWorkCTA,
                                isPrimary: true,
                              ),
                              const SizedBox(height: 12),
                              _buildMobileCTAButton(
                                onPressed: () => _scrollToSection(6),
                                icon: Icons.mail_outline_rounded,
                                label: AppConstants.hireMeCTA,
                                isPrimary: false,
                              ),
                            ] else ...[
                              // Desktop: Keep horizontal layout
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.accentColor
                                              .withOpacity(0.4),
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
                                      label:
                                          const Text(AppConstants.viewWorkCTA),
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
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
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
                                  ),
                                ],
                              ),
                            ],
                            SizedBox(height: isMobile ? 40 : 20),
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

  Widget _buildMobileCTAButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required bool isPrimary,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: isPrimary
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentColor.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ],
                gradient: const LinearGradient(
                  colors: AppColors.accentGradient,
                ),
              ),
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(icon),
                label: Text(label),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            )
          : OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(label),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 1.5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
    ).animate().fadeIn(
        duration: 1200.ms,
        delay: Duration(milliseconds: isPrimary ? 800 : 900));
  }
}
