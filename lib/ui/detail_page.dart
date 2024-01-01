import 'package:hungry_hub_app/data/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restaurant'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: restaurant.pictureId,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    child: Image.network(
                      restaurant.pictureId,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    'Rating: ${restaurant.rating}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Location: ${restaurant.city}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                  Text(
                    "Foods:",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.foods.length,
                        itemBuilder: (context, index) {
                          final Food foodItem = restaurant.foods[index];
                          return buildItemList(
                              foodItem, "assets/images/food_img.png");
                        }),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                  Text(
                    "Drinks:",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.drinks.length,
                        itemBuilder: (context, index) {
                          final Drink drinkItem = restaurant.drinks[index];
                          return buildItemList(
                              drinkItem, "assets/images/drink_img.png");
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(dynamic item, String imageUrl) {
    return InkWell(
      child: SizedBox(
        width: 120,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Color(0xFFEFEFEF),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: kIsWeb
                        ? Image.network(
                            imageUrl,
                            height: 80,
                            fit: BoxFit.fitHeight,
                          )
                        : Image.asset(
                            'assets/images/drink_img.png',
                            height: 80,
                            fit: BoxFit.fitHeight,
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    item.name,
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
