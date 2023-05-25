part of 'planned_places_bloc.dart';

@freezed
class PlannedPlacesEvent with _$PlannedPlacesEvent {
  //Загрузить данные
  const factory PlannedPlacesEvent.load() = _load;
}
