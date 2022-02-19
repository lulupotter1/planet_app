import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/model/planet_model.dart';
import 'package:planet_app/presentation/add_planet_screen.dart';
import 'package:planet_app/presentation/planet_screen.dart';

import 'bloc/planet_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanetBloc(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            'Planet_Screen': (context) => PlanetScreen(),
            'Add_Planet_Screens': (context) => AddPlanetScreens(
                planetList: ModalRoute.of(context)!.settings.arguments
                    as List<PlanetModel>),
          },
          initialRoute: "Planet_Screen"),
    );
  }
}
