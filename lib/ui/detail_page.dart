import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hungry_hub_app/common/result_state.dart';
import 'package:hungry_hub_app/components/error_state_widget.dart';
import 'package:hungry_hub_app/components/menu_list_item.dart';
import 'package:hungry_hub_app/data/api/api_service.dart';
import 'package:hungry_hub_app/data/models/restaurant_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:hungry_hub_app/data/provider/detail_restaurant_provider.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final String id;

  const RestaurantDetailPage({super.key, required this.id});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(
            apiService: ApiService(), id: widget.id),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator(color: Colors.lightBlue));
            } else if (state.state == ResultState.hasData) {
              final restaurant = state.result.restaurant;
              return buildDetailRestaurant(context, restaurant!);
            } else if (state.state == ResultState.noData) {
              return const ErrorStateWidget(
                  message: 'No Restaurant Data',
                  image: 'assets/images/no_data_img.png');
            } else if (state.state == ResultState.error) {
              return ErrorStateWidget(
                  message: state.message,
                  image: 'assets/images/failed_img.png');
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xC2000000),
                    blurRadius: 30,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 3,
                    offset: Offset(0, 0),
                  ),
                ],
              )
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget buildDetailRestaurant(BuildContext context, RestaurantItemDetail restaurant) {
    return SingleChildScrollView(
      child: ColumnSuper(
        innerDistance: -30,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Hero(
                tag: restaurant.pictureId,
                child: ClipRRect(
                    child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        kIsWeb
                            ? Image.network(
                          "assets/images/error_img.png",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          "assets/images/error_img.png",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                    ))),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xC2000000),
                  blurRadius: 100,
                  offset: Offset(0, -10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            double.parse(restaurant.rating).toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 5),
                          RatingBarIndicator(
                            rating: double.parse(restaurant.rating),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            restaurant.city,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.categories.length,
                        itemBuilder: (context, index) {
                          final categoryItem = restaurant.categories[index];
                          return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Chip(
                                label: Text(
                                  categoryItem,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ));
                        }),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                  Text(
                    "Foods:",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 105,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.foods.length,
                        itemBuilder: (context, index) {
                          final Food foodItem = restaurant.foods[index];
                          return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: MenuListItem(item: foodItem, imageUrl: "assets/images/food_img.png")
                          );
                        }),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                  Text(
                    "Drinks:",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 105,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.drinks.length,
                        itemBuilder: (context, index) {
                          final Drink drinkItem = restaurant.drinks[index];
                          return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: MenuListItem(item: drinkItem, imageUrl: "assets/images/drink_img.png")
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
