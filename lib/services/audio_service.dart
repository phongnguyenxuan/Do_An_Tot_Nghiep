import 'package:audioplayers/audioplayers.dart';
export 'package:audioplayers/audioplayers.dart';

typedef AudioCacheFactory = AudioCache Function({required String prefix});

class AudioService {
  static AudioCacheFactory audioCacheFactory = AudioCache.new;

  static AudioCache audioCache = audioCacheFactory(
    prefix: 'assets/audio/',
  );

  static void updatePrefix(String prefix) {
    audioCache.prefix = prefix;
  }

  static AudioPlayer player = AudioPlayer()..audioCache = audioCache;

  static AudioPlayer countPlayer = AudioPlayer()..audioCache = audioCache;

  static AudioPlayer bgPlayer = AudioPlayer()..audioCache = audioCache;

  static void playExtraAudio(String file) {
    countPlayer = AudioPlayer()..audioCache = audioCache;
    countPlayer.setReleaseMode(ReleaseMode.release);
    countPlayer.play(
      AssetSource(file),
      volume: 1.0,
      mode: PlayerMode.lowLatency,
    );
  }

  static void playShortAudio(String file, {double volume = 1.0}) {
    player = AudioPlayer()..audioCache = audioCache;
    player.setReleaseMode(ReleaseMode.release);
    player.play(
      AssetSource(file),
      volume: 1.0,
      mode: PlayerMode.lowLatency,
    );
  }

  static void stopShortAudio() {
    player.stop();
  }

  static void stopBGAudio() {
    bgPlayer.stop();
  }

  static void stopExtraAudio() {
    countPlayer.stop();
  }

  static void playBGAudio(String file) async {
    bgPlayer = AudioPlayer()..audioCache = audioCache;
    await bgPlayer.setReleaseMode(ReleaseMode.loop);
    bgPlayer.play(
      AssetSource(file),
      volume: 0.4,
      mode: PlayerMode.mediaPlayer,
    );
  }
}
