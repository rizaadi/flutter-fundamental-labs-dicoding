// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/widgets/collapse_text_widget.dart';
import 'package:restaurant_app/widgets/container_border_widget.dart';

class DetailPage extends StatelessWidget {
  static String routeName = '/detail';

  final Restaurant restaurant;
  const DetailPage({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar.large(
                pinned: true,
                expandedHeight: 200,
                titleSpacing: 10,
                surfaceTintColor: Colors.blue,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: restaurant.pictureId!,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image.network(
                        restaurant.pictureId!,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  centerTitle: true,
                  title: Text(
                    restaurant.name!,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 21.88,
                    ),
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 10,
                  children: [
                    ContainerBorderWidget(
                      title: '${restaurant.rating}',
                      icon: Icon(
                        Icons.star_rate_rounded,
                        size: 20,
                        color: Colors.yellow.shade900,
                      ),
                    ),
                    ContainerBorderWidget(
                      title: restaurant.city!,
                      icon: Icon(
                        Icons.location_on_rounded,
                        size: 18,
                        color: Colors.blue.shade300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'Description',
                  style: GoogleFonts.inter(
                    fontSize: 21.88,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Divider(color: Colors.blueGrey.shade50),
                const SizedBox(height: 5),
                CollapseTextWidget(text: restaurant.description!),
                const SizedBox(height: 10),
                Text(
                  'Menu',
                  style: GoogleFonts.inter(
                    fontSize: 21.88,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Divider(color: Colors.blueGrey.shade50),
                const SizedBox(height: 5),
                Text(
                  'Foods',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 10,
                    children: restaurant.menus?.foods
                            ?.map((food) => ContainerMenu(
                                  name: food.name!,
                                ))
                            .toList() ??
                        [],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Drinks',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 10,
                    children: restaurant.menus?.drinks
                            ?.map((food) => ContainerMenu(
                                  name: food.name!,
                                ))
                            .toList() ??
                        [],
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

class ContainerMenu extends StatelessWidget {
  const ContainerMenu({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Text(
          name,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
