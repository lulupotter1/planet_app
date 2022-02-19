import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/planet_bloc.dart';
import 'package:planet_app/model/planet_model.dart';
import 'package:planet_app/presentation/widget/custom_text_field.dart';

class AddPlanetScreens extends StatelessWidget {
  List<PlanetModel> planetList;
  AddPlanetScreens({
    Key? key,
    required this.planetList,
  }) : super(key: key);
  final TextEditingController _diameterController = TextEditingController();
  final TextEditingController _angularVelocityController =
      TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _rotationAroundSunInSecondsController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        bottomOpacity: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Form(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(24)),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CustomTextFiled(
                    controller: _diameterController,
                    hintText: "Радиус",
                  ),
                  const SizedBox(height: 24),
                  CustomTextFiled(
                      controller: _angularVelocityController,
                      hintText: "Скорость вращения (м/c)"),
                  const SizedBox(height: 24),
                  CustomTextFiled(
                      controller: _distanceController, hintText: "Дистанция"),
                  const SizedBox(height: 24),
                  CustomTextFiled(
                      controller: _rotationAroundSunInSecondsController,
                      hintText: "Время вращения вокруг солнца"),
                  TextButton(
                    onPressed: () {
                      if (_rotationAroundSunInSecondsController
                              .text.isNotEmpty &&
                          _angularVelocityController.text.isNotEmpty &&
                          _distanceController.text.isNotEmpty &&
                          _diameterController.text.isNotEmpty) {
                        planetList.add(PlanetModel(
                            rotationAroundSunInSeconds: int.parse(
                                _rotationAroundSunInSecondsController.text),
                            angularVelocity:
                                double.parse(_angularVelocityController.text),
                            distance: double.parse(_distanceController.text),
                            diameter: double.parse(
                              _diameterController.text,
                            )));

                        BlocProvider.of<PlanetBloc>(context)
                            .add(AddPlanet(planetList: planetList));
                        Navigator.pop(context);
                      } else {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text('Заполните все'),
                                actions: [
                                  TextButton(
                                    child: Text('Хорошо'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ]);
                          },
                        );
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(24)),
                        child: const Text(
                          'Добавить Планету',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
