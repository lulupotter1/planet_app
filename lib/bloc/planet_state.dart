part of 'planet_bloc.dart';

@immutable
abstract class PlanetState {}

class PlanetInitial extends PlanetState {}

class PlanetAdded extends PlanetState {
  List<PlanetModel> planetList;
  PlanetAdded({required this.planetList});
}
