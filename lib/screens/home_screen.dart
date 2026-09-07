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
                18,
                18,
                18,
                25,
              ),
              child: Column(
                children: [
                  // ==================================
                  // Premium Header
                  // ==================================
                  const _HeaderCard(),

                  const SizedBox(height: 28),

                  // ==================================
                  // Section Title
                  // ==================================
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
                    'আপনার প্রয়োজনীয় হিসাব নির্বাচন করুন',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ==================================
                  // 01 Calculator
                  // ==================================
                  _MenuCard(
                    number: '01',
                    icon: Icons.calculate_rounded,
                    title: 'সাধারণ ক্যালকুলেটর',
                    subtitle: 'যোগ, বিয়োগ, গুণ ও ভাগ',
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

                  const SizedBox(height: 12),

                  // ==================================
                  // 02 Date
                  // ==================================
                  _MenuCard(
                    number: '02',
                    icon: Icons.event_available_rounded,
                    title: 'তারিখ হিসাব',
                    subtitle: 'কত দিন আগে কোন তারিখ ছিল জানুন',
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

                  const SizedBox(height: 12),

                  // ==================================
                  // 03 Time Sum
                  // ==================================
                  _MenuCard(
                    number: '03',
                    icon: Icons.access_time_rounded,
                    title: 'সময় যোগ',
                    subtitle: '১.৩০, ২.৫০ এভাবে সময় যোগ করুন',
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

                  const SizedBox(height: 12),

                  // ==================================
                  // 04 Daily Average
                  // ==================================
                  _MenuCard(
                    number: '04',
                    icon: Icons.today_rounded,
                    title: 'দৈনিক গড়',
                    subtitle: 'সময় অথবা সংখ্যার দৈনিক গড়',
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

                  const SizedBox(height: 12),

                  // ==================================
                  // 05 Monthly Average
                  // ==================================
                  _MenuCard(
                    number: '05',
                    icon: Icons.calendar_month_rounded,
                    title: 'মাসিক গড়',
                    subtitle: 'কয়েক দিনের হিসাব থেকে মাসিক হিসাব',
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

                  const SizedBox(height: 12),

                  // ==================================
                  // 06 Browser
                  // ==================================
                  _MenuCard(
                    number: '06',
                    icon: Icons.language_rounded,
                    title: 'ব্রাউজার',
                    subtitle: 'অ্যাপের ভিতর থেকেই ওয়েব ব্রাউজ করুন',
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

                  const Text(
                    'Developed by Talpatar Sepai',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),
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
        22,
        25,
        22,
        24,
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
          width: 1,
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
          // Top Ornament
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              _diamond(),

              const SizedBox(width: 12),

              _line(),

              const SizedBox(width: 12),

              const Icon(
                Icons.star_rounded,
                color: AppTheme.gold,
                size: 18,
              ),

              const SizedBox(width: 12),

              _line(),

              const SizedBox(width: 12),

              _diamond(),
            ],
          ),

          const SizedBox(height: 20),

          // Bismillah
          const Text(
            'بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.goldLight,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 15),

          // App Name
          const Text(
            'সহজ হিসাব',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            'সহজে হিসাব করুন',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.goldLight,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'দৈনিক, মাসিক ও সাধারণ হিসাব এক জায়গায়',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 20),

          // Bottom Ornament
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              _dot(),
              const SizedBox(width: 8),
              _dot(),
              const SizedBox(width: 8),
              _dot(),
              const SizedBox(width: 8),
              _dot(),
              const SizedBox(width: 8),
              _dot(),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _line() {
    return Container(
      width: 65,
      height: 1,
      color: AppTheme.gold.withValues(
        alpha: 0.45,
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
            width: 1,
          ),
        ),
      ),
    );
  }

  static Widget _dot() {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.gold.withValues(
          alpha: 0.75,
        ),
      ),
    );
  }
}


// =====================================================
// PREMIUM MENU CARD
// =====================================================

class _MenuCard extends StatelessWidget {
  final String number;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuCard({
    required this.number,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(21),
        onTap: onTap,

        child: Container(
          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: AppTheme.card,

            borderRadius:
                BorderRadius.circular(21),

            border: Border.all(
              color: AppTheme.gold.withValues(
                alpha: 0.14,
              ),
              width: 1,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.30,
                ),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: Row(
            children: [
              // Number
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: AppTheme.gold.withValues(
                    alpha: 0.08,
                  ),
                  borderRadius:
                      BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.gold.withValues(
                      alpha: 0.20,
                    ),
                  ),
                ),

                child: Text(
                  number,
                  style: const TextStyle(
                    color: AppTheme.gold,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 11),

              // Icon
              Container(
                width: 53,
                height: 53,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF155D3C),
                      Color(0xFF0B3927),
                    ],
                  ),

                  borderRadius:
                      BorderRadius.circular(16),

                  border: Border.all(
                    color: AppTheme.gold.withValues(
                      alpha: 0.18,
                    ),
                  ),
                ),

                child: Icon(
                  icon,
                  color: AppTheme.goldLight,
                  size: 27,
                ),
              ),

              const SizedBox(width: 14),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 7),

              // Arrow
              Container(
                width: 30,
                height: 30,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.gold.withValues(
                    alpha: 0.07,
                  ),
                ),

                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: AppTheme.gold,
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

    const double spacing = 92;

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
          30,
          paint,
        );
      }
    }

    // Large center ornament
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
      150,
      largePaint,
    );
  }

  void _drawStar(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
  ) {
    const int points = 8;

    final path = Path();

    for (int i = 0; i < points * 2; i++) {
      final angle =
          (i * pi) / points;

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

    for (int i = 0; i < 4; i++) {
      final angle =
          (i * pi) / 2;

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
