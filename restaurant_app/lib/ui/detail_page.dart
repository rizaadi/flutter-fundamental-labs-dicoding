import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import 'package:restaurant_app/widgets/collapse_text_widget.dart';
import 'package:restaurant_app/widgets/container_border_widget.dart';
import 'package:restaurant_app/widgets/loading_widget.dart';
import 'package:restaurant_app/widgets/no_internet_widget.dart';
import 'package:restaurant_app/widgets/review_form_widget.dart';

class DetailPage extends StatefulWidget {
  static String routeName = '/detail';

  final String id;
  const DetailPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantProvider>()
        ..restaurantState = RestaurantState.loading
        ..getDetailRestaurantById(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<RestaurantProvider>(
        builder: (context, prov, _) => switch (prov.restaurantState) {
          RestaurantState.loading => const LoadingWidget(),
          RestaurantState.error => const Center(child: Icon(Icons.error)),
          RestaurantState.disconnect => NoInternetWidget(
              onPressed: () => context
                  .read<RestaurantProvider>()
                  .getDetailRestaurantById(widget.id),
            ),
          RestaurantState.ok => _buildDetailPage(),
        },
      ),
    );
  }

  Widget _buildDetailPage() {
    final restaurant =
        context.read<RestaurantProvider>().detailRestaurant.restaurant;
    if (restaurant == null) {
      return const SizedBox();
    }
    return SafeArea(
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
                      'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews',
                    style: GoogleFonts.inter(
                      fontSize: 21.88,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<RestaurantProvider>().reviewRestaurantState =
                          ReviewRestaurantState.ok;
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        isScrollControlled: true,
                        builder: (context) => ReviewFormWidget(id: widget.id),
                      );
                    },
                    child: Text(
                      'Add Review',
                      style: GoogleFonts.inter(
                        color: Colors.blue.shade300,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              Divider(color: Colors.blueGrey.shade50),
              const SizedBox(height: 5),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: restaurant.customerReviews?.length ?? 0,
                separatorBuilder: (context, index) => Container(
                  height: 5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                  ),
                ),
                itemBuilder: (context, index) {
                  final review = restaurant.customerReviews![index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.name ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          review.review ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          review.date ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
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
