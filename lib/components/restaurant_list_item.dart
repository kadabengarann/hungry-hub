import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hungry_hub_app/data/models/restaurants.dart';

class ResrtaurantListItem extends StatelessWidget {
  final Restaurant restaurant;
  final Function onTap;

  const ResrtaurantListItem({super.key, required this.restaurant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child:
                    Image.network(
                        "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                        height: 100,
                        width: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        kIsWeb
                            ? Image.network(
                          "assets/images/error_img.png",
                          height: 100,
                          width: 120,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          "assets/images/error_img.png",
                          height: 100,
                          width: 120,
                          fit: BoxFit.cover,
                        )
                    )
                ),
                Container(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(height: 5),
                            Text(
                              restaurant.name,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Container(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  restaurant.city,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              double.parse(restaurant.rating).toStringAsFixed(1),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}