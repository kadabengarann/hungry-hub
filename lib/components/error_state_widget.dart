import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final String image;

  const ErrorStateWidget({super.key, required this.message, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          kIsWeb
              ? Image.network(
            image,
            height: 150,
          )
              : Image.asset(
            image,
            height: 150,
          ),
          const SizedBox(height: 15),
          Text(message)
        ],
      ),
    );
  }
}