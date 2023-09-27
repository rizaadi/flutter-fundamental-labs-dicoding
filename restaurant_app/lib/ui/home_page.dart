import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/widgets/loading_widget.dart';
import 'package:restaurant_app/widgets/no_internet_widget.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantProvider>().getListRestaurant();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Menu'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, prov, _) => switch (prov.restaurantState) {
          RestaurantState.loading => const LoadingWidget(),
          RestaurantState.error => const Center(child: Icon(Icons.error)),
          RestaurantState.disconnect => NoInternetWidget(
              onPressed: () =>
                  context.read<RestaurantProvider>().getListRestaurant()),
          RestaurantState.ok => _buildHomepage()
        },
      ),
    );
  }

  Widget _buildHomepage() {
    final listRestaurant =
        context.read<RestaurantProvider>().restaurantModel.restaurants ?? [];
    if (listRestaurant.isEmpty) {
      return Center(
        child: Text(
          "Empty",
          style: GoogleFonts.inter(),
        ),
      );
    }
    return ListView.builder(
      itemCount: listRestaurant.length,
      itemBuilder: (context, index) {
        final resIndex = listRestaurant[index];
        return RestaurantWidget(
          id: resIndex.id!,
          pictureId: resIndex.pictureId!,
          name: resIndex.name!,
          city: resIndex.city!,
          rating: resIndex.rating!,
        );
      },
    );
  }
}

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget({
    super.key,
    required this.id,
    required this.pictureId,
    required this.name,
    required this.city,
    required this.rating,
  });

  final String id;
  final String pictureId;
  final String name;
  final String city;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: pictureId,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/small/$pictureId',
            fit: BoxFit.cover,
            width: 100,
            errorBuilder: (ctx, error, _) =>
                const Center(child: Icon(Icons.error)),
          ),
        ),
      ),
      title: Text(
        name,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        city,
        style: GoogleFonts.inter(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rate_rounded,
            size: 15,
            color: Colors.yellow.shade900,
          ),
          Text(
            '$rating',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: id);
      },
    );
  }
}
