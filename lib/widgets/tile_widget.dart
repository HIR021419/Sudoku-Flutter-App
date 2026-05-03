import 'package:flutter/material.dart';
import 'package:sudoku/entities/tile_state_enum.dart';

class TileWidget extends StatefulWidget {
  const TileWidget({super.key, required this.number, required this.initialState});

  final int number;
  final TileStateEnum initialState;

  @override
  State<StatefulWidget> createState() => _TileState();

}

class _TileState extends State<TileWidget> {
  List<int> draft = [1,2,3,4,5,6,7,8,9];
  late TileStateEnum state;

  @override
  void initState() {
    super.initState();
    state = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: _getBackgroundColor(),
      ),
      child: Center(
        child: state == TileStateEnum.given || state == TileStateEnum.guessed
            ? Text(
                widget.number.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _getTextColor(),
                ),
              )
            : _buildDraft(),
      ),
    );
  }

  Widget _buildDraft() {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(2),
      children: List.generate(9, (index) {
        final value = index + 1;
        return Center(
          child: Text(
            draft.contains(value) ? value.toString() : '',
            style: const TextStyle(fontSize: 16),
          ),
        );
      }),
    );
  }

  Color _getBackgroundColor() {
    switch (state) {
      case TileStateEnum.selected:
        return Colors.blue.shade100;
      case TileStateEnum.error:
        return Colors.red.shade100;
      default:
        return Colors.white;
    }
  }

  Color _getTextColor() {
    switch (state) {
      case TileStateEnum.error :
        return Colors.red;
      case TileStateEnum.given :
        return Colors.black;
      case TileStateEnum.guessed :
        return Colors.blue;
      case TileStateEnum.selected :
        return Colors.black;
      default:
        return Colors.black;
    }
  }
}