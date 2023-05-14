import 'dart:async';

import 'package:places/domain/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_repository_interface.dart';
import 'package:places/mocks.dart';
import 'package:places/utils/distance_measure.dart';

class SearchInteractor {
  static final SearchInteractor _instance = SearchInteractor._internal();

  // ignore: non_constant_identifier_names
  factory SearchInteractor(IPlaceRepository IplaceRepository) {
    _placeRepository = IplaceRepository;
    return _instance;
  }

  SearchInteractor._internal();

  static PlacesFilterRequestDto _filter = const PlacesFilterRequestDto();

  List<String> get favoriteCategories => _filter.typeFilter ?? [];
  List<Place> get filteredPlaces => _filteredPlaces;
  List<String> get history => _history;

  static late final IPlaceRepository _placeRepository;
  void setFilter({
    double? radius,
    List<String>? typeFilter,
    String? nameFilter,
    double? lat,
    double? lng,
  }) {
    //TODO remove mock coordinates
    _filter = _filter.copyWith(
        lat: mockCoordinates['lat'],
        lng: mockCoordinates['lon'],
        typeFilter: typeFilter,
        nameFilter: nameFilter,
        radius: radius);
  }

  void resetFilter() {
    _filter = _filter.copyWith(
        lat: null, lng: null, typeFilter: null, nameFilter: null, radius: null);
  }

  void setOrUnsetCategory(String category) {
    if (_filter.typeFilter == null) {
      _filter = _filter.copyWith(typeFilter: [category]);
    }
    // Снимается галочка в екране фильтров
    else if (_filter.typeFilter!.contains(category)) {
      final List<String> newCategoriesList = _filter.typeFilter ?? [];
      newCategoriesList.remove(category);
      _filter.copyWith(typeFilter: newCategoriesList);
    }
    // Ставится галочка в екране фильтров
    else if (!_filter.typeFilter!.contains(category)) {
      final List<String> newCategoriesList = _filter.typeFilter ?? [];
      newCategoriesList.add(category);
      _filter.copyWith(typeFilter: newCategoriesList);
    }
  }

  //Поиск по имени
  Future<List<Place>> searchByName(String name) async {
    final PlacesFilterRequestDto namedFilter =
        _filter.copyWith(nameFilter: name);
    final response = await _placeRepository.getFilteredPlaces(namedFilter);

    _filteredPlaces = response.map((element) => element).toList();
    _filteredPlaces.sort(
      (a, b) => compareDistanses(a, b, mockCoordinates),
    );
    return _filteredPlaces;
  }

  //Поиск мест по фильтру
  Future<List<Place>> searchByFilter() async {
    final response = await _placeRepository.getFilteredPlaces(_filter);
    _filteredPlaces = response.map((element) => element).toList();
    return _filteredPlaces;
  }

  final StreamController<List<Place>?> _searchStreamController =
      StreamController();
  Stream<List<Place>?> get searchPlaceStream => _searchStreamController.stream;

  void addToHistory(String name) {
    name = name.trim();
    //Последний запрос помещаем в начало истории
    if (_history.contains(name)) {
      removeFromHistory(name);
    }
    _history.add(name);
  }

  void removeFromHistory(String name) {
    if (_history.contains(name)) {
      _history.remove(name);
    }
  }

  void clearHistory() {
    _history.clear();
  }

  List<Place> _filteredPlaces = [];

  final List<String> _history = [];
}
