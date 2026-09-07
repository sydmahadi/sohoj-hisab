import 'package:flutter/material.dart';

class TimeSumScreen extends StatefulWidget {
  const TimeSumScreen({super.key});

  @override
  State<TimeSumScreen> createState() => _TimeSumScreenState();
}

class _TimeSumScreenState extends State<TimeSumScreen> {
  final List<TextEditingController> timeControllers = [
    TextEditingController(),
  ];

  int totalMinutes = 0;
  String? errorMessage;

  void addTimeField() {
    setState(() {
      timeControllers.add(TextEditingController());
      errorMessage = null;
    });
  }

  void removeTimeField(int index) {
    if (timeControllers.length == 1) {
      timeControllers[0].clear();
    } else {
      timeControllers[index].dispose();

      setState(() {
        timeControllers.removeAt(index);
        calculateTotal();
      });
    }
  }

  int? parseTime(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return 0;
    }

    final parts = value.split('.');

    if (parts.length != 2) {
      return null;
    }

    final hours = int.tryParse(parts[0]);
    final minutes = int.tryParse(parts[1]);

    if (hours == null || minutes == null) {
      return null;
    }

    if (hours < 0 || minutes < 0 || minutes > 59) {
      return null;
    }

    return (hours * 60) + minutes;
  }

  void calculateTotal() {
    int total = 0;

    for (final controller in timeControllers) {
      final value = parseTime(controller.text);

      if (value == null) {
        setState(() {
          errorMessage =
              'সময় অবশ্যই ঘণ্টা.মিনিট ফরম্যাটে লিখুন। যেমন: 2.30';
        });
        return;
      }

      total += value;
    }

    setState(() {
      totalMinutes = total;
      errorMessage = null;
    });
  }

  String formatTotalTime() {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours == 0 && minutes == 0) {
      return '০ ঘণ্টা ০ মিনিট';
    }

    if (hours == 0) {
      return '$minutes মিনিট';
    }

    if (minutes == 0) {
      return '$hours ঘণ্টা';
    }

    return '$hours ঘণ্টা $minutes মিনিট';
  }

  @override
  void dispose() {
    for (final controller in timeControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'সময় যোগ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EA),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 48,
                      color: Color(0xFF14532D),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'প্রতিদিনের সময় যোগ করুন',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF183329),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'যেমন: 1.30 = ১ ঘণ্টা ৩০ মিনিট',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7C72),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Time fields
              ...List.generate(
                timeControllers.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF14532D),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: TextField(
                            controller: timeControllers[index],
                            keyboardType: TextInputType.number,
                            onChanged: (_) {
                              calculateTotal();
                            },
                            decoration: const InputDecoration(
                              hintText: 'যেমন: 1.30',
                              labelText: 'সময়',
                              prefixIcon: Icon(
                                Icons.schedule_rounded,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 6),

                        IconButton(
                          onPressed: () {
                            removeTimeField(index);
                          },
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                          ),
                          color: Colors.red,
                          tooltip: 'মুছে ফেলুন',
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Add button
              OutlinedButton.icon(
                onPressed: addTimeField,
                icon: const Icon(
                  Icons.add_rounded,
                ),
                label: const Text(
                  'নতুন সময় যোগ করুন',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF14532D),
                  minimumSize: const Size(
                    double.infinity,
                    50,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Calculate button
              ElevatedButton.icon(
                onPressed: calculateTotal,
                icon: const Icon(
                  Icons.calculate_rounded,
                ),
                label: const Text(
                  'মোট সময় হিসাব করুন',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              if (errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ],

              const SizedBox(height: 25),

              // Result
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFF14532D),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    const Text(
                      'মোট সময়',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      formatTotalTime(),
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

              const SizedBox(height: 15),

              const Text(
                'উদাহরণ: 1.30 + 2.50 = ৪ ঘণ্টা ২০ মিনিট',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6B7C72),
                  fontSize: 13,
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
