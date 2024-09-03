import 'package:audioplayers/audioplayers.dart';



class AlarmService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAlarm(double magnitude) async {
   
      await _audioPlayer.play(DeviceFileSource("/assets/audio/alert-alarm.wav"));
    
   }

   Future<void> stopAlarm() async {
    await _audioPlayer.stop();
  }
}