import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icons_plus/icons_plus.dart';
import '../utils/constants.dart';

// Creative animation patterns
enum AnimationPattern {
  subtle, // Very subtle movement
  static, // No animation, just display with modern blur
  float, // Gentle floating animation
  pulse, // Pulsing scale animation
  spiral, // Spiral movement pattern
  bounce, // Bouncing effect
}

class AnimatedBackgroundParticle extends StatelessWidget {
  final double size;
  final double speed;
  final Color color;
  final String icon;
  final AnimationPattern pattern;
  final Offset position;

  const AnimatedBackgroundParticle({
    Key? key,
    required this.size,
    required this.speed,
    required this.color,
    required this.icon,
    required this.pattern,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create the modern icon particle directly
    final baseParticle = Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.12),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.white.withOpacity(0.12),
            Colors.white.withOpacity(0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(size / 2.5),
        border: Border.all(
          color: color.withOpacity(0.15),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(size / 3),
        ),
        child: Opacity(
          opacity: 0.75,
          child: _buildIconWidget(),
        ),
      ),
    );

    // Apply modern animation patterns
    switch (pattern) {
      case AnimationPattern.subtle:
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size / 3),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.03),
                  blurRadius: 3,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size / 3),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                child: baseParticle
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .moveY(
                      begin: 0,
                      end: 3 * speed,
                      duration: (4000 / speed).ms,
                      curve: Curves.easeInOut,
                    )
                    .fadeIn(
                      begin: 0.6,
                      duration: (2500 / speed).ms,
                      curve: Curves.easeInOut,
                    ),
              ),
            ),
          ),
        );

      case AnimationPattern.static:
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size / 3),
              border: Border.all(
                color: color.withOpacity(0.08),
                width: 0.8,
              ),
              gradient: RadialGradient(
                colors: [
                  color.withOpacity(0.08),
                  color.withOpacity(0.02),
                ],
              ),
            ),
            child: baseParticle.animate().fadeIn(
                  begin: 0.4,
                  duration: (2000 / speed).ms,
                ),
          ),
        );

      case AnimationPattern.float:
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size / 3),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.05),
                  blurRadius: 4,
                  spreadRadius: 0.8,
                ),
              ],
            ),
            child: baseParticle
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .moveY(
                  begin: 0,
                  end: 6 * speed,
                  duration: (4500 / speed).ms,
                  curve: Curves.easeInOut,
                )
                .moveX(
                  begin: 0,
                  end: 3 * speed,
                  duration: (6000 / speed).ms,
                  curve: Curves.easeInOut,
                )
                .fadeIn(
                  begin: 0.4,
                  duration: (3000 / speed).ms,
                  curve: Curves.easeInOut,
                ),
          ),
        );

      case AnimationPattern.pulse:
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size / 3),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 1.5,
                ),
              ],
            ),
            child: baseParticle
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .scale(
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(1.3, 1.3),
                  duration: (3000 / speed).ms,
                  curve: Curves.easeInOut,
                )
                .fadeIn(
                  begin: 0.3,
                  duration: (3000 / speed).ms,
                  curve: Curves.easeInOut,
                )
                .then()
                .fadeOut(
                  begin: 0.8,
                  duration: (1500 / speed).ms,
                  curve: Curves.easeInOut,
                ),
          ),
        );

      case AnimationPattern.spiral:
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: baseParticle
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .custom(
                duration: (10000 / speed).ms,
                builder: (context, value, child) {
                  final angle = value * 4 * math.pi;
                  final radius = value * 30 * speed;
                  return Transform.translate(
                    offset: Offset(
                      math.cos(angle) * radius,
                      math.sin(angle) * radius,
                    ),
                    child: Transform.rotate(
                      angle: -angle,
                      child: Transform.scale(
                        scale: 1.0 - (value * 0.3),
                        child: child,
                      ),
                    ),
                  );
                },
              )
              .fadeIn(
                begin: 0.6,
                duration: (8000 / speed).ms,
              )
              .then()
              .fadeOut(
                begin: 0.1,
                duration: (2000 / speed).ms,
              ),
        );

      case AnimationPattern.bounce:
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size / 3),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.08),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: baseParticle
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .moveY(
                  begin: 0,
                  end: -25 * speed,
                  duration: (2000 / speed).ms,
                  curve: Curves.bounceOut,
                )
                .then()
                .moveY(
                  begin: -25 * speed,
                  end: 0,
                  duration: (2000 / speed).ms,
                  curve: Curves.bounceIn,
                )
                .fadeIn(
                  begin: 0.5,
                  duration: (1500 / speed).ms,
                ),
          ),
        );
    }
  }

  Widget _buildIconWidget() {
    // Choose the appropriate icon based on the icon name
    switch (icon) {
      case 'flutter':
        return Logo(Logos.flutter);
      case 'dart':
        return Logo(Logos.android);
      case 'hadoop':
        return Logo(Logos.apache);
      case 'hive':
        return Logo(Logos.apache);
      case 'pig':
        return Logo(Logos.apache);
      case 'django':
        return Logo(Logos.django);
      case 'python':
        return Logo(Logos.python);
      case 'firebase':
        return Logo(Logos.firebase);
      case 'sql':
        return Logo(Logos.mysql);
      case 'mongodb':
        return Logo(Logos.mongodb);
      case 'figma':
        return Logo(Logos.figma);
      default:
        return Logo(Logos.flutter);
    }
  }
}

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  AnimatedBackgroundState createState() => AnimatedBackgroundState();
}

