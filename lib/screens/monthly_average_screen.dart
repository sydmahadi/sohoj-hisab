import 'package:flutter/material.dart';

import '../logic/calculator_logic.dart';
import '../models/calculator_model.dart';
import '../theme/app_theme.dart';

class MonthlyAverageScreen extends StatefulWidget {
  const MonthlyAverageScreen({super.key});

  @override
  State<MonthlyAverageScreen> createState() =>
      _MonthlyAverageScreenState();
}

class _MonthlyAverageScreenState
    extends State<MonthlyAverageScreen> {

  final daysController = TextEditingController();
  final valueController = TextEditingController();

  AverageType type = AverageType.count;
  TimeUnit timeUnit = TimeUnit.minutes;

  String result = '';

  @override
  void dispose() {
    daysController.dispose();
    valueController.dispose();
    super.dispose();
  }

  void calculate() {
    final double? days =
        double.tryParse(daysController.text);

    final double? value =
        double.tryParse(valueController.text);

    if (days == null || value == null) {
      setState(() {
        result = 'সব তথ্য সঠিকভাবে পূরণ করুন';
      });
      return;
    }

    if (type == AverageType.count) {
      final answer = CalculatorLogic.monthlyCount(
        days: days,
        value: value,
      );

      setState(() {
        result = '$answer বার';
      });
    } else {
      final double minutes =
          timeUnit == TimeUnit.hours
              ? value * 60
              : value;

      final answer = CalculatorLogic.monthlyTime(
        days: days,
        totalMinutes: minutes,
      );

      setState(() {
        result = answer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('মাসিক গড়'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: AppTheme.gold.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
              ),

              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppTheme.gold,
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      'আপনার দেওয়া দিনের হিসাব থেকে '
                      '৩০.৪৩ দিনের আনুমানিক মাসিক হিসাব করা হবে।',
                      style: TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SegmentedButton<AverageType>(
              segments: const [
                ButtonSegment(
                  value: AverageType.count,
                  label: Text('সংখ্যা'),
                  icon: Icon(Icons.numbers),
                ),
                ButtonSegment(
                  value: AverageType.time,
                  label: Text('সময়'),
                  icon: Icon(Icons.schedule),
                ),
              ],

              selected: {type},

              onSelectionChanged: (value) {
                setState(() {
                  type = value.first;
                  result = '';
                });
              },
            ),

            const SizedBox(height: 25),

            TextField(
              controller: daysController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'কয় দিনের হিসাব?',
                hintText: 'যেমন: ১৫',
                prefixIcon: Icon(
                  Icons.calendar_today,
                ),
              ),
            ),

            const SizedBox(height: 15),

            if (type == AverageType.time)
              DropdownButtonFormField<TimeUnit>(
                initialValue: timeUnit,

                decoration: const InputDecoration(
                  labelText: 'সময় একক',
                  prefixIcon: Icon(Icons.timer),
                ),

                items: const [
                  DropdownMenuItem(
                    value: TimeUnit.minutes,
                    child: Text('মিনিট'),
                  ),
                  DropdownMenuItem(
                    value: TimeUnit.hours,
                    child: Text('ঘণ্টা'),
                  ),
                ],

                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      timeUnit = value;
                    });
                  }
                },
              ),

            if (type == AverageType.time)
              const SizedBox(height: 15),

            TextField(
              controller: valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: type == AverageType.count
                    ? 'মোট সংখ্যা'
                    : 'মোট সময়',

                hintText: type == AverageType.count
                    ? 'যেমন: ৪৫'
                    : 'যেমন: ৩০',

                prefixIcon: Icon(
                  type == AverageType.count
                      ? Icons.numbers
                      : Icons.timer,
                ),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: calculate,
              icon: const Icon(Icons.calculate),
              label: const Text(
                'মাসিক হিসাব করুন',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            if (result.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(22),
                ),

                child: Column(
                  children: [
                    const Text(
                      'আনুমানিক মাসিক হিসাব',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      result,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
