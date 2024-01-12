import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MenuListItem extends StatelessWidget {
  final dynamic item;
  final String imageUrl;

  const MenuListItem({super.key,
    required this.item,
    required this.imageUrl,
  });

  @override
  Widget build (BuildContext context) {
    return InkWell(
      child: SizedBox(
        child: Stack(
          children: [
            Container(
              width: 140,
              height: double.infinity,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: kIsWeb
                    ? Image.network(
                  imageUrl,
                  fit: BoxFit.fitHeight,
                  color: Colors.black45,
                  colorBlendMode: BlendMode.darken,
                )
                    : Image.asset(
                  imageUrl,
                  fit: BoxFit.fitHeight,
                  color: Colors.black45,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
            Container(
              width: 140,
              height: double.infinity,
              alignment: Alignment.center,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        gradient:LinearGradient(
                            stops: [0,0.5,1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x00FFFFFF),Color(0x36000000),Color(0xC2000000)]
                        )
                    ),
                  )
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              width: 140,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  item.name,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}