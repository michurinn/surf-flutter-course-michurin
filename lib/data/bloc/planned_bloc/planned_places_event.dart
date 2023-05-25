part of 'planned_places_bloc.dart';

@freezed
class PlannedPlacesEvent with _$PlannedPlacesEvent {
  //Загрузить данные
  const factory PlannedPlacesEvent.load() = _load;
  const factory PlannedPlacesEvent.remove({required Place placePlanned}) = _Remove;
  const factory PlannedPlacesEvent.add({required Place placePlanned}) = _Add;
  const factory PlannedPlacesEvent.swipe({required int draggedPlaceId, required int targetPlaceId}) = _Swipe;
}
