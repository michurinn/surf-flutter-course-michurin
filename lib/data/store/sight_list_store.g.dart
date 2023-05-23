// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SightListStore on SightListStoreBase, Store {
  late final _$placesAtom =
      Atom(name: 'SightListStoreBase.places', context: context);

  @override
  ObservableFuture<List<Place>> get places {
    _$placesAtom.reportRead();
    return super.places;
  }

  @override
  set places(ObservableFuture<List<Place>> value) {
    _$placesAtom.reportWrite(value, super.places, () {
      super.places = value;
    });
  }

  late final _$checkPlacesAsyncAction =
      AsyncAction('SightListStoreBase.checkPlaces', context: context);

  @override
  Future<void> checkPlaces({bool isHidden = false}) {
    return _$checkPlacesAsyncAction
        .run(() => super.checkPlaces(isHidden: isHidden));
  }

  late final _$addPlaceAsyncAction =
      AsyncAction('SightListStoreBase.addPlace', context: context);

  @override
  Future<void> addPlace(Place newPlace) {
    return _$addPlaceAsyncAction.run(() => super.addPlace(newPlace));
  }

  @override
  String toString() {
    return '''
places: ${places}
    ''';
  }
}
