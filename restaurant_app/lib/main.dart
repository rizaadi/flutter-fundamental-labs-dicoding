import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/search_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantProvider(apiService: ApiService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restauran App',
        theme: ThemeData.light(useMaterial3: true),
        initialRoute: '/home',
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => DetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
          SearchPage.routeName: (context) => const SearchPage(),
        },
      ),
    );
  }
}
