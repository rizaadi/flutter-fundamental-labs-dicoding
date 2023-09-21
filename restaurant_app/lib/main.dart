import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/model/restaurant_model.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restauran App',
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: '/home',
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => DetailPage(
              restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
