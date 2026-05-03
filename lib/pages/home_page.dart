import 'package:flutter/material.dart';
import 'package:sudoku/widgets/difficulty_selector_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Sudoku'),
          )
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DifficultySelectorWidget()
          )
        ),
      );
  }
}
