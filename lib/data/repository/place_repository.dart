// ignore_for_file: body_might_complete_normally_nullable

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_repository_interface.dart';
import 'package:places/http_client_interface.dart';

//Репозиторий интересных мест
class PlaceRepository implements IPlaceRepository {
  final IHttpClient httpClient;

  PlaceRepository({required this.httpClient});
  @override
  Future<Place?> addPlace(Place place) async {
    try {
      Completer<Place> completer = Completer();
      final response = await httpClient.dio.post(
        '/place',
        data: jsonEncode(
          place.toMap(),
        ),
      );
      completer.complete(placeFromMap(response.data));
      return completer.future;
    } on Exception catch (e) {
      print('Exception $e in addPlace');
    }
  }

  @override
  Future<List<Place>?> getPlacesList() async {
    try {
      final response = await httpClient.dio.get('/place');
      List result = response.data;
      result = result.expand((e) => [placeFromMap((e))]).toList();
      return result as List<Place>?;
    } on Exception catch (e) {
      print('Exception $e in getPlacesList');
    }
  }

  @override
  Future<void> deletePlaceByID(final int id) async {
    try {
      await httpClient.dio.delete('/place/$id');
    } on Exception catch (e) {
      print('Exception $e in deletePlaceByID');
    }
  }

  @override
  Future<List<PlaceDto>?> getFilteredPlaces(
      final PlacesFilterRequestDto filter) async {
    try {
      Completer<List<PlaceDto>> completer = Completer();

      final response = await httpClient.dio
          .post('/filtered_places', data: jsonEncode(filter.toMap()));
      List result = response.data;
      result = result.expand((e) => [placeFromMap((e))]).toList();
      completer.complete(result as List<PlaceDto>?);
      return completer.future;
    } on Exception catch (e) {
      print('Exception $e in getFilteredPlaces');
    }
  }

  @override
  Future<Place?> getPlaceByID(final int id) async {
    try {
      Completer<Place> completer = Completer();
      final Response<dynamic> responce = await httpClient.dio.get('/place/$id');
      completer.complete(placeFromMap(responce.data));
      return completer.future;
    } on Exception catch (e) {
      print('Exception $e in getPlaceByID');
    }
  }

  @override
  Future<String?> uploadFile(final String bytes) async {
    try {
      httpClient.dio.options.contentType = 'multipart/form-data';
      final Response response =
          await httpClient.dio.post('/upload_file', data: bytes);
      return response.data;
    } on Exception catch (e) {
      print('Exception $e in uploadFile');
    } finally {
      httpClient.dio.options.contentType = 'application/json';
    }
  }

  @override
  Future<Place?> updatePlaceByID(final Place place) async {
    try {
      Completer<Place> completer = Completer();
      Map<String, dynamic> request = place.toMap();
      // Невозможно изменить id на сервере
      request.remove('id');
      final Response response = await httpClient.dio.put(
        '/place/${place.id}',
        data: jsonEncode(
          request,
        ),
      );
      completer.complete(placeFromMap(response.data));
      return completer.future;
    } on Exception catch (e) {
      print('Exception $e in updatePlaceByID');
    }
  }
}
