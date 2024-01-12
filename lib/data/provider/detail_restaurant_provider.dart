import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hungry_hub_app/common/result_state.dart';
import 'package:hungry_hub_app/data/api/api_service.dart';
import 'package:hungry_hub_app/data/models/restaurant_detail_model.dart';


class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurantDetail(id);
  }

  late RestaurantDetailResponse _restaurantDetailResponse;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetailResponse get result => _restaurantDetailResponse;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(id);

      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantDetailResponse = restaurant;
    } on SocketException {
      _state = ResultState.error;
      _message = 'No Internet Connection';
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = "Failed to load restaurant detail";
      notifyListeners();
    }
  }
}