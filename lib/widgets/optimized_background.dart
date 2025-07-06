import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class OptimizedAnimatedBackground extends StatefulWidget {
  final Widget child;

  const OptimizedAnimatedBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  OptimizedAnimatedBackgroundState createState() =>
      OptimizedAnimatedBackgroundState();
}

class OptimizedAnimatedBackgroundState
    extends State<OptimizedAnimatedBackground> with TickerProviderStateMixin {
  late AnimationController _controller;
  late final List<FloatingParticle> _particles;

  @override
  void initState() {
    super.initState();
    _particles = [];
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generateParticles(Size size) {
    if (_particles.isNotEmpty) return;

    final random = math.Random();
    const particleCount = 8; // Reduced from 20+ to 8

    for (int i = 0; i < particleCount; i++) {
      _particles.add(
        FloatingParticle(
          startX: random.nextDouble() * size.width,
          startY: random.nextDouble() * size.height,
          endX: random.nextDouble() * size.width,
          endY: random.nextDouble() * size.height,
          size: 20 + random.nextDouble() * 30,
          color: AppColors.accentColor
              .withOpacity(0.08 + random.nextDouble() * 0.04),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _generateParticles(size);

        return Stack(
          fit: StackFit.expand,
          children: [
            // Simple gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryColor,
                    AppColors.altCardColor,
                  ],
                ),
              ),
            ),

            // Subtle pattern overlay
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pattern.png'),
                  opacity: 0.03,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Optimized floating particles
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlePainter(_particles, _controller.value),
                  size: size,
                );
              },
            ),

            // Main content
            widget.child,
          ],
        );
      },
    );
  }
}

class FloatingParticle {
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final double size;
  final Color color;

  FloatingParticle({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.size,
    required this.color,
  });
}

class ParticlePainter extends CustomPainter {
  final List<FloatingParticle> particles;
  final double animationValue;

  ParticlePainter(this.particles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;

      // Calculate current position
      final currentX =
          particle.startX + (particle.endX - particle.startX) * animationValue;
      final currentY = particle.startY +
          (particle.endY - particle.startY) * animationValue +
          math.sin(animationValue * 2 * math.pi) * 10;

      // Draw simple circle
      canvas.drawCircle(
        Offset(currentX, currentY),
        particle.size / 2,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
