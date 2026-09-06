import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ShohojHisabApp());
}

class ShohojHisabApp extends StatelessWidget {
  const ShohojHisabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'সহজ হিসাব',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
