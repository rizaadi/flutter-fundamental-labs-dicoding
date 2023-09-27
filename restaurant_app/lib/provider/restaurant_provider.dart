import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant_model.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/data/model/review_restaurant_form_model.dart';
import 'package:restaurant_app/data/model/review_restaurant_model.dart';
import 'package:restaurant_app/data/model/search_restaurant_model.dart';

enum RestaurantState { ok, loading, error, disconnect }

enum SearchRestaurantState { init, ok, loading, error, disconnect }

enum ReviewRestaurantState { ok, loading, error, disconnect }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService});

  RestaurantState _restaurantState = RestaurantState.loading;
  RestaurantState get restaurantState => _restaurantState;
  set restaurantState(RestaurantState value) {
    _restaurantState = value;
    notifyListeners();
  }

  RestaurantModel _restaurantModel = RestaurantModel();
  RestaurantModel get restaurantModel => _restaurantModel;

  Future<void> getListRestaurant() async {
    try {
      _restaurantState = RestaurantState.loading;
      notifyListeners();

      final listRestaurant = await apiService.getListRestaurant();
      if (listRestaurant.restaurants?.isNotEmpty ?? false) {
        _restaurantModel = listRestaurant;
        _restaurantState = RestaurantState.ok;
        notifyListeners();
      } else {
        throw Exception('listRestaurant Empty');
      }
    } on SocketException catch (e) {
      log(e.message);
      _restaurantState = RestaurantState.disconnect;
      notifyListeners();
    } catch (e) {
      log('getListRestaurant Error $e');
      _restaurantState = RestaurantState.error;
      notifyListeners();
    }
  }

  DetailRestaurantModel _detailRestaurant = DetailRestaurantModel();
  DetailRestaurantModel get detailRestaurant => _detailRestaurant;

  Future<void> getDetailRestaurantById(String id) async {
    try {
      _restaurantState = RestaurantState.loading;
      notifyListeners();

      final detailRestaurant = await apiService.getDetailRestaurantById(id);
      if (detailRestaurant.restaurant != null) {
        _detailRestaurant = detailRestaurant;
        _restaurantState = RestaurantState.ok;
        notifyListeners();
      } else {
        throw Exception('detailRestaurant Empty');
      }
    } on SocketException {
      _restaurantState = RestaurantState.disconnect;
      notifyListeners();
    } catch (e) {
      log('detailRestaurant Error $e');
      _restaurantState = RestaurantState.error;
      notifyListeners();
    }
  }

  SearchRestaurantState _searchRestaurantState = SearchRestaurantState.init;
  SearchRestaurantState get searchRestaurantState => _searchRestaurantState;
  set searchRestaurantState(SearchRestaurantState value) {
    _searchRestaurantState = value;
    notifyListeners();
  }

  SearchRestaurantModel _searchRestaurant = SearchRestaurantModel();
  SearchRestaurantModel get searchRestaurant => _searchRestaurant;
  Future<void> getSearchRestaurant(String query) async {
    try {
      _searchRestaurantState = SearchRestaurantState.loading;
      notifyListeners();

      final searchRestaurant = await apiService.searchRestaurant(query);
      if (searchRestaurant.restaurants != null) {
        _searchRestaurant = searchRestaurant;
        _searchRestaurantState = SearchRestaurantState.ok;
        notifyListeners();
      } else {
        throw Exception('searchRestaurant Empty');
      }
    } on SocketException {
      _searchRestaurantState = SearchRestaurantState.disconnect;
      notifyListeners();
    } catch (e) {
      log('getSearchRestaurant Error $e');
      _searchRestaurantState = SearchRestaurantState.error;
      notifyListeners();
    }
  }

  ReviewRestaurantState _reviewRestaurantState = ReviewRestaurantState.ok;
  ReviewRestaurantState get reviewRestaurantState => _reviewRestaurantState;
  set reviewRestaurantState(ReviewRestaurantState value) {
    _reviewRestaurantState = value;
    notifyListeners();
  }

  Future<ReviewRestaurantModel> reviewRestaurant(ReviewRestaurantFormModel review) async {
    try {
      _reviewRestaurantState = ReviewRestaurantState.loading;
      notifyListeners();

      final reviewRestaurant = await apiService.reviewRestaurant(review);
      if (reviewRestaurant.error ?? true) {
        return throw Exception('reviewRestaurant Status Error');
      } else {
        _detailRestaurant.restaurant!.customerReviews = reviewRestaurant.customerReviews;

        _reviewRestaurantState = ReviewRestaurantState.ok;
        notifyListeners();
        return reviewRestaurant;
      }
    } on SocketException {
      _reviewRestaurantState = ReviewRestaurantState.disconnect;
      notifyListeners();
      return throw Exception();
    } catch (e) {
      log('reviewRestaurant Error $e');
      _reviewRestaurantState = ReviewRestaurantState.error;
      notifyListeners();
      return throw Exception();
    }
  }
}
