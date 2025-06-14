import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ParticleModel> particles = [];
  final int numberOfParticles = 30;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Generate particles
    for (int i = 0; i < numberOfParticles; i++) {
      particles.add(ParticleModel(
        position: Offset(
          math.Random().nextDouble() * 1.0,
          math.Random().nextDouble() * 1.0,
        ),
        speed: Offset(
          math.Random().nextDouble() * 0.02 - 0.01,
          math.Random().nextDouble() * 0.02 - 0.01,
        ),
        size: math.Random().nextDouble() * 10 + 2,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 800;
    // Extra small screens (most phones)
    final isExtraSmallScreen = size.width < 480;

    return Scaffold(
      body: Stack(
        children: [
          // Background particles animation
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // Update particle positions
              for (var particle in particles) {
                particle.position += particle.speed;

                // Bounce off the edges
                if (particle.position.dx < 0 || particle.position.dx > 1.0) {
                  particle.speed =
                      Offset(-particle.speed.dx, particle.speed.dy);
                }
                if (particle.position.dy < 0 || particle.position.dy > 1.0) {
                  particle.speed =
                      Offset(particle.speed.dx, -particle.speed.dy);
                }
              }

              return CustomPaint(
                size: Size.infinite,
                painter: ParticlePainter(particles),
              );
            },
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    isExtraSmallScreen ? 16.0 : (isSmallScreen ? 24.0 : 80.0),
                vertical: isExtraSmallScreen ? 20.0 : 40.0,
              ),
              child: isSmallScreen
                  ? _buildMobileLayout(textTheme, isExtraSmallScreen)
                  : _buildDesktopLayout(textTheme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(TextTheme textTheme) {
    return Row(
      children: [
        // Left side - Text content
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, I'm a",
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "High-Performance Computing & Fullstack Developer",
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Building efficient solutions with Django & Flutter",
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Scroll to projects section
                    },
                    child: const Text('View my work'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Scroll to contact section
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    child: const Text('Contact me'),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Right side - Animated illustration
        Expanded(
          flex: 4,
          child: _buildAnimatedAvatar(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(TextTheme textTheme, bool isExtraSmallScreen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top area - animated avatar
        SizedBox(
          height: isExtraSmallScreen ? 150 : 200,
          child: Center(
            child: _buildAnimatedAvatar(isSmall: true),
          ),
        ),
        SizedBox(height: isExtraSmallScreen ? 20 : 40),

        // Text content
        Text(
          "Hello, I'm a",
          style: isExtraSmallScreen
              ? textTheme.titleLarge
              : textTheme.headlineMedium,
        ),
        SizedBox(height: isExtraSmallScreen ? 4 : 8),
        Text(
          "HPC & Fullstack Developer",
          style: isExtraSmallScreen
              ? textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)
              : textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: isExtraSmallScreen ? 8 : 16),
        Text(
          "Building efficient solutions with Django & Flutter",
          style:
              isExtraSmallScreen ? textTheme.bodyMedium : textTheme.bodyLarge,
        ),
        SizedBox(height: isExtraSmallScreen ? 20 : 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton(
              onPressed: () {
                // Scroll to projects section
              },
              child: const Text('View my work'),
            ),
            OutlinedButton(
              onPressed: () {
                // Scroll to contact section
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: isExtraSmallScreen ? 16 : 24,
                    vertical: isExtraSmallScreen ? 10 : 14),
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
              child: const Text('Contact me'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedAvatar({bool isSmall = false}) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: isSmall ? 180 : 300,
            height: isSmall ? 180 : 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                transform: GradientRotation(_controller.value * 2 * math.pi),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Icon(
                  Icons.code,
                  size: isSmall ? 60 : 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ParticleModel {
  Offset position; // Position from 0-1 for relative coordinates
  Offset speed; // Movement speed and direction
  double size; // Size of the particle

  ParticleModel({
    required this.position,
    required this.speed,
    required this.size,
  });
}

class ParticlePainter extends CustomPainter {
  final List<ParticleModel> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF0062FF).withOpacity(0.4);

    for (var particle in particles) {
      // Convert the relative position (0-1) to actual screen coordinates
      final position = Offset(
        particle.position.dx * size.width,
        particle.position.dy * size.height,
      );

      canvas.drawCircle(position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
