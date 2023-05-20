import 'package:mobx/mobx.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_repository_interface.dart';
import 'package:places/domain/place.dart';

part 'sight_list_store.g.dart';

class SightListStore = SightListStoreBase with _$SightListStore;

abstract class SightListStoreBase with Store {
  SightListStoreBase(this._placeRepository);

  final IPlaceRepository _placeRepository;

  @observable
  late ObservableFuture<List<Place>> places;

  @action
  Future<void> checkPlaces({
    bool isHidden = false,
  }) async {
    if (isHidden) {
      var result = await _placeRepository.getPlacesList();
      places = ObservableFuture.value(result);
    } else {
      places = ObservableFuture(_placeRepository.getPlacesList());
    }
  }

  @action
  Future<void> checkPlacesWithFilter(
      {required PlacesFilterRequestDto filter}) async {
    places = ObservableFuture(_placeRepository.getFilteredPlaces(filter));
  }

  @action
  Future<void> addPlace(Place newPlace) async {
    await _placeRepository.addPlace(newPlace);
  }
}
