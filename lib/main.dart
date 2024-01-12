import 'package:hungry_hub_app/data/api/api_service.dart';
import 'package:hungry_hub_app/data/provider/search_restaurant_provider.dart';
import 'package:hungry_hub_app/ui/detail_page.dart';
import 'package:hungry_hub_app/ui/list_page.dart';
import 'package:hungry_hub_app/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchRestaurantProvider(apiService: ApiService())),
      ],
      child: MaterialApp(
        title: 'Hungry Hub',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: Colors.black,
            secondary: secondaryColor,
          ),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
            ),
          ),
        ),
        initialRoute: ListPage.routeName,
        routes: {
          ListPage.routeName: (context) => const ListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            id: ModalRoute.of(context)?.settings.arguments as String,
          ),
        },
      ),
    );
  }
}
