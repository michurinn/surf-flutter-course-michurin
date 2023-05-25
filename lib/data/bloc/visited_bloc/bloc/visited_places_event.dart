part of 'visited_places_bloc.dart';

@freezed
class VisitedPlacesEvent with _$VisitedPlacesEvent {
  const factory VisitedPlacesEvent.load() = _Load;
}