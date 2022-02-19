import 'dart:math';

class PlanetModel {
  double diameter;
  double angularVelocity;
  double distance;
  int? rotationAroundSunInSeconds;

  double get perTime => pi * diameter / angularVelocity;

  PlanetModel({
    required this.diameter,
    required this.angularVelocity,
    required this.distance,
    this.rotationAroundSunInSeconds,
  });
}
