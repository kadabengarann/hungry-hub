class RestaurantDetailResponse {
  RestaurantDetailResponse({
    required this.error,
    required this.message,
    this.restaurant,
  });

  bool error;
  String message;
  RestaurantItemDetail? restaurant;

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) {
    print("rest.restaurant.foods");
    var rest =
    RestaurantDetailResponse(
      error: json["error"],
      message: json["message"],
      restaurant: RestaurantItemDetail.fromJson(json["restaurant"]),
    );
    print(rest.restaurant?.foods);
    return  rest;
  }
}


class RestaurantItemDetail {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String rating;
  final List<String> categories;
  final List<Food> foods;
  final List<Drink> drinks;

  RestaurantItemDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.categories,
    required this.foods,
    required this.drinks,
  });

  factory RestaurantItemDetail.fromJson(Map<String, dynamic> json) => RestaurantItemDetail(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"].toString(),
    categories: List<String>.from(json["categories"].map((x) => x["name"])),
    foods: List<Food>.from(json["menus"]["foods"].map((x) => Food.fromJson(x))),
    drinks: List<Drink>.from(json["menus"]["drinks"].map((x) => Drink.fromJson(x))),
  );
}


class Food {
  final String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> food) {
    return Food(name: food['name']);
  }
}

class Drink {
  final String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> drink) {
    return Drink(name: drink['name']);
  }
}