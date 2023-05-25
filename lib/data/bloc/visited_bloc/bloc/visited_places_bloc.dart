import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/data/repository/visited_repository_interface.dart';
import 'package:places/domain/place_visited.dart';

part 'visited_places_event.dart';
part 'visited_places_state.dart';
part 'visited_places_bloc.freezed.dart';

class VisitedPlacesBloc extends Bloc<VisitedPlacesEvent, VisitedPlacesState> {
  final IVisitedRepository _visitedPlacesRepository;
  VisitedPlacesBloc({required IVisitedRepository visitedPlacesRepository}) :_visitedPlacesRepository = visitedPlacesRepository, super(_Loading()) {
    on<VisitedPlacesEvent>((event, emitter) {
      return event.map<Future<void>>(
        load: (event) => load(event,emitter),
      );
    });
  }

Future<void> load(_Load event, Emitter<VisitedPlacesState> emitter) async {
  final responseVisited = await _visitedPlacesRepository.getVisitedPlaces();
  emitter(VisitedPlacesState.loaded( visitedPlaces: responseVisited));
}
}
