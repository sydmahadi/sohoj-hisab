import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'date_calculator_screen.dart';
import 'calculator_screen.dart';
import 'time_sum_screen.dart';
import 'daily_average_screen.dart';
import 'monthly_average_screen.dart';
import 'browser_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'সহজ হিসাব',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Stack(
        children: [
          // ==========================================
          // Islamic Geometric Background
          // ==========================================
          const Positioned.fill(
            child: _IslamicBackground(),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                25,
              ),
              child: Column(
                children: [
                  // ==================================
                  // Premium Header
                  // ==================================
                  const _HeaderCard(),

                  const SizedBox(height: 25),

                  const Text(
                    'হিসাবের ধরন',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.goldLight,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'প্রয়োজনীয় হিসাব নির্বাচন করুন',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 17),

                  // ==================================
                  // 3 Column Grid
                  // ==================================
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.82,

                    children: [
                      // 1. সাধারণ ক্যালকুলেটর
                      _MenuCard(
                        icon: Icons.calculate_rounded,
                        title: 'সাধারণ\nক্যালকুলেটর',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const CalculatorScreen(),
                            ),
                          );
                        },
                      ),

                      // 2. তারিখ হিসাব
                      _MenuCard(
                        icon: Icons.event_available_rounded,
                        title: 'তারিখ\nহিসাব',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const DateCalculatorScreen(),
                            ),
                          );
                        },
                      ),

                      // 3. সময় যোগ
                      _MenuCard(
                        icon: Icons.access_time_rounded,
                        title: 'সময় যোগ',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const TimeSumScreen(),
                            ),
                          );
                        },
                      ),

                      // 4. দৈনিক গড়
                      _MenuCard(
                        icon: Icons.today_rounded,
                        title: 'দৈনিক গড়',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const DailyAverageScreen(),
                            ),
                          );
                        },
                      ),

                      // 5. মাসিক গড়
                      _MenuCard(
                        icon: Icons.calendar_month_rounded,
                        title: 'মাসিক গড়',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const MonthlyAverageScreen(),
                            ),
                          );
                        },
                      ),

                      // 6. ব্রাউজার
                      _MenuCard(
                        icon: Icons.language_rounded,
                        title: 'ব্রাউজার',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const BrowserScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ==================================
                  // Bottom Islamic Ornament
                  // ==================================
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      _ornamentLine(),

                      const SizedBox(width: 12),

                      const Icon(
                        Icons.auto_awesome,
                        color: AppTheme.gold,
                        size: 16,
                      ),

                      const SizedBox(width: 12),

                      _ornamentLine(),
                    ],
                  ),

                  const SizedBox(height: 13),

                  // ==================================
                  // Developer Information
                  // ==================================
                  const Column(
                    children: [
                      Text(
                        'Developed by Talpatar Sepai',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.textMuted,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        'm.talpatarsepai@gmail.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.gold,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================
  // Gold Ornament Line
  // ================================================
  static Widget _ornamentLine() {
    return Container(
      width: 45,
      height: 1,
      color: AppTheme.gold.withValues(
        alpha: 0.45,
      ),
    );
  }
}


// =====================================================
// PREMIUM HEADER
// =====================================================

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        18,
        23,
        18,
        22,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),

        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF123A29),
            Color(0xFF071B14),
          ],
        ),

        border: Border.all(
          color: AppTheme.gold.withValues(
            alpha: 0.28,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.35,
            ),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        children: [
          // Top Islamic Ornament
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              _diamond(),

              const SizedBox(width: 10),

              _line(),

              const SizedBox(width: 10),

              const Icon(
                Icons.star_rounded,
                color: AppTheme.gold,
                size: 17,
              ),

              const SizedBox(width: 10),

              _line(),

              const SizedBox(width: 10),

              _diamond(),
            ],
          ),

          const SizedBox(height: 18),

          // Bismillah
          const Text(
            'بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.goldLight,
              fontSize: 17,
            ),
          ),

          const SizedBox(height: 13),

          // App Name
          const Text(
            'সহজ হিসাব',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'সহজে হিসাব করুন',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.goldLight,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'দৈনিক, মাসিক ও সাধারণ হিসাব এক জায়গায়',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 17),

          // Bottom Ornament
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          AppTheme.gold.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget _line() {
    return Container(
      width: 55,
      height: 1,
      color: AppTheme.gold.withValues(
        alpha: 0.4,
      ),
    );
  }

  static Widget _diamond() {
    return Transform.rotate(
      angle: pi / 4,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.gold,
          ),
        ),
      ),
    );
  }
}


