import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:dchs_motion_sensors/dchs_motion_sensors.dart';
import 'package:vector_math/vector_math_64.dart';

class MagnitudeProvider extends ChangeNotifier {
  double x = 0;
  double y = 0;
  double z = 0;
  double magnitude = 0;
  int time = 0;
  double electric_field_strength = 0;
  double magnetic_field_strength = 0;
  double power_density = 0;
  int currentIndex = 0;
  int totalPoints = 0;
  final int maxDataPoints = 40;
  List<LiveData> values = List.filled(40, LiveData(0,0,0,0,0,0,0));
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isAlertPlaying = false;

  Vector3 magnetometer = Vector3.zero();
  Vector3 _accelerometer = Vector3.zero();
  Vector3 _absoluteOrientation2 = Vector3.zero();
  int? groupvalue = 2;

  StreamSubscription<MagnetometerEvent>? _magnetometerSubscription;
  bool isReading = false;

  changeValues() {
    if (!isReading) {
      isReading = true;
      _magnetometerSubscription = motionSensors.magnetometer.listen((MagnetometerEvent event) {
        magnetometer.setValues(event.x, event.y, event.z);
        var matrix =
            motionSensors.getRotationMatrix(_accelerometer, magnetometer);
        _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
        x = magnetometer.x;
        y = magnetometer.y;
        z = magnetometer.z;
        //magnitude in microTesla
        magnitude = sqrt((pow(magnetometer.x, 2)) +
            (pow(magnetometer.y, 2)) +
            (pow(magnetometer.z, 2)));

        //Alarm
        if (magnitude > 200 && !_isAlertPlaying) {
          _playAlert();
        } else if (magnitude <= 200 && _isAlertPlaying) {
          _stopAlert();
        }

        //magnetic field
        magnetic_field_strength = (magnitude * 1e-6) / 4 * pi * 1e-7;

        //electric field
        electric_field_strength = magnetic_field_strength * 377;

        //power density/exposure limits
        power_density = (pow(magnetic_field_strength, 2)) / 377;

        values[currentIndex] = LiveData(x, y, z, totalPoints, magnetic_field_strength,
            electric_field_strength, power_density);

        currentIndex = (currentIndex + 1)% maxDataPoints;
        totalPoints++;

       

        notifyListeners();
      });
      notifyListeners();
    }
  }

  stopUpdates() {
    if (isReading) {
      _magnetometerSubscription?.cancel();
      isReading = false;
      _stopAlert();
      notifyListeners();
    }
  }

  List<LiveData> getOrderedValues(){
    if(totalPoints < maxDataPoints){
      return values.sublist(0,totalPoints);
    }
    return[...values.sublist(currentIndex),...values.sublist(0, currentIndex)];
  }

  setUpdateInterval(int? groupValue, int interval) {
    motionSensors.magnetometerUpdateInterval = interval;
    groupvalue = groupValue;
    print(groupvalue);
    notifyListeners();
  }

  Future<void> _playAlert() async {
    if (!_isAlertPlaying) {
      _isAlertPlaying = true;
      await _audioPlayer.play(AssetSource('audio/alert-alarm.wav'), mode: PlayerMode.mediaPlayer);
    }
  }

  Future<void> _stopAlert() async {
    if (_isAlertPlaying) {
      _isAlertPlaying = false;
      await _audioPlayer.stop();
    }
  }

  @override
  void dispose() {
    _magnetometerSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}

class LiveData {
  LiveData(this.x, this.y, this.z, this.time, this.magnetic_field_strength,
      this.electric_field_strength, this.power_density);
  final double x;
  final double y;
  final double z;
  final int time;
  final double electric_field_strength;
  final double magnetic_field_strength;
  final double power_density;
}