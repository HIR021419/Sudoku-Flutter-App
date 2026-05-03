import 'package:flutter/material.dart';
import 'package:sudoku/entities/difficulty_enum.dart';
import 'package:sudoku/entities/tile_state_enum.dart';
import 'package:sudoku/widgets/tile_widget.dart';

class SudokuPage extends StatefulWidget {
  const SudokuPage({
    super.key,
    required this.grid,
    required this.givens,
    required this.difficulty,
  });

  final List<int> grid;
  final List<int> givens;
  final DifficultyEnum difficulty;

  @override
  State<SudokuPage> createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sudoku ${widget.difficulty.name}"),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1, // carré parfait
          child: GridView.builder(
            itemCount: 81,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9,
            ),
            itemBuilder: (context, index) {
              final number = widget.grid[index];
              final isGiven = widget.givens.contains(index);

              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: index ~/ 9 % 3 == 0 ? 2 : 0.5,
                    ),
                    left: BorderSide(
                      width: index % 9 % 3 == 0 ? 2 : 0.5,
                    ),
                    right: BorderSide(
                      width: (index % 9 == 8) ? 2 : 0.5,
                    ),
                    bottom: BorderSide(
                      width: (index ~/ 9 == 8) ? 2 : 0.5,
                    ),
                  ),
                ),
                child: TileWidget(
                  number: number,
                  initialState: isGiven
                      ? TileStateEnum.given
                      : TileStateEnum.empty,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}