// =====================================================
// GRID MENU CARD
// =====================================================

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),

        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 14,
          ),

          decoration: BoxDecoration(
            color: AppTheme.card,

            borderRadius:
                BorderRadius.circular(20),

            border: Border.all(
              color: AppTheme.gold.withValues(
                alpha: 0.17,
              ),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.28,
                ),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 55,
                height: 55,

                decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF176B45),
                      Color(0xFF0A3525),
                    ],
                  ),

                  borderRadius:
                      BorderRadius.circular(17),

                  border: Border.all(
                    color:
                        AppTheme.gold.withValues(
                      alpha: 0.22,
                    ),
                  ),
                ),

                child: Icon(
                  icon,
                  color: AppTheme.goldLight,
                  size: 28,
                ),
              ),

              const SizedBox(height: 12),

              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 13,
                  height: 1.25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Small Gold Ornament
              Container(
                width: 20,
                height: 1,
                color: AppTheme.gold.withValues(
                  alpha: 0.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// =====================================================
// ISLAMIC GEOMETRIC BACKGROUND
// =====================================================

class _IslamicBackground extends StatelessWidget {
  const _IslamicBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _IslamicPatternPainter(),
    );
  }
}


class _IslamicPatternPainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = AppTheme.gold.withValues(
        alpha: 0.045,
      );

    const spacing = 90.0;

    // Repeated Islamic geometric pattern
    for (
      double x = -spacing;
      x < size.width + spacing;
      x += spacing
    ) {
      for (
        double y = -spacing;
        y < size.height + spacing;
        y += spacing
      ) {
        _drawStar(
          canvas,
          Offset(x, y),
          28,
          paint,
        );
      }
    }

    // Large subtle center pattern
    final largePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = AppTheme.gold.withValues(
        alpha: 0.025,
      );

    _drawStar(
      canvas,
      Offset(
        size.width / 2,
        size.height / 2,
      ),
      145,
      largePaint,
    );
  }

  void _drawStar(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
  ) {
    const points = 8;

    final path = Path();

    for (
      int i = 0;
      i < points * 2;
      i++
    ) {
      final angle = (i * pi) / points;

      final currentRadius =
          i.isEven
              ? radius
              : radius * 0.48;

      final point = Offset(
        center.dx +
            currentRadius *
                cos(angle),
        center.dy +
            currentRadius *
                sin(angle),
      );

      if (i == 0) {
        path.moveTo(
          point.dx,
          point.dy,
        );
      } else {
        path.lineTo(
          point.dx,
          point.dy,
        );
      }
    }

    path.close();

    canvas.drawPath(
      path,
      paint,
    );

    // Inner diamond
    final innerPath = Path();

    for (
      int i = 0;
      i < 4;
      i++
    ) {
      final angle = (i * pi) / 2;

      final point = Offset(
        center.dx +
            radius *
                0.42 *
                cos(angle),
        center.dy +
            radius *
                0.42 *
                sin(angle),
      );

      if (i == 0) {
        innerPath.moveTo(
          point.dx,
          point.dy,
        );
      } else {
        innerPath.lineTo(
          point.dx,
          point.dy,
        );
      }
    }

    innerPath.close();

    canvas.drawPath(
      innerPath,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    CustomPainter oldDelegate,
  ) {
    return false;
  }
}
