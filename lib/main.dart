import 'package:flutter/material.dart';
import 'package:pollutrack25/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(
            background: const Color(0xFFFFFFFF),
            primary: const Color(0xFF2b5a4d),
            secondary: const Color(0xFFedf1f1),
            seedColor: const Color(0xFF2b5a4d)),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}
