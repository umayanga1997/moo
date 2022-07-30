import 'package:flutter/material.dart';
import 'package:moo/screens/mobile/home_screen.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.minWidth <= 600) return const HomeScreen();
          return Container();
        },
      ),
    );
  }
}
