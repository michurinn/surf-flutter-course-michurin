part of 'planned_places_bloc.dart';

@freezed
class PlannedPlacesState with _$PlannedPlacesState {
  const PlannedPlacesState._();
  int get placesHash => when(
        loading: () => 0,
        loaded: (favoritePlaces) => favoritePlaces.hashCode,
      );
  //Данные загружаются
  const factory PlannedPlacesState.loading() = _Loading;
  //Данные загружены
  const factory PlannedPlacesState.loaded(
      {required List<Place> favoritePlaces}) = _Loaded;
}
