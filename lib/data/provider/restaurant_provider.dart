import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hungry_hub_app/common/result_state.dart';
import 'package:hungry_hub_app/data/api/api_service.dart';
import 'package:hungry_hub_app/data/models/restaurant_response.dart';


class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantResponse _restaurantResponse;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantResponse get result => _restaurantResponse;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Restaurant Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResponse = restaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      _message = 'No Internet Connection';
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = "Failed to load list";
      notifyListeners();
    }
  }
}