import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/style/text_form_field.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/widgets/loading_widget.dart';
import 'package:restaurant_app/widgets/no_internet_widget.dart';

class SearchPage extends StatefulWidget {
  static String routeName = '/search';

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantProvider>().searchRestaurantState = SearchRestaurantState.init;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Search Restaurant',
          style: GoogleFonts.inter(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              onFieldSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  context.read<RestaurantProvider>().getSearchRestaurant(value);
                }
              },
              decoration: inputDecoration(hintText: 'Search Restaurants'),
            ),
            const SizedBox(height: 10),
            Consumer<RestaurantProvider>(
              builder: (context, prov, _) => switch (prov.searchRestaurantState) {
                SearchRestaurantState.init => const SizedBox(),
                SearchRestaurantState.loading => const LoadingWidget(),
                SearchRestaurantState.error => const Center(child: Icon(Icons.error)),
                SearchRestaurantState.disconnect => const NoInternetWidget(),
                SearchRestaurantState.ok => _buildRestaurants()
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurants() {
    final restaurant = context.read<RestaurantProvider>().searchRestaurant.restaurants ?? [];
    if (restaurant.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            "Restaurant not found",
            style: GoogleFonts.inter(),
          ),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: restaurant.length,
        itemBuilder: (context, index) {
          final resIndex = restaurant[index];
          return RestaurantWidget(
            id: resIndex.id!,
            pictureId: resIndex.pictureId!,
            name: resIndex.name!,
            city: resIndex.city!,
            rating: resIndex.rating!,
          );
        },
      ),
    );
  }
}