class AnimatedBackgroundState extends State<AnimatedBackground> {
  List<AnimatedBackgroundParticle> _buildParticles(Size size) {
    final particles = <AnimatedBackgroundParticle>[];
    final random = math.Random();

    // Using fewer particles for better performance
    final particleDensity = DesignElements.particleDensity ~/ 2;

    for (int i = 0; i < particleDensity; i++) {
      // Random parameters for the particles with more subtle values
      final particleSize = DesignElements.minParticleSize +
          random.nextDouble() *
              (DesignElements.maxParticleSize -
                  DesignElements.minParticleSize) *
              0.7;

      final speed = DesignElements.minParticleSpeed +
          random.nextDouble() *
              (DesignElements.maxParticleSpeed -
                  DesignElements.minParticleSpeed) *
              0.6;

      // Random position within the container
      final posX = random.nextDouble() * size.width;
      final posY = random.nextDouble() * size.height;

      // Random icon from our tech stack
      final iconIndex =
          random.nextInt(DesignElements.techIconsForBackground.length);
      final icon = DesignElements.techIconsForBackground[
          iconIndex]; // Creative animation patterns with more variety
      final patterns = [
        AnimationPattern.subtle,
        AnimationPattern.static,
        AnimationPattern.float,
        AnimationPattern.pulse,
        AnimationPattern.spiral,
        AnimationPattern.bounce,
      ];
      final pattern = patterns[random.nextInt(
          patterns.length)]; // Modern color palette with subtle opacity
      final List<Color> colorOptions = [
        AppColors.primaryColor.withOpacity(0.15),
        AppColors.accentColor.withOpacity(0.15),
        AppColors.tertiaryColor.withOpacity(0.12),
        AppColors.quaternaryColor.withOpacity(0.15),
      ];

      final color = colorOptions[random.nextInt(colorOptions.length)];

      particles.add(
        AnimatedBackgroundParticle(
          size: particleSize,
          speed: speed,
          color: color,
          icon: icon,
          pattern: pattern,
          position: Offset(posX, posY),
        ),
      );
    }

    return particles;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final particles = _buildParticles(size);

        return Stack(
          fit: StackFit.expand,
          children: [
            // Modern gradient background with dynamic effects
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.01),
                    AppColors.primaryColor.withOpacity(0.02),
                    Colors.white.withOpacity(0.03),
                    AppColors.accentColor.withOpacity(0.01),
                  ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),

            // Add subtle noise texture
            Opacity(
              opacity: 0.02,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><defs><filter id="noiseFilter"><feTurbulence baseFrequency="0.9" numOctaves="4" stitchTiles="stitch"/></filter></defs><rect width="100%" height="100%" filter="url(%23noiseFilter)" opacity="0.4"/></svg>'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Interactive background with particles
            ...particles,

            // Main content
            widget.child,
          ],
        );
      },
    );
  }
}

// Modern interactive particle with hover effect
class InteractiveParticle extends StatefulWidget {
  final double size;
  final Color color;
  final String icon;

  const InteractiveParticle({
    Key? key,
    required this.size,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  InteractiveParticleState createState() => InteractiveParticleState();
}

class InteractiveParticleState extends State<InteractiveParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _controller.forward();
      }),
      onExit: (_) => setState(() {
        _controller.reverse();
      }),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.size / 3),
              boxShadow: [
                BoxShadow(
                  color: widget.color
                      .withOpacity(0.05 + (0.05 * _controller.value)),
                  blurRadius: 5 + (5 * _controller.value),
                  spreadRadius: 1 + _controller.value,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.size / 3),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 2.0 * _controller.value,
                    sigmaY: 2.0 * _controller.value),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.05 + (0.05 * _controller.value)),
                    borderRadius: BorderRadius.circular(widget.size / 3),
                    border: Border.all(
                      color: Colors.white
                          .withOpacity(0.1 + (0.1 * _controller.value)),
                      width: 0.5,
                    ),
                  ),
                  child: Transform.scale(
                    scale: 1.0 + (0.08 * _controller.value),
                    child: Opacity(
                      opacity: 0.6 + (0.3 * _controller.value),
                      child: Padding(
                        padding: EdgeInsets.all(widget.size * 0.15),
                        child: _buildIconWidget(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconWidget() {
    // Choose the appropriate icon based on the icon name
    switch (widget.icon) {
      case 'flutter':
        return Logo(Logos.flutter);
      case 'dart':
        return Logo(Logos.android);
      case 'hadoop':
        return Logo(Logos.apache);
      case 'hive':
        return Logo(Logos.apache);
      case 'pig':
        return Logo(Logos.apache);
      case 'django':
        return Logo(Logos.django);
      case 'python':
        return Logo(Logos.python);
      case 'firebase':
        return Logo(Logos.firebase);
      case 'sql':
        return Logo(Logos.mysql);
      case 'mongodb':
        return Logo(Logos.mongodb);
      case 'figma':
        return Logo(Logos.figma);
      default:
        return Logo(Logos.flutter);
    }
  }
}
