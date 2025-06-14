import 'package:flutter/material.dart';
import 'dart:math' as math;

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({Key? key}) : super(key: key);

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 800;
    final isExtraSmallScreen = size.width < 480;

    return Scaffold(
      body: SafeArea(
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
                "My Skills",
                style: isExtraSmallScreen
                    ? textTheme.headlineSmall
                    : textTheme.displaySmall,
              ),
              const SizedBox(height: 16),
              Text(
                "I specialize in high-performance computing, backend development, and cross-platform mobile applications.",
                style: isExtraSmallScreen
                    ? textTheme.bodyMedium
                    : textTheme.bodyLarge,
              ),
              SizedBox(height: isExtraSmallScreen ? 24 : 32),

              // Tab Bar
              isExtraSmallScreen
                  ? _buildScrollableTabBar()
                  : TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: "Programming Languages"),
                        Tab(text: "Frameworks & Libraries"),
                        Tab(text: "Tools & Technologies"),
                      ],
                      labelColor: Theme.of(context).colorScheme.primary,
                      unselectedLabelColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                      indicatorColor: Theme.of(context).colorScheme.primary,
                    ),
              const SizedBox(height: 24),

              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildProgrammingLanguagesTab(context, isSmallScreen),
                    _buildFrameworksTab(context, isSmallScreen),
                    _buildToolsTab(context, isSmallScreen),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableTabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: "Programming Languages"),
          Tab(text: "Frameworks & Libraries"),
          Tab(text: "Tools & Technologies"),
        ],
        labelColor: Theme.of(context).colorScheme.primary,
        unselectedLabelColor:
            Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        indicatorColor: Theme.of(context).colorScheme.primary,
        isScrollable: true,
      ),
    );
  }

  Widget _buildProgrammingLanguagesTab(
      BuildContext context, bool isSmallScreen) {
    final List<SkillModel> skills = [
      SkillModel("Python", 95, "Advanced - 5+ years",
          "Primary language for backend development and HPC"),
      SkillModel("Dart", 90, "Advanced - 3+ years", "For Flutter development"),
      SkillModel("JavaScript", 85, "Advanced - 4+ years",
          "For web development and frontend"),
      SkillModel(
          "Java", 75, "Intermediate - 3 years", "For Android development"),
      SkillModel("C/C++", 70, "Intermediate - 2 years",
          "For high-performance computing"),
      SkillModel("SQL", 88, "Advanced - 4+ years", "Database query language"),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          for (var skill in skills) _buildSkillItem(skill, context),
        ],
      ),
    );
  }

  Widget _buildFrameworksTab(BuildContext context, bool isSmallScreen) {
    final List<SkillModel> skills = [
      SkillModel(
          "Django", 95, "Advanced - 4+ years", "Primary backend framework"),
      SkillModel("Flutter", 90, "Advanced - 3+ years",
          "Cross-platform mobile app development"),
      SkillModel("Django REST Framework", 90, "Advanced - 4 years",
          "For building RESTful APIs"),
      SkillModel(
          "React", 75, "Intermediate - 2 years", "For frontend development"),
      SkillModel("NumPy/Pandas", 85, "Advanced - 3+ years",
          "For data analysis and manipulation"),
      SkillModel("TensorFlow/PyTorch", 70, "Intermediate - 2 years",
          "For machine learning projects"),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          for (var skill in skills) _buildSkillItem(skill, context),
        ],
      ),
    );
  }

  Widget _buildToolsTab(BuildContext context, bool isSmallScreen) {
    final List<SkillModel> skills = [
      SkillModel("Git/GitHub", 90, "Advanced - 5+ years",
          "Version control and collaboration"),
      SkillModel("Docker", 85, "Advanced - 3+ years",
          "Containerization and deployment"),
      SkillModel("PostgreSQL/MySQL", 88, "Advanced - 4+ years",
          "Database management systems"),
      SkillModel("CI/CD", 80, "Advanced - 3 years",
          "Automated testing and deployment"),
      SkillModel("AWS/Azure", 75, "Intermediate - 2 years", "Cloud platforms"),
      SkillModel(
          "MPI/OpenMP", 70, "Intermediate - 2 years", "For parallel computing"),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          for (var skill in skills) _buildSkillItem(skill, context),
        ],
      ),
    );
  }

  Widget _buildSkillItem(SkillModel skill, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${skill.percentage}%",
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                skill.level,
                style: textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Spacer(),
              Text(
                skill.description,
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: skill.percentage / 100),
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              backgroundColor: colorScheme.primary.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(
    String title,
    IconData icon,
    List<String> skills,
    BuildContext context,
    bool isSmallScreen,
  ) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: isSmallScreen ? double.infinity : 350,
      ),
      child: Card(
        elevation: 4,
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const Divider(height: 32),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var skill in skills)
                    Chip(
                      label: Text(skill),
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkillPieChart extends StatelessWidget {
  final List<SkillCategory> categories;

  const SkillPieChart({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: CustomPaint(
        painter: PieChartPainter(
          categories: categories,
          context: context,
        ),
      ),
    );
  }
}

class SkillCategory {
  final String name;
  final double percentage;
  final Color color;

  SkillCategory({
    required this.name,
    required this.percentage,
    required this.color,
  });
}

class PieChartPainter extends CustomPainter {
  final List<SkillCategory> categories;
  final BuildContext context;

  PieChartPainter({
    required this.categories,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    double startAngle = 0;

    for (var category in categories) {
      final sweepAngle = 2 * math.pi * (category.percentage / 100);
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = category.color;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw label
      final labelAngle = startAngle + sweepAngle / 2;
      final dx = radius * 0.7 * math.cos(labelAngle);
      final dy = radius * 0.7 * math.sin(labelAngle);
      final labelPosition = center + Offset(dx, dy);

      final textPainter = TextPainter(
        text: TextSpan(
          text: category.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        labelPosition - Offset(textPainter.width / 2, textPainter.height / 2),
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SkillModel {
  final String name;
  final double percentage;
  final String level;
  final String description;

  SkillModel(this.name, this.percentage, this.level, this.description);
}
