import 'package:flutter/material.dart';
import 'package:hungry_hub_app/common/result_state.dart';
import 'package:hungry_hub_app/components/error_state_widget.dart';
import 'package:hungry_hub_app/components/restaurant_list_item.dart';
import 'package:hungry_hub_app/data/models/restaurants.dart';
import 'package:hungry_hub_app/data/provider/search_restaurant_provider.dart';
import 'package:hungry_hub_app/ui/detail_page.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class RestaurantSearchPage extends SearchDelegate<Restaurant?> {
  Timer? _debounce;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.navigate_before));
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        Provider.of<SearchRestaurantProvider>(context, listen: false)
            .searchRestaurant(query);
      }
    });
    if (query.isEmpty) {
      return const Center(
        child: Text("Search Restaurant"),
      );
    } else {
      return buildList(context);
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      Provider.of<SearchRestaurantProvider>(context, listen: false)
          .searchRestaurant(query);
    }
    return query.isEmpty
        ? const Center(
      child: Text("Search Restaurant"),)
        : buildList(context);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Widget buildList(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator(color: Colors.lightBlue));
          } else if (state.state == ResultState.hasData) {
            final restaurants = state.searchResult;
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index].toEntity();
                return Column(
                  children: [
                    ResrtaurantListItem(restaurant: restaurant, onTap: () {
                      Navigator.pushNamed(
                          context,
                          RestaurantDetailPage.routeName
                              .replaceFirst(':id', restaurant.id),
                          arguments: restaurant.id);},
                    ),
                    Container(
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xD7EFEFEF),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state.state == ResultState.noData) {
            return const ErrorStateWidget(
                message: 'No Restaurant Found',
                image: 'assets/images/no_data_img.png');
          } else if (state.state == ResultState.error) {
            return ErrorStateWidget(
                message: state.message,
                image: 'assets/images/failed_img.png');
          } else {
            return Container();
          }
        },
      );
  }
}