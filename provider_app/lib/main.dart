import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/provider/done_module_provider.dart';
import 'package:provider_app/ui/module_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DoneModuleProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true),
        home: const ModulePage(),
      ),
    );
  }
}
