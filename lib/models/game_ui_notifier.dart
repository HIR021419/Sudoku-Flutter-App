import 'package:flutter/foundation.dart';

/// État UI éphémère d'une partie : cellule sélectionnée + modes actifs.
/// `selectedIndex` est volontairement non persisté (vraiment éphémère).
/// `notesMode`, `fillMode`, `activeNumber` sont persistés pour préserver le contexte de jeu à la reprise.
class GameUiNotifier extends ChangeNotifier {
  int? _selectedIndex;
  bool _notesMode = false;
  bool _fillMode = false;
  int? _activeNumber;

  int? get selectedIndex => _selectedIndex;
  bool get notesMode => _notesMode;
  bool get fillMode => _fillMode;
  int? get activeNumber => _activeNumber;

  void select(int? index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleNotesMode() {
    _notesMode = !_notesMode;
    notifyListeners();
  }

  void toggleFillMode() {
    _fillMode = !_fillMode;
    if (_fillMode) {
      _selectedIndex = null;
    }
    _activeNumber = null;
    notifyListeners();
  }

  void setActiveNumber(int? number) {
    if (_activeNumber == number) return;
    _activeNumber = number;
    notifyListeners();
  }

  void reset() {
    _selectedIndex = null;
    _notesMode = false;
    _fillMode = false;
    _activeNumber = null;
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {
        'notesMode': _notesMode,
        'fillMode': _fillMode,
        'activeNumber': _activeNumber,
      };

  /// Restore les modes UI persistés. Ne touche pas à `selectedIndex` (éphémère).
  /// Tolérant : valeurs absentes ou mauvais types → défaut.
  void restoreFromJson(Map<String, dynamic> json) {
    _selectedIndex = null;
    _notesMode = json['notesMode'] is bool ? json['notesMode'] as bool : false;
    _fillMode = json['fillMode'] is bool ? json['fillMode'] as bool : false;
    final num? n = json['activeNumber'] as num?;
    _activeNumber = (n != null && n >= 1 && n <= 9) ? n.toInt() : null;
    notifyListeners();
  }
}
