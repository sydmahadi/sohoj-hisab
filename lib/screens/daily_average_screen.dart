import 'package:flutter/material.dart';

import '../logic/calculator_logic.dart';
import '../models/calculator_model.dart';

class DailyAverageScreen extends StatefulWidget {
  const DailyAverageScreen({super.key});

  @override
  State<DailyAverageScreen> createState() =>
      _DailyAverageScreenState();
}

class _DailyAverageScreenState
    extends State<DailyAverageScreen> {
  AverageType selectedType = AverageType.count;

  final TextEditingController daysController =
      TextEditingController();

  final TextEditingController valueController =
      TextEditingController();

  String result = '';

  @override
  void dispose() {
    daysController.dispose();
    valueController.dispose();
    super.dispose();
  }

  void calculate() {
    final days = double.tryParse(
      daysController.text.trim(),
    );

    if (days == null || days <= 0) {
      setState(() {
        result = 'সঠিক দিন ইনপুট দিন';
      });
      return;
    }

    if (selectedType == AverageType.count) {
      final value = double.tryParse(
        valueController.text.trim(),
      );

      if (value == null || value < 0) {
        setState(() {
          result = 'সঠিক সংখ্যা ইনপুট দিন';
        });
        return;
      }

      setState(() {
        result = CalculatorLogic.dailyCount(
          days: days,
          value: value,
        );
      });
    } else {
      setState(() {
        result = CalculatorLogic.dailyTime(
          days: days,
          time: valueController.text,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCount = selectedType == AverageType.count;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'দৈনিক গড়',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EA),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.today_rounded,
                      size: 48,
                      color: Color(0xFF14532D),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'দৈনিক গড় হিসাব',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF183329),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SegmentedButton<AverageType>(
                segments: const [
                  ButtonSegment<AverageType>(
                    value: AverageType.count,
                    label: Text('সংখ্যা'),
                    icon: Icon(
                      Icons.numbers_rounded,
                    ),
                  ),
                  ButtonSegment<AverageType>(
                    value: AverageType.time,
                    label: Text('সময়'),
                    icon: Icon(
                      Icons.access_time_rounded,
                    ),
                  ),
                ],
                selected: {selectedType},
                onSelectionChanged: (value) {
                  setState(() {
                    selectedType = value.first;
                    result = '';
                    valueController.clear();
                  });
                },
              ),

              const SizedBox(height: 20),

              TextField(
                controller: daysController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'কত দিনের হিসাব?',
                  hintText: 'যেমন: 10',
                  prefixIcon: Icon(
                    Icons.calendar_today_rounded,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: valueController,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: isCount
                      ? 'মোট সংখ্যা'
                      : 'মোট সময়',
                  hintText: isCount
                      ? 'যেমন: 500'
                      : 'যেমন: 200.20',
                  prefixIcon: Icon(
                    isCount
                        ? Icons.numbers_rounded
                        : Icons.schedule_rounded,
                  ),
                  helperText: isCount
                      ? null
                      : 'ঘণ্টা.মিনিট লিখুন — 200.20 = ২০০ ঘণ্টা ২০ মিনিট',
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: calculate,
                icon: const Icon(
                  Icons.calculate_rounded,
                ),
                label: const Text(
                  'গড় হিসাব করুন',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              if (result.isNotEmpty) ...[
                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF14532D),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'দৈনিক গড়',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        result,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
