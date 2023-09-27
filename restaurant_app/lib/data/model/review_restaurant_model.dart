import 'dart:convert';

import 'package:restaurant_app/data/model/detail_restaurant_model.dart';

ReviewRestaurantModel reviewRestaurantModelFromJson(String str) =>
    ReviewRestaurantModel.fromJson(json.decode(str));

String reviewRestaurantModelToJson(ReviewRestaurantModel data) =>
    json.encode(data.toJson());

class ReviewRestaurantModel {
  bool? error;
  String? message;
  List<CustomerReview>? customerReviews;

  ReviewRestaurantModel({
    this.error,
    this.message,
    this.customerReviews,
  });

  factory ReviewRestaurantModel.fromJson(Map<String, dynamic> json) =>
      ReviewRestaurantModel(
        error: json["error"],
        message: json["message"],
        customerReviews: json["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(json["customerReviews"]!
                .map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": customerReviews == null
            ? []
            : List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };
}
