import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

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
                  "About Me",
                  style: isExtraSmallScreen
                      ? textTheme.headlineSmall
                      : textTheme.displaySmall,
                ),
                SizedBox(height: isExtraSmallScreen ? 20 : 32),

                // Personal intro
                isSmallScreen
                    ? _buildPersonalIntro(context, textTheme)
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: _buildPersonalIntro(context, textTheme)),
                          const SizedBox(width: 40),
                          Expanded(child: _buildProfileImage(context)),
                        ],
                      ),

                if (isSmallScreen) ...[
                  SizedBox(height: isExtraSmallScreen ? 24 : 32),
                  _buildProfileImage(context,
                      height: isExtraSmallScreen ? 250 : 400),
                ],

                SizedBox(height: isExtraSmallScreen ? 32 : 48),
                // Education
                Text(
                  "Education",
                  style: isExtraSmallScreen
                      ? textTheme.titleLarge
                      : textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                _buildEducationTimeline(context),

                SizedBox(height: isExtraSmallScreen ? 32 : 48),
                // Work Experience
                Text(
                  "Work Experience",
                  style: isExtraSmallScreen
                      ? textTheme.titleLarge
                      : textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                _buildWorkExperienceTimeline(context),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalIntro(BuildContext context, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I'm a High-Performance Computing (HPC) Master's student and Fullstack Developer",
          style: textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          "As an experienced developer, I specialize in creating efficient solutions using Django for backend development and Flutter for cross-platform mobile applications. My academic background in High-Performance Computing gives me unique insights into optimization and scalability.",
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          "I've worked with several SME companies, helping them build robust web and mobile applications. My focus is always on delivering high-quality, maintainable code that solves real business problems.",
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildChip("HPC", context),
            _buildChip("Django", context),
            _buildChip("Flutter", context),
            _buildChip("Python", context),
            _buildChip("Dart", context),
            _buildChip("Fullstack Development", context),
            _buildChip("Mobile Development", context),
          ],
        )
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context, {double? height}) {
    return Container(
      height: height ?? 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.person,
          size: height != null && height < 300 ? 80 : 120,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildChip(String label, BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
    );
  }

  Widget _buildEducationTimeline(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TimelineTheme(
      data: TimelineThemeData(
        color: colorScheme.primary,
        indicatorTheme: const IndicatorThemeData(size: 16.0),
        connectorTheme: const ConnectorThemeData(thickness: 2.0),
      ),
      child: Timeline(
        children: [
          TimelineTile(
            nodePosition: 0,
            contents: _buildTimelineCard(
              title: "Master's in High-Performance Computing",
              organization: "University Name",
              period: "2022 - Present",
              description:
                  "Specializing in parallel computing, distributed systems, and algorithm optimization.",
              context: context,
            ),
            node: const TimelineNode(
              indicator: OutlinedDotIndicator(),
              startConnector: SolidLineConnector(),
              endConnector: SolidLineConnector(),
            ),
          ),
          TimelineTile(
            nodePosition: 0,
            contents: _buildTimelineCard(
              title: "Bachelor's in Computer Science",
              organization: "University Name",
              period: "2018 - 2022",
              description:
                  "Core focus on software engineering, data structures, algorithms, and web development.",
              context: context,
            ),
            node: const TimelineNode(
              indicator: OutlinedDotIndicator(),
              startConnector: SolidLineConnector(),
              endConnector: SolidLineConnector(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkExperienceTimeline(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TimelineTheme(
      data: TimelineThemeData(
        color: colorScheme.primary,
        indicatorTheme: const IndicatorThemeData(size: 16.0),
        connectorTheme: const ConnectorThemeData(thickness: 2.0),
      ),
      child: Timeline(
        children: [
          TimelineTile(
            nodePosition: 0,
            contents: _buildTimelineCard(
              title: "Fullstack Developer",
              organization: "Tech Company XYZ",
              period: "2021 - Present",
              description:
                  "Developing and maintaining web and mobile applications using Django and Flutter. Leading a team of junior developers.",
              context: context,
            ),
            node: const TimelineNode(
              indicator: OutlinedDotIndicator(),
              startConnector: SolidLineConnector(),
              endConnector: SolidLineConnector(),
            ),
          ),
          TimelineTile(
            nodePosition: 0,
            contents: _buildTimelineCard(
              title: "Mobile Developer",
              organization: "Mobile Apps Studio",
              period: "2019 - 2021",
              description:
                  "Created cross-platform mobile applications with Flutter for various clients. Implemented complex UI designs and integrated RESTful APIs.",
              context: context,
            ),
            node: const TimelineNode(
              indicator: OutlinedDotIndicator(),
              startConnector: SolidLineConnector(),
              endConnector: SolidLineConnector(),
            ),
          ),
          TimelineTile(
            nodePosition: 0,
            contents: _buildTimelineCard(
              title: "Web Developer Intern",
              organization: "Web Solutions Inc.",
              period: "2018 - 2019",
              description:
                  "Assisted in developing Django-based web applications and learned about backend development and database design.",
              context: context,
            ),
            node: const TimelineNode(
              indicator: OutlinedDotIndicator(),
              startConnector: SolidLineConnector(),
              endConnector: SolidLineConnector(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard({
    required String title,
    required String organization,
    required String period,
    required String description,
    required BuildContext context,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.business,
                  size: 16,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  organization,
                  style: textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  period,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

// Timeline widget implementation
class Timeline extends StatelessWidget {
  final List<Widget> children;

  const Timeline({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children,
    );
  }
}

class TimelineTheme extends InheritedWidget {
  final TimelineThemeData data;

  const TimelineTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static TimelineThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<TimelineTheme>();
    return theme?.data ?? const TimelineThemeData();
  }

  @override
  bool updateShouldNotify(TimelineTheme oldWidget) => data != oldWidget.data;
}

class TimelineThemeData {
  final Color color;
  final IndicatorThemeData indicatorTheme;
  final ConnectorThemeData connectorTheme;

  const TimelineThemeData({
    this.color = Colors.blue,
    this.indicatorTheme = const IndicatorThemeData(),
    this.connectorTheme = const ConnectorThemeData(),
  });
}

class IndicatorThemeData {
  final double size;

  const IndicatorThemeData({this.size = 15.0});
}

class ConnectorThemeData {
  final double thickness;
  final Color color;

  const ConnectorThemeData({
    this.thickness = 2.0,
    this.color = Colors.blue,
  });
}

class TimelineTile extends StatelessWidget {
  final Widget contents;
  final TimelineNode node;
  final double nodePosition;

  const TimelineTile({
    Key? key,
    required this.contents,
    required this.node,
    this.nodePosition = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 50,
            child: node,
          ),
          Expanded(child: contents),
        ],
      ),
    );
  }
}

class TimelineNode extends StatelessWidget {
  final Widget indicator;
  final Widget startConnector;
  final Widget endConnector;

  const TimelineNode({
    Key? key,
    required this.indicator,
    required this.startConnector,
    required this.endConnector,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(child: startConnector),
        indicator,
        Flexible(child: endConnector),
      ],
    );
  }
}

class SolidLineConnector extends StatelessWidget {
  final Color? color;

  const SolidLineConnector({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = TimelineTheme.of(context);
    return Container(
      width: theme.connectorTheme.thickness,
      color: color ?? theme.color,
    );
  }
}

class OutlinedDotIndicator extends StatelessWidget {
  const OutlinedDotIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = TimelineTheme.of(context);
    final size = theme.indicatorTheme.size;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: theme.color,
        ),
        color: Colors.transparent,
      ),
    );
  }
}
