import 'package:flutter/material.dart';
import 'pages/home_page.dart';

class SudokuApp extends StatelessWidget {
  const SudokuApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
