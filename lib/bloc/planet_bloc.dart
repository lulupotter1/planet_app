import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:planet_app/model/planet_model.dart';

part 'planet_event.dart';
part 'planet_state.dart';

class PlanetBloc extends Bloc<PlanetEvent, PlanetState> {
  PlanetBloc() : super(PlanetInitial());

  @override
  PlanetState get initialState => PlanetInitial();

  @override
  Stream<PlanetState> mapEventToState(PlanetEvent event) async* {
    if (event is AddPlanet) {
      yield PlanetAdded(planetList: event.planetList);
    }
  }
}
