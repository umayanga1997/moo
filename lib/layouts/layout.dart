import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moo/screens/mobile/home_screen.dart';
import 'package:moo/screens/mobile/signin_screen.dart';
import 'package:moo/services/firebase.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: StreamBuilder<User?>(
          stream: auth.authStateChanges(),
          builder: (context, snapshot) {
            return LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.minWidth <= 600;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                } else if (snapshot.hasData && isMobile) {
                  return const HomeScreen();
                } else if (snapshot.hasData && !isMobile) {
                  return Container();
                } else {
                  return const SignInScreen();
                }
              },
            );
          }),
    );
  }
}
