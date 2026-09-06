import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(24),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),

                    SizedBox(height: 14),

                    Text(
                      'সহজে হিসাব করুন',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      'দৈনিক, মাসিক ও সাধারণ হিসাব এক জায়গায়',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'হিসাবের ধরন',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),

              const SizedBox(height: 14),

              // সাধারণ ক্যালকুলেটর
              _MenuCard(
                icon: Icons.calculate_rounded,
                title: 'সাধারণ ক্যালকুলেটর',
                subtitle: 'যোগ, বিয়োগ, গুণ ও ভাগ',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CalculatorScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // দৈনিক
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

              // মাসিক
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

              // Browser
              _MenuCard(
                icon: Icons.language_rounded,
                title: 'ব্রাউজার',
                subtitle: 'অ্যাপের ভিতর থেকেই ওয়েব ব্রাউজ করুন',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BrowserScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
