import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/planet_bloc.dart';
import 'package:planet_app/model/planet_model.dart';
import 'package:planet_app/presentation/widget/custom_planet_widget.dart';
import 'package:planet_app/presentation/widget/custom_sun_widget.dart';

class PlanetScreen extends StatelessWidget {
  List<PlanetModel> planetList = [];

  @override
  Widget build(BuildContext context) {
    final Size windowSize = MediaQueryData.fromWindow(window).size;
    Offset centerOffset = Offset(windowSize.width / 2, windowSize.height / 2);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'Add_Planet_Screens',
              arguments: planetList);
        },
      ),
      body: BlocBuilder<PlanetBloc, PlanetState>(
        builder: (context, state) {
          if (state is PlanetAdded) {
            planetList = state.planetList;
          }
          return Stack(
            children: <Widget>[
              CustomSunWidget(
                  centerOffset: centerOffset,
                  planetModel: PlanetModel(
                      angularVelocity: 20, distance: 0, diameter: 200)),
              if (planetList.isNotEmpty)
                for (int i = 0; i < planetList.length; i++)
                  CustomPlanetWidget(
                      planetModel: planetList[i], centerOffset: centerOffset)
            ],
          );
        },
      ),
    );
  }
}
