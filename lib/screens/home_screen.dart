import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'date_calculator_screen.dart';
import 'calculator_screen.dart';
import 'daily_average_screen.dart';
import 'monthly_average_screen.dart';
import 'browser_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'সহজ হিসাব',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // =========================
              // Header
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(24),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text(
                      'بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),

                    SizedBox(height: 14),

                    Text(
                      'সহজে হিসাব করুন',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      'দৈনিক, মাসিক ও সাধারণ হিসাব এক জায়গায়',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // Section Title
              // =========================
              const Text(
                'হিসাবের ধরন',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),

              const SizedBox(height: 14),

              // =========================
              // ১. তারিখ হিসাব
              // =========================
              _MenuCard(
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

              // =========================
              // ২. সাধারণ ক্যালকুলেটর
              // =========================
              _MenuCard(
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

              // =========================
              // ৩. দৈনিক গড়
              // =========================
              _MenuCard(
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

              // =========================
              // ৪. মাসিক গড়
              // =========================
              _MenuCard(
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

              // =========================
              // ৫. ব্রাউজার
              // =========================
              _MenuCard(
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

              const SizedBox(height: 28),

              // =========================
              // Developer
              // =========================
              const Center(
                child: Text(
                  'Developed by Talpatar Sepai',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// Menu Card
// =====================================================

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),

      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Row(
            children: [

              // Icon
              Container(
                width: 52,
                height: 52,

                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Icon(
                  icon,
                  color: AppTheme.primary,
                  size: 27,
                ),
              ),

              const SizedBox(width: 16),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Arrow
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: AppTheme.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
