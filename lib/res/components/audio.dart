import 'package:just_audio/just_audio.dart';

class Audio {
  static AudioPlayer audioPlayers = AudioPlayer();

  static Future<void> depositmusic() async {
    var duration = await audioPlayers.setAsset('assets/music/mp3.mp3');
    audioPlayers.play();
    audioPlayers.setLoopMode(LoopMode.off);
    return Future.delayed(duration ?? Duration.zero);

  }
  static AudioPlayer audioPlayer = AudioPlayer();

  static Future<void> RoomcodeSound() async {
    var duration = await audioPlayer.setAsset('assets/sound/roomcodesound.mp3');
    audioPlayer.play();
    audioPlayer.setLoopMode(LoopMode.off);
    return Future.delayed(duration ?? Duration.zero);
  }

  static Future<void> DragonWin() async {
    var duration = await audioPlayer.setAsset('assets/sound/dragon_soundtrack.mp3');
    audioPlayer.play();
    audioPlayer.setLoopMode(LoopMode.off);
    return Future.delayed(duration ?? Duration.zero);
  }

  static Future<void> TigerWin() async {
    var duration = await audioPlayer.setAsset('assets/sound/tiger_roar_soundtrack.mp3');
    audioPlayer.play();
    audioPlayer.setLoopMode(LoopMode.off);
    return Future.delayed(duration ?? Duration.zero);
  }
  static Future<void> DragonbgSound() async {
    var duration = await audioPlayer.setAsset('assets/sound/dragonbackground.mp3');
    audioPlayer.play();
    audioPlayer.setLoopMode(LoopMode.all);
    return Future.delayed(duration ?? Duration.zero);
  }

}
