import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dchs_motion_sensors/dchs_motion_sensors.dart';
//import 'package:motion_sensors/motion_sensors.dart';
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
  List<LiveData> values = [];

  Vector3 magnetometer = Vector3.zero();
  Vector3 _accelerometer = Vector3.zero();
  Vector3 _absoluteOrientation2 = Vector3.zero();
  int? groupvalue = 2;

  changeValues() {
    motionSensors.magnetometer.listen((MagnetometerEvent event) {
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
      //magnetic field
      magnetic_field_strength = (magnitude * 1e-6) / 4 * pi * 1e-7;

      //electric field
      electric_field_strength = magnetic_field_strength * 377;

      //power density/exposure limits
      power_density = (pow(magnetic_field_strength, 2)) / 377;

      values.add(LiveData(x, y, z, time++, magnetic_field_strength,
          electric_field_strength, power_density));

      if (values.length > 40) {
        values.removeAt(0);
      }

      // print(values[0]);
      // print('Magnetic Field Strength: $magnetic_field_strength');
      // print('Electric Field Strength: $electric_field_strength');
      // print('Power Density: $power_density');
      // print('Values length: ${values.length}');
      // print('At time: ${time}');

      notifyListeners();
    });
  }

  // stopUpdates() {
  //   motionSensors.magnetometerUpdateInterval = 0;
  //   notifyListeners();
  // }

  setUpdateInterval(int? groupValue, int interval) {
    motionSensors.magnetometerUpdateInterval = interval;
    groupvalue = groupValue;
    print(groupvalue);
    notifyListeners();
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
