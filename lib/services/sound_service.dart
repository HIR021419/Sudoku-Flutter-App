import 'package:audioplayers/audioplayers.dart';

/// Lecture des effets sonores du jeu. Best-effort : un échec audio ne doit
/// jamais interrompre le jeu (toutes les erreurs sont avalées).
///
/// L'activation/désactivation (`Settings.soundEnabled`) est gérée par
/// l'appelant (le `GameNotifier`) : ce service ne fait que jouer.
///
/// Deux players distincts pour que le son de victoire (plus long) ne soit pas
/// coupé par un effet court (tap/erreur) joué juste avant.
class SoundService {
  SoundService() {
    _sfx.setReleaseMode(ReleaseMode.stop);
    _music.setReleaseMode(ReleaseMode.stop);
  }

  final AudioPlayer _sfx = AudioPlayer();
  final AudioPlayer _music = AudioPlayer();

  Future<void> _safePlay(AudioPlayer player, String asset) async {
    try {
      await player.stop();
      await player.play(AssetSource(asset));
    } catch (_) {
      // Audio non critique : on ignore toute erreur (asset manquant, backend
      // audio indisponible, etc.).
    }
  }

  Future<void> tap() => _safePlay(_sfx, 'sounds/tap.wav');
  Future<void> error() => _safePlay(_sfx, 'sounds/error.wav');
  Future<void> win() => _safePlay(_music, 'sounds/win.wav');

  Future<void> dispose() async {
    await _sfx.dispose();
    await _music.dispose();
  }
}
