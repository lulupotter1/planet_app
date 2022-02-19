import 'package:flutter/material.dart';
import 'package:planet_app/model/planet_model.dart';

class CustomSunWidget extends StatefulWidget {
  final PlanetModel planetModel;

  final Offset centerOffset;
  const CustomSunWidget({
    Key? key,
    required this.centerOffset,
    required this.planetModel,
  }) : super(key: key);

  @override
  State<CustomSunWidget> createState() => _CustomSunWidgetState();
}

class _CustomSunWidgetState extends State<CustomSunWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotationAxisController;
  late Animation _rotationAxisanimation;

  @override
  void initState() {
    _rotationAxisController =
        AnimationController(vsync: this, duration: const Duration(seconds: 40));

    super.initState();

    _rotationAxisanimation =
        Tween(begin: 0.0, end: 360.0).animate(_rotationAxisController)
          ..addListener(() {
            if (_rotationAxisController.isCompleted) {
              _rotationAxisController.repeat();
            }
            setState(() {});
          });

    _rotationAxisController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.centerOffset.dx - widget.planetModel.diameter / 2,
      top: widget.centerOffset.dy - widget.planetModel.diameter / 2,
      child: Transform.rotate(
        angle: _rotationAxisanimation.value,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/planet_images/sun.png')),
            shape: BoxShape.circle,
          ),
          width: widget.planetModel.diameter,
          height: widget.planetModel.diameter,
        ),
      ),
    );
  }
}
