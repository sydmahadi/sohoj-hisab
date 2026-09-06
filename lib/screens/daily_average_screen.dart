import 'package:flutter/material.dart';

import '../logic/calculator_logic.dart';
import '../models/calculator_model.dart';
import '../theme/app_theme.dart';

class DailyAverageScreen extends StatefulWidget {
  const DailyAverageScreen({super.key});

  @override
  State<DailyAverageScreen> createState() =>
      _DailyAverageScreenState();
}

class _DailyAverageScreenState
    extends State<DailyAverageScreen> {

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
      final answer = CalculatorLogic.dailyCount(
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

      final answer =
          CalculatorLogic.dailyTimeInMinutes(
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
        title: const Text('দৈনিক গড়'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

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

            _InputField(
              controller: daysController,
              label: 'কয় দিনের হিসাব?',
              hint: 'যেমন: ১৫',
              icon: Icons.calendar_today,
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

            _InputField(
              controller: valueController,
              label: type == AverageType.count
                  ? 'মোট সংখ্যা'
                  : 'মোট সময়',

              hint: type == AverageType.count
                  ? 'যেমন: ৪৫'
                  : 'যেমন: ৩০',

              icon: type == AverageType.count
                  ? Icons.numbers
                  : Icons.timer,
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: calculate,
              icon: const Icon(Icons.calculate),
              label: const Text(
                'হিসাব করুন',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            if (result.isNotEmpty)
              _ResultCard(
                title: 'দৈনিক গড়',
                value: result,
              ),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String title;
  final String value;

  const _ResultCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
