
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:indicraft_major/repository/screens/auth/login.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _navigateToHome();
//   }
//
//   Future<void> _navigateToHome() async {
//     await Future.delayed(const Duration(seconds: 5));
//     if (!mounted) return;
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginPage()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Animated icon with color pulse
//             const Icon(
//               Icons.handyman_rounded,
//               size: 80,
//               color: Colors.orange,
//             )
//                 .animate()
//                 .scale(duration: 800.ms, begin: const Offset(0.7, 0.7))
//                 .then()
//                 .shake(hz: 3,)
//                 .then()
//                 .tint(color: Colors.deepOrange),
//
//             const SizedBox(height: 30),
//
//             // Main text with multiple effects
//             const Text(
//               'IndiCraft',
//               style: TextStyle(
//                 fontSize: 36,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.orange,
//                 letterSpacing: 1.5,
//               ),
//             )
//                 .animate()
//                 .fadeIn(duration: 500.ms)
//                 .slideY(begin: 0.5, curve: Curves.easeOut)
//                 .then()
//                 .shimmer(delay: 300.ms, duration: 1000.ms)
//                 .then()
//                 .tint(color: Colors.deepOrangeAccent),
//
//             const SizedBox(height: 10),
//
//             // Subtitle text
//             const Text(
//               'Crafting Indian Creativity',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             )
//                 .animate()
//                 .fadeIn(delay: 500.ms)
//                 .slideY(begin: 0.3, curve: Curves.easeOut),
//
//             const SizedBox(height: 40),
//
//             // Custom animated progress indicator
//             SizedBox(
//               width: 200,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: LinearProgressIndicator(
//                   backgroundColor: Colors.orange[100],
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
//                   minHeight: 8,
//                 ),
//               ),
//             )
//                 .animate(onPlay: (controller) => controller.repeat())
//                 .scaleX(duration: 1500.ms, begin: 0, end: 1)
//                 .then()
//                 .fadeOut(),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Animated background pattern (pure Flutter)
          Positioned.fill(
            child: CustomPaint(
              painter: _IndianPatternPainter(),
            ).animate().fadeIn(duration: 500.ms),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Handcrafted pottery wheel animation
                _buildPotteryWheel(),

                const SizedBox(height: 20),

                // App name with Indian-style typography
                Text(
                  'IndiCraft',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFE67F17), // Saffron
                    letterSpacing: 1.8,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.5, curve: Curves.easeOut)
                    .then()
                    .shimmer(
                  delay: 300.ms,
                  duration: 1500.ms,
                  color: const Color(0xFFD4AF37), // Gold
                ),

                const SizedBox(height: 8),

                // Tagline
                Text(
                  'Preserving Heritage, Empowering Artisans',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 700.ms)
                    .slideY(begin: 0.3, curve: Curves.easeOut),

                const SizedBox(height: 30),

                // Decorative divider
                _buildTraditionalDivider(),

                const SizedBox(height: 30),

                // Animated kolam-inspired loading
                _buildKolamLoader(),
              ],
            ),
          ),

          // Bottom welcome text
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Text(
              'स्वागतम्', // Welcome in Sanskrit
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansDevanagari(
                fontSize: 18,
                color: Colors.orange[700],
              ),
            )
                .animate()
                .fadeIn(delay: 1000.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildPotteryWheel() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Wheel base
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.orange.withOpacity(0.3),
                width: 8,
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .rotate(duration: 8000.ms, curve: Curves.linear),

          // Pottery in progress
          CustomPaint(
            painter: _PotteryPainter(),
            size: const Size(100, 100),
          )
              .animate()
              .scaleXY(begin: 0.5, end: 1, duration: 1500.ms)
              .then()
              .shake(hz: 2,),
        ],
      ),
    );
  }

  Widget _buildTraditionalDivider() {
    return CustomPaint(
      painter: _DividerPainter(),
      size: const Size(150, 20),
    )
        .animate()
        .scaleX(delay: 900.ms, duration: 800.ms, begin: 0);
  }

  Widget _buildKolamLoader() {
    return SizedBox(
      width: 80,
      height: 80,
      child: CustomPaint(
        painter: _KolamPainter(),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .rotate(duration: 3000.ms, curve: Curves.easeInOut);
  }
}

// Custom painters for all visual elements
class _IndianPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1, paint);
        if ((x ~/ step + y ~/ step) % 2 == 0) {
          canvas.drawCircle(Offset(x + step / 2, y + step / 2), 1, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PotteryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path()
      ..moveTo(size.width / 2, size.height / 4)
      ..quadraticBezierTo(
        size.width / 3,
        size.height / 2,
        size.width / 2,
        size.height * 3 / 4,
      )
      ..quadraticBezierTo(
        size.width * 2 / 3,
        size.height / 2,
        size.width / 2,
        size.height / 4,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dotCount = 10;
    final dotSpacing = size.width / (dotCount + 1);

    for (var i = 1; i <= dotCount; i++) {
      final x = dotSpacing * i;
      if (i % 2 == 0) {
        canvas.drawCircle(Offset(x, size.height / 2), 3, paint);
      } else {
        canvas.drawLine(
          Offset(x, size.height / 2 - 4),
          Offset(x, size.height / 2 + 4),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _KolamPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw a simple kolam pattern
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * (3.141592 / 180);
      canvas.drawLine(
        center,
        Offset(
          center.dx + 30 * cos(angle),
          center.dy + 30 * sin(angle),
        ),
        paint,
      );
    }

    // Inner rotating element
    canvas.drawCircle(center, 10, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}