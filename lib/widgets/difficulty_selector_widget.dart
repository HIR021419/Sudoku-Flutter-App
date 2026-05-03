import 'package:flutter/material.dart';
import 'package:sudoku/entities/difficulty_enum.dart';
import 'package:sudoku/pages/sudoku_page.dart';
import 'package:sudoku/utils/sudoku_utils.dart';

class DifficultySelectorWidget extends StatefulWidget {
  const DifficultySelectorWidget({super.key});
  
  @override
  State<StatefulWidget> createState() => DifficultySelectorState();
}

class DifficultySelectorState extends State<DifficultySelectorWidget> {
  int _difficultyIndex = 0;

  bool _canIncreaseDifficulty() {
    return _difficultyIndex < DifficultyEnum.values.length - 1;
  }

  bool _canDecreaseDifficulty() {
    return _difficultyIndex > 0;
  }

  void _incrementDifficulty() {
    setState(() {
      if (_canIncreaseDifficulty()){
        _difficultyIndex++;
      }
    });
  }

  void _decrementDifficulty() {
    setState(() {
      if (_canDecreaseDifficulty()){
        _difficultyIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (_canDecreaseDifficulty())
              TextButton(
                onPressed: _decrementDifficulty,
                child: Text("<"),
              ),
            
            Text(DifficultyEnum.values[_difficultyIndex].name),

            if (_canIncreaseDifficulty())
              TextButton(
                onPressed: _incrementDifficulty,
                child: Text(">"),
              )
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      DifficultyEnum difficulty = DifficultyEnum.values[_difficultyIndex];
                      List<int> grid = SudokuUtils.generateGrid();
                      List<int> givens = SudokuUtils.generateGivens(grid, difficulty);
                      return SudokuPage(grid: grid, givens: givens, difficulty: difficulty,);
                    },
                  )
                );
              },
              child: Text("Jouer")
            )
          ],
        )
      ],
    );
  }

}