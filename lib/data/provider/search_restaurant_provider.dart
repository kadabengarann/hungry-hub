import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hungry_hub_app/common/result_state.dart';
import 'package:hungry_hub_app/data/api/api_service.dart';
import 'package:hungry_hub_app/data/models/restaurant_response.dart';


class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService});

  late RestaurantSearchResponse _restaurantSearchResponse;
  late ResultState _state = ResultState.loading;
  String _message = '';
  String _query = '';

  List<RestaurantItem> _searchResult = [];
  List<RestaurantItem> get searchResult => _searchResult;

  String get message => _message;

  RestaurantSearchResponse get result => _restaurantSearchResponse;

  ResultState get state => _state;

  Future<void> searchRestaurant(String query) async {
    if (query != _query) {
      _query = query;
    } else {
      return;
    }
    try {
      print("============================   searchRestaurant called with query: $query ================================");
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query);

      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'No Restaurant Data';
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _searchResult = restaurant.restaurants;
        notifyListeners();
      }
    } on SocketException {
      _state = ResultState.error;
      _message = 'No Internet Connection';
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = "Failed to search restaurant";
      notifyListeners();
    }
  }
}