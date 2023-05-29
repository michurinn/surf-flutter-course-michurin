part of 'visited_places_bloc.dart';

@freezed
class VisitedPlacesState with _$VisitedPlacesState {
  //Данные загружаются
  const factory VisitedPlacesState.loading() = _Loading;
  //Данные загружены
  const factory VisitedPlacesState.loaded({required List<PlaceVisited> visitedPlaces}) = _Loaded;
}
