import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:moo/controllers/category_controller.dart';
import 'package:moo/controllers/language_controller.dart';
import 'package:moo/controllers/search_controller.dart';
import 'package:moo/controllers/theme_controller.dart';
import 'package:moo/helper/theme.dart';
import 'package:moo/layouts/layout.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Categorycontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moo',
      theme: ThemeType().lightMode(),
      darkTheme: ThemeType().darkMode(),
      themeMode: context.watch<ThemeController>().isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const Layout(),
      debugShowCheckedModeBanner: false,
    );
  }
}
