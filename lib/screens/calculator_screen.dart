import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  String expression = '';

  double? firstNumber;
  String? operator;

  bool waitingForSecondNumber = false;
  bool justCalculated = false;

  List<String> history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  // =========================
  // HISTORY
  // =========================

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      history = prefs.getStringList('calculator_history') ?? [];
    });
  }

  Future<void> saveHistory(String item) async {
    final prefs = await SharedPreferences.getInstance();

    history.insert(0, item);

    // সর্বোচ্চ 50টি হিসাব রাখা হবে
    if (history.length > 50) {
      history = history.sublist(0, 50);
    }

    await prefs.setStringList(
      'calculator_history',
      history,
    );

    setState(() {});
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('calculator_history');

    setState(() {
      history.clear();
    });
  }

  // =========================
  // NUMBER FORMAT
  // =========================

  String formatNumber(double number) {
    return number
        .toStringAsFixed(8)
        .replaceFirst(RegExp(r'\.?0+$'), '');
  }

  // =========================
  // NUMBER INPUT
  // =========================

  void inputNumber(String number) {
    setState(() {
      if (justCalculated) {
        display = number;
        expression = '';
        firstNumber = null;
        operator = null;
        waitingForSecondNumber = false;
        justCalculated = false;
        return;
      }

      if (waitingForSecondNumber) {
        display = number;
        waitingForSecondNumber = false;
      } else {
        if (display == '0' || display == 'ভুল') {
          display = number;
        } else {
          display += number;
        }
      }

      updateExpression();
    });
  }

  // =========================
  // DECIMAL
  // =========================

  void inputDecimal() {
    setState(() {
      if (justCalculated) {
        display = '0.';
        expression = '';
        firstNumber = null;
        operator = null;
        waitingForSecondNumber = false;
        justCalculated = false;
        return;
      }

      if (waitingForSecondNumber) {
        display = '0.';
        waitingForSecondNumber = false;
        updateExpression();
        return;
      }

      if (!display.contains('.')) {
        display += '.';
        updateExpression();
      }
    });
  }

  // =========================
  // UPDATE EXPRESSION
  // =========================

  void updateExpression() {
    if (firstNumber != null && operator != null) {
      expression =
          '${formatNumber(firstNumber!)} $operator $display';
    }
  }

  // =========================
  // OPERATOR
  // =========================

  void selectOperator(String op) {
    final current = double.tryParse(display);

    if (current == null || display == 'ভুল') return;

    setState(() {
      if (justCalculated) {
        firstNumber = current;
        operator = op;

        expression =
            '${formatNumber(current)} $op';

        waitingForSecondNumber = true;
        justCalculated = false;
        return;
      }

      if (waitingForSecondNumber && firstNumber != null) {
        operator = op;

        expression =
            '${formatNumber(firstNumber!)} $op';

        return;
      }

      firstNumber = current;
      operator = op;
      waitingForSecondNumber = true;

      expression =
          '${formatNumber(current)} $op';
    });
  }

  // =========================
  // CALCULATE
  // =========================

  Future<void> calculateResult() async {
    if (firstNumber == null || operator == null) return;

    final second = double.tryParse(display);

    if (second == null) return;

    double result;

    final firstFormatted = formatNumber(firstNumber!);
    final secondFormatted = formatNumber(second);

    final currentExpression =
        '$firstFormatted $operator $secondFormatted';

    switch (operator) {
      case '+':
        result = firstNumber! + second;
        break;

      case '-':
        result = firstNumber! - second;
        break;

      case '×':
        result = firstNumber! * second;
        break;

      case '÷':
        if (second == 0) {
          setState(() {
            expression = currentExpression;
            display = 'ভুল';
            firstNumber = null;
            operator = null;
            waitingForSecondNumber = false;
            justCalculated = true;
          });
          return;
        }

        result = firstNumber! / second;
        break;

      default:
        return;
    }

    final resultFormatted = formatNumber(result);

    setState(() {
      expression = currentExpression;
      display = resultFormatted;

      firstNumber = null;
      operator = null;
      waitingForSecondNumber = false;
      justCalculated = true;
    });

    // History-তে সংরক্ষণ
    await saveHistory(
      '$currentExpression = $resultFormatted',
    );
  }

  // =========================
  // CLEAR
  // =========================

  void clear() {
    setState(() {
      display = '0';
      expression = '';
      firstNumber = null;
      operator = null;
      waitingForSecondNumber = false;
      justCalculated = false;
    });
  }

  // =========================
  // HISTORY PAGE
  // =========================

  void showHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Color(0xFFF6F8F4),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Top handle
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  12,
                  10,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.history,
                      color: Color(0xFF14532D),
                      size: 28,
                    ),

                    const SizedBox(width: 10),

                    const Expanded(
                      child: Text(
                        'হিসাবের ইতিহাস',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF183329),
                        ),
                      ),
                    ),

                    if (history.isNotEmpty)
                      IconButton(
                        tooltip: 'সব মুছে ফেলুন',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return AlertDialog(
                                title: const Text(
                                  'ইতিহাস মুছে ফেলবেন?',
                                ),
                                content: const Text(
                                  'সব হিসাবের ইতিহাস মুছে যাবে।',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                    },
                                    child: const Text('না'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(dialogContext);
                                      await clearHistory();
                                    },
                                    child: const Text(
                                      'মুছে ফেলুন',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ),

              const Divider(height: 1),

              Expanded(
                child: history.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.history,
                              size: 65,
                              color: Color(0xFFB5C5BB),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'এখনো কোনো হিসাব নেই',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color(0xFF6B7C72),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(18),
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFE8F0EA),
                                  borderRadius:
                                      BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.calculate_outlined,
                                  color: Color(0xFF14532D),
                                ),
                              ),
                              title: Text(
                                history[index],
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF183329),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================
  // CALCULATOR BUTTON
  // =========================

  Widget button(
    String text, {
    VoidCallback? onTap,
    bool operatorButton = false,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          height: 65,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: operatorButton
                  ? const Color(0xFF14532D)
                  : Colors.white,
              foregroundColor: operatorButton
                  ? Colors.white
                  : const Color(0xFF183329),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('সাধারণ ক্যালকুলেটর'),

        actions: [
          IconButton(
            tooltip: 'হিসাবের ইতিহাস',
            onPressed: showHistory,
            icon: const Icon(
              Icons.history,
              size: 27,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // =========================
            // DISPLAY
            // =========================

            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EA),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.end,
                  mainAxisAlignment:
                      MainAxisAlignment.end,
                  children: [
                    if (expression.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          expression,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 21,
                            color: Color(0xFF6B7C72),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    const SizedBox(height: 8),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        display,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF183329),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // =========================
            // BUTTONS
            // =========================

            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    children: [
                      button(
                        'C',
                        onTap: clear,
                      ),
                      button(
                        '÷',
                        operatorButton: true,
                        onTap: () =>
                            selectOperator('÷'),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      button(
                        '7',
                        onTap: () =>
                            inputNumber('7'),
                      ),
                      button(
                        '8',
                        onTap: () =>
                            inputNumber('8'),
                      ),
                      button(
                        '9',
                        onTap: () =>
                            inputNumber('9'),
                      ),
                      button(
                        '×',
                        operatorButton: true,
                        onTap: () =>
                            selectOperator('×'),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      button(
                        '4',
                        onTap: () =>
                            inputNumber('4'),
                      ),
                      button(
                        '5',
                        onTap: () =>
                            inputNumber('5'),
                      ),
                      button(
                        '6',
                        onTap: () =>
                            inputNumber('6'),
                      ),
                      button(
                        '-',
                        operatorButton: true,
                        onTap: () =>
                            selectOperator('-'),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      button(
                        '1',
                        onTap: () =>
                            inputNumber('1'),
                      ),
                      button(
                        '2',
                        onTap: () =>
                            inputNumber('2'),
                      ),
                      button(
                        '3',
                        onTap: () =>
                            inputNumber('3'),
                      ),
                      button(
                        '+',
                        operatorButton: true,
                        onTap: () =>
                            selectOperator('+'),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      button(
                        '0',
                        onTap: () =>
                            inputNumber('0'),
                      ),
                      button(
                        '.',
                        onTap: inputDecimal,
                      ),
                      button(
                        '=',
                        operatorButton: true,
                        onTap: calculateResult,
                      ),
                    ],
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
