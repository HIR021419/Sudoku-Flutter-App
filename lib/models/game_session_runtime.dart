/// État runtime non-sérialisable d'une partie : le chronomètre.
///
/// Détenu par `GameNotifier`. Sort de `GameSession` qui est désormais
/// immuable et pure — l'entité ne porte que la valeur de `elapsedAtRestore`
/// (Duration accumulée), tandis que ce runtime gère le Stopwatch live.
///
/// Le total elapsed visible est `runtime.totalElapsed = elapsedAtRestore + stopwatch.elapsed`.
class GameSessionRuntime {
  final Stopwatch _stopwatch = Stopwatch();
  Duration _elapsedAtRestore = Duration.zero;

  /// Durée totale (restore + live).
  Duration get totalElapsed => _stopwatch.elapsed + _elapsedAtRestore;

  bool get isRunning => _stopwatch.isRunning;

  /// Démarre une nouvelle partie : remet le chrono à zéro et démarre.
  void startFresh() {
    _stopwatch
      ..stop()
      ..reset();
    _elapsedAtRestore = Duration.zero;
    _stopwatch.start();
  }

  /// Restaure depuis une partie sauvegardée. [elapsedAtRestore] est la durée
  /// cumulée à reprendre. [running] indique si le chrono doit redémarrer
  /// immédiatement (false si la partie est déjà gagnée par exemple).
  void restoreFrom(Duration elapsedAtRestore, {required bool running}) {
    _stopwatch
      ..stop()
      ..reset();
    _elapsedAtRestore = elapsedAtRestore;
    if (running) _stopwatch.start();
  }

  void start() {
    if (!_stopwatch.isRunning) _stopwatch.start();
  }

  void stop() {
    if (_stopwatch.isRunning) _stopwatch.stop();
  }
}
