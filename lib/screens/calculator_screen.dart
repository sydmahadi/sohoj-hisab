import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() =>
      _CalculatorScreenState();
}

class _CalculatorScreenState
    extends State<CalculatorScreen> {

  String display = '0';
  double? firstNumber;
  String? operator;
  bool waitingForSecondNumber = false;

  void inputNumber(String number) {
    setState(() {
      if (display == '0' || waitingForSecondNumber) {
        display = number;
        waitingForSecondNumber = false;
      } else {
        display += number;
      }
    });
  }

  void inputDecimal() {
    setState(() {
      if (!display.contains('.')) {
        display += '.';
      }
    });
  }

  void selectOperator(String op) {
    final double current =
        double.tryParse(display) ?? 0;

    setState(() {
      firstNumber = current;
      operator = op;
      waitingForSecondNumber = true;
    });
  }

  void calculateResult() {
    if (firstNumber == null || operator == null) {
      return;
    }

    final double second =
        double.tryParse(display) ?? 0;

    double result;

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
            display = 'ভুল';
          });
          return;
        }

        result = firstNumber! / second;
        break;

      default:
        return;
    }

    setState(() {
      display = result
          .toStringAsFixed(8)
          .replaceFirst(RegExp(r'\.?0+$'), '');

      firstNumber = null;
      operator = null;
      waitingForSecondNumber = true;
    });
  }

  void clear() {
    setState(() {
      display = '0';
      firstNumber = null;
      operator = null;
      waitingForSecondNumber = false;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('সাধারণ ক্যালকুলেটর'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [

            Expanded(
              flex: 2,

              child: Container(
                width: double.infinity,
                alignment: Alignment.bottomRight,

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EA),
                  borderRadius: BorderRadius.circular(24),
                ),

                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Text(
                    display,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              flex: 5,

              child: Column(
                children: [

                  Row(
                    children: [
                      button('C', onTap: clear),
                      button('÷',
                          operatorButton: true,
                          onTap: () =>
                              selectOperator('÷')),
                    ],
                  ),

                  Row(
                    children: [
                      button('7',
                          onTap: () => inputNumber('7')),
                      button('8',
                          onTap: () => inputNumber('8')),
                      button('9',
                          onTap: () => inputNumber('9')),
                      button('×',
                          operatorButton: true,
                          onTap: () =>
                              selectOperator('×')),
                    ],
                  ),

                  Row(
                    children: [
                      button('4',
                          onTap: () => inputNumber('4')),
                      button('5',
                          onTap: () => inputNumber('5')),
                      button('6',
                          onTap: () => inputNumber('6')),
                      button('-',
                          operatorButton: true,
                          onTap: () =>
                              selectOperator('-')),
                    ],
                  ),

                  Row(
                    children: [
                      button('1',
                          onTap: () => inputNumber('1')),
                      button('2',
                          onTap: () => inputNumber('2')),
                      button('3',
                          onTap: () => inputNumber('3')),
                      button('+',
                          operatorButton: true,
                          onTap: () =>
                              selectOperator('+')),
                    ],
                  ),

                  Row(
                    children: [
                      button('0',
                          onTap: () => inputNumber('0')),
                      button('.',
                          onTap: inputDecimal),
                      button('=',
                          operatorButton: true,
                          onTap: calculateResult),
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
