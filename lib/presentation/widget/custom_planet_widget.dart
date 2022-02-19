import 'dart:math';

import 'package:flutter/material.dart';
import 'package:planet_app/model/planet_model.dart';

class CustomPlanetWidget extends StatefulWidget {
  final PlanetModel planetModel;
  final Offset centerOffset;
  const CustomPlanetWidget({
    Key? key,
    required this.planetModel,
    required this.centerOffset,
  }) : super(key: key);

  @override
  State<CustomPlanetWidget> createState() => _CustomPlanetWidgetState();
}

class _CustomPlanetWidgetState extends State<CustomPlanetWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotationAxisController;
  late AnimationController _rotationAroundSuncontroller2;
  late Animation _rotationAxisanimation;
  late Animation _rotationAroundSunanimation2;

  @override
  void initState() {
    _rotationAxisController = AnimationController(
        vsync: this,
        duration: Duration(seconds: widget.planetModel.perTime.round()));
    _rotationAroundSuncontroller2 = AnimationController(
        vsync: this,
        duration:
            Duration(seconds: widget.planetModel.rotationAroundSunInSeconds!));

    super.initState();

    _rotationAxisanimation =
        Tween(begin: 0.0, end: 360.0).animate(_rotationAxisController)
          ..addListener(() {
            if (_rotationAxisController.isCompleted) {
              _rotationAxisController.repeat();
            }
            setState(() {});
          });
    _rotationAroundSunanimation2 =
        Tween(begin: 0.0, end: 360).animate(_rotationAroundSuncontroller2)
          ..addListener(() {
            if (_rotationAroundSuncontroller2.isCompleted) {
              _rotationAroundSuncontroller2.repeat();
            }
            setState(() {});
          });

    _rotationAxisController.forward();
    _rotationAroundSuncontroller2.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _calculateX(
          radians: _rotationAroundSunanimation2.value * pi / 180,
          radius: widget.planetModel.distance,
          xPosition: widget.centerOffset.dx - widget.planetModel.diameter / 2),
      top: _calculateY(
          radians: _rotationAroundSunanimation2.value * pi / 180,
          radius: widget.planetModel.distance,
          yPosition: widget.centerOffset.dy - widget.planetModel.diameter / 2),
      child: Transform.rotate(
        angle: _rotationAxisanimation.value,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/planet_images/earth.png')),
            shape: BoxShape.circle,
          ),
          width: widget.planetModel.diameter,
          height: widget.planetModel.diameter,
        ),
      ),
    );
  }

  _calculateX({
    required double xPosition,
    required double radius,
    required double radians,
  }) {
    double xpos = xPosition + cos(radians) * radius;
    return xpos;
  }

  _calculateY({
    required double yPosition,
    required double radius,
    required double radians,
  }) {
    double ypos = yPosition + sin(radians) * radius;
    return ypos;
  }
}
