import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_repository_interface.dart';
import 'package:places/http_client_interface.dart';

//Репозиторий интересных мест
class PlaceRepository implements IPlaceRepository {
  final IHttpClient httpClient;

  PlaceRepository({required this.httpClient});
  @override
  Future<void> addPlace(Place place) async {
    try {
      Response<String> response = await httpClient.dio.post(
        '/place',
        data: jsonEncode(
          place.toMap(),
        ),
      );
    } on Exception catch (e) {
      print('Exception $e in addPlace');
    }
  }

  @override
  Future<void> getPlacesList() async {
    try {
      await httpClient.dio.get('/place');
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
  Future<void> getFilteredPlaces(final PlacesFilterRequestDto filter) async {
    try {
      await httpClient.dio
          .post('/filtered_places', data: jsonEncode(filter.toMap()));
    } on Exception catch (e) {
      print('Exception $e in getFilteredPlaces');
    }
  }

  @override
  Future<void> getPlaceByID(final int id) async {
    try {
      await httpClient.dio.get('/place/$id');
    } on Exception catch (e) {
      print('Exception $e in getPlaceByID');
    }
  }

  @override
  Future<void> uploadFile(final String bytes) async {
    try {
      httpClient.dio.options.contentType = 'multipart/form-data';
      httpClient.dio.post('/upload_file', data: bytes);
    } on Exception catch (e) {
      print('Exception $e in uploadFile');
    } finally {
      httpClient.dio.options.contentType = 'application/json';
    }
  }

  @override
  Future<void> updatePlaceByID(final Place place) async {
    try {
      Map<String, dynamic> request = place.toMap();
      request.remove('id');
      await httpClient.dio.put(
        '/place/${place.id}',
        data: jsonEncode(
          request,
        ),
      );
    } on Exception catch (e) {
      print('Exception $e in updatePlaceByID');
    }
  }
}
