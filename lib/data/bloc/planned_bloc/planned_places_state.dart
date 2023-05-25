part of 'planned_places_bloc.dart';

@freezed
class PlannedPlacesState with _$PlannedPlacesState {
  //Данные загружаются
  const factory PlannedPlacesState.loading() = _Loading;
  //Данные загружены
  const factory PlannedPlacesState.loaded({required List<PlacePlanned> favoritePlaces}) = _Loaded;
}
