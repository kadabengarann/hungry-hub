import 'package:hungry_hub_app/data/models/restaurants.dart';

class RestaurantSearchResponse {
  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantItem> restaurants;

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantItem>.from(
            json["restaurants"].map((x) => RestaurantItem.fromJson(x))),
      );
}

class RestaurantResponse {
  RestaurantResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<RestaurantItem> restaurants;

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantItem>.from(
            json["restaurants"].map((x) => RestaurantItem.fromJson(x))),
      );
}

class RestaurantItem {
  RestaurantItem({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory RestaurantItem.fromJson(Map<String, dynamic> json) => RestaurantItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );



  Restaurant toEntity() {
    return Restaurant(
      id: id,
      name: name,
      description: description,
      pictureId: pictureId,
      city: city,
      rating: rating.toString(),
      foods: [],
      drinks: [],
    );
  }
}