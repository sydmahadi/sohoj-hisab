import 'package:flutter/material.dart';

class DateCalculatorScreen extends StatefulWidget {
  const DateCalculatorScreen({super.key});

  @override
  State<DateCalculatorScreen> createState() =>
      _DateCalculatorScreenState();
}

class _DateCalculatorScreenState
    extends State<DateCalculatorScreen> {
  DateTime? selectedDate;
  int days = 0;
  DateTime? resultDate;

  Future<void> selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      helpText: 'তারিখ নির্বাচন করুন',
      cancelText: 'বাতিল',
      confirmText: 'নির্বাচন',
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        resultDate = null;
      });
    }
  }

  void calculateDate() {
    if (selectedDate == null || days <= 0) return;

    setState(() {
      resultDate = selectedDate!.subtract(
        Duration(days: days),
      );
    });
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('তারিখ হিসাব'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),

            // তারিখ নির্বাচন
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0EA),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 50,
                    color: Color(0xFF14532D),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'যে তারিখ থেকে হিসাব করবেন',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    selectedDate == null
                        ? 'কোনো তারিখ নির্বাচন করা হয়নি'
                        : formatDate(selectedDate!),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF14532D),
                    ),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton.icon(
                    onPressed: selectDate,
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('তারিখ নির্বাচন করুন'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // কত দিন আগে
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'কত দিন আগে?',
                hintText: 'যেমন: 17',
                prefixIcon: Icon(Icons.history),
              ),
              onChanged: (value) {
                days = int.tryParse(value) ?? 0;
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: calculateDate,
              icon: const Icon(Icons.calculate),
              label: const Text(
                'হিসাব করুন',
                style: TextStyle(fontSize: 17),
              ),
            ),

            const SizedBox(height: 25),

            // ফলাফল
            if (resultDate != null)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF14532D),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    const Text(
                      'ফলাফল',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      formatDate(resultDate!),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '$days দিন আগে',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
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
