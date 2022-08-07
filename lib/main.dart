import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
  // Splash Screen Remove
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // removeSplash();
  // Check current theme mode of the mobile
  var brightness = SchedulerBinding.instance.window.platformBrightness;
  bool isDarkMode = brightness == Brightness.dark;
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
          create: (context) => ThemeController(isDark: isDarkMode),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// Future<void> removeSplash() async {
//   Future.delayed(
//       const Duration(seconds: 2), () => FlutterNativeSplash.remove());
// }

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
