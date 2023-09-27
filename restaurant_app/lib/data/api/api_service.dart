import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_restaurant_model.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/data/model/review_restaurant_form_model.dart';
import 'package:restaurant_app/data/model/review_restaurant_model.dart';
import 'package:restaurant_app/data/model/search_restaurant_model.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantModel> getListRestaurant() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load getListRestaurant');
    }
  }

  Future<DetailRestaurantModel> getDetailRestaurantById(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load getRestaurantById');
    }
  }

  Future<SearchRestaurantModel> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load getRestaurantById');
    }
  }

  Future<ReviewRestaurantModel> reviewRestaurant(ReviewRestaurantFormModel review) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(review.toJson()),
    );
    if (response.statusCode == 201) {
      return ReviewRestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to post reviewRestaurant ${response.body}');
    }
  }
}
