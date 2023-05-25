import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/data/repository/planned_repository_interface.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/place_planned.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'planned_places_event.dart';
part 'planned_places_state.dart';
part 'planned_places_bloc.freezed.dart';

//Bloc Списка запланированных/посещённых мест
class PlannedPlacesBloc extends Bloc<PlannedPlacesEvent, PlannedPlacesState> {
  final IPlannedRepository _favoritePlacesRepository;
  PlannedPlacesBloc({
    required final IPlannedRepository favoritePlacesRepository,
  })  : _favoritePlacesRepository = favoritePlacesRepository,
        super(const _Loading()) {
    on<PlannedPlacesEvent>(
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

  Future<void> load(_load event, Emitter<PlannedPlacesState> emitter) async {
    final responseFavorite =
        await _favoritePlacesRepository.getFavoritePlacesSortedByDistance();
    emitter(PlannedPlacesState.loaded(favoritePlaces: responseFavorite));
  }

  Future<void> addPlace(_Add event, Emitter<PlannedPlacesState> emitter) async {
    await _favoritePlacesRepository.markFavorite(event.placePlanned);
    add(const PlannedPlacesEvent.load());
  }

  Future<void> removePlace(
      _Remove event, Emitter<PlannedPlacesState> emitter) async {
    await _favoritePlacesRepository.unmarkFavorite(event.placePlanned);
    add(const PlannedPlacesEvent.load());
  }

  Future<void> swipePlaces(
      _Swipe event, Emitter<PlannedPlacesState> emitter) async {
    await _favoritePlacesRepository.swipe(
        draggedPlaceId: event.draggedPlaceId,
        targetPlaceId: event.targetPlaceId);
    add(const PlannedPlacesEvent.load());
  }
}
