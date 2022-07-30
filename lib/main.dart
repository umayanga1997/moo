import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moo/controllers/category_controller.dart';
import 'package:moo/controllers/language_controller.dart';
import 'package:moo/layouts/layout.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Categorycontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageController(),
        )
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
      home: const Layout(),
      debugShowCheckedModeBanner: false,
    );
  }
}
