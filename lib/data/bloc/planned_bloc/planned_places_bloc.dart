import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/data/repository/favorite_repository_interface.dart';
import 'package:places/domain/place_planned.dart';

part 'planned_places_event.dart';
part 'planned_places_state.dart';
part 'planned_places_bloc.freezed.dart';

//Bloc Списка запланированных/посещённых мест
class PlannedPlacesBloc extends Bloc<PlannedPlacesEvent, PlannedPlacesState> {
  final IFavoriteRepository _favoritePlacesRepository;
  PlannedPlacesBloc({
    required final IFavoriteRepository favoritePlacesRepository,
  })  : _favoritePlacesRepository = favoritePlacesRepository,
        super(const _Loading()) {
    on<PlannedPlacesEvent>((event, emitter) {
      return event.map<Future<void>>(
        load: (event) => load(event, emitter),
      );
    });
  }

  Future<void> load(_load event, Emitter<PlannedPlacesState> emitter) async {
    final responseFavorite =
        await _favoritePlacesRepository.getFavoritePlacesSortedByDistance();
    emitter(PlannedPlacesState.loaded(favoritePlaces: responseFavorite));
  }
}
