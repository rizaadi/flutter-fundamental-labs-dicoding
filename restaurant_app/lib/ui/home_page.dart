import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Menu'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            final List<Restaurant> restaurant = RestaurantModel.fromJson(jsonDecode(snapshot.data!)).restaurants ?? [];
            return ListView.builder(
              itemCount: restaurant.length,
              itemBuilder: (context, index) {
                final resIndex = restaurant[index];
                return ListTile(
                  leading: Hero(
                    tag: resIndex.pictureId!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${resIndex.pictureId}',
                        fit: BoxFit.cover,
                        width: 100,
                        errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
                      ),
                    ),
                  ),
                  title: Text(
                    resIndex.name!,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(resIndex.city!, style: GoogleFonts.inter()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_rate_rounded,
                        size: 15,
                        color: Colors.yellow.shade900,
                      ),
                      Text(
                        '${resIndex.rating}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, DetailPage.routeName, arguments: resIndex);
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Icon(Icons.error),
            );
          }
        },
      ),
    );
  }
}
