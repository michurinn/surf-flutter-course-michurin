// ignore_for_file: library_private_types_in_public_api

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/data/repository/visited_repository_interface.dart';
import 'package:places/domain/place_visited.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'visited_places_event.dart';
part 'visited_places_state.dart';
part 'visited_places_bloc.freezed.dart';

class VisitedPlacesBloc extends Bloc<VisitedPlacesEvent, VisitedPlacesState> {
  final IVisitedRepository _visitedPlacesRepository;
  VisitedPlacesBloc({required IVisitedRepository visitedPlacesRepository})
      : _visitedPlacesRepository = visitedPlacesRepository,
        super(const _Loading()) {
    on<VisitedPlacesEvent>(
      (event, emitter) {
        return event.map<Future<void>>(
          load: (event) => load(event, emitter),
          add: (event) => addPlace(event, emitter),
          remove: (event) => removePlace(event, emitter),
          swipe: (event) => swipePlaces(event, emitter),
        );
      },
      transformer: sequential(),
    );
  }

  Future<void> load(_Load event, Emitter<VisitedPlacesState> emitter) async {
    final responseVisited = await _visitedPlacesRepository.getVisitedPlaces();
    emitter(VisitedPlacesState.loaded(visitedPlaces: responseVisited));
  }

  Future<void> addPlace(_Add event, Emitter<VisitedPlacesState> emitter) async {
    await _visitedPlacesRepository.markVisited(event.visitedPlace);
    add(const VisitedPlacesEvent.load());
  }

  Future<void> removePlace(
      _Remove event, Emitter<VisitedPlacesState> emitter) async {
    await _visitedPlacesRepository.unmarkVisited(event.visitedPlace);
    add(const VisitedPlacesEvent.load());
  }

  Future<void> swipePlaces(
      _Swipe event, Emitter<VisitedPlacesState> emitter) async {
    await _visitedPlacesRepository.swipe(
        draggedPlaceId: event.draggedPlaceId, targetPlaceId: event.targetPlaceId);
    add(const VisitedPlacesEvent.load());
  }
}
