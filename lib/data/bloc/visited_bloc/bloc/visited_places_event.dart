part of 'visited_places_bloc.dart';

@freezed
class VisitedPlacesEvent with _$VisitedPlacesEvent {
  const factory VisitedPlacesEvent.load() = _Load;
  const factory VisitedPlacesEvent.remove({required PlaceVisited visitedPlace}) = _Remove;
  const factory VisitedPlacesEvent.add({required PlaceVisited visitedPlace}) = _Add;
    const factory VisitedPlacesEvent.swipe({required int draggedPlaceId, required int targetPlaceId}) = _Swipe;

}