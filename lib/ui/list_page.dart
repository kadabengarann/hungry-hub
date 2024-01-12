import 'package:hungry_hub_app/common/result_state.dart';
import 'package:hungry_hub_app/components/error_state_widget.dart';
import 'package:hungry_hub_app/components/restaurant_list_item.dart';
import 'package:hungry_hub_app/data/api/api_service.dart';
import 'package:hungry_hub_app/data/models/restaurants.dart';
import 'package:hungry_hub_app/data/provider/restaurant_provider.dart';
import 'package:hungry_hub_app/ui/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:hungry_hub_app/ui/restaurant_search_page.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hungry Hub',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showSearch<Restaurant?>(
                  context: context, delegate: RestaurantSearchPage());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider(apiService: ApiService()),
        child: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator(color: Colors.lightBlue));
            } else if (state.state == ResultState.hasData) {
              return ListView.builder(
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = state.result.restaurants[index].toEntity();
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
                            color: Color(0x9DE5E5E5),
                          ),
                        ),
                      ],
                    );
                  }
              );
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
    );
  }
}