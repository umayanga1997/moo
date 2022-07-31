import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moo/controllers/category_controller.dart';
import 'package:moo/controllers/language_controller.dart';
import 'package:moo/controllers/theme_controller.dart';
import 'package:moo/layouts/layout.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 2,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            // systemNavigationBarColor: Colors.white,
            // systemNavigationBarIconBrightness: Brightness.dark,
          ),
        ),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 58, 58, 58),
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),
      themeMode: context.watch<ThemeController>().isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const Layout(),
      debugShowCheckedModeBanner: false,
    );
  }
}
