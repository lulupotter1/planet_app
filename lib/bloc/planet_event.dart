part of 'planet_bloc.dart';

@immutable
abstract class PlanetEvent {}

class AddPlanet extends PlanetEvent {
  List<PlanetModel> planetList;

  AddPlanet({
    required this.planetList,
  });
}
