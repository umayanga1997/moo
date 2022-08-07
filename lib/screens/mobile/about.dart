import 'package:flutter/material.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/helper/help_functions.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40.0,
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                isDark(context)
                    ? 'assets/logos/Logo_white.png'
                    : 'assets/logos/Logo.png',
                height: 120,
                width: 120,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.medium,
                // alignment: Alignment.center,
              ),
              Text(
                'Hi friends, We are Moo.\nWe publish movies through this app to watch and download for you.',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      height: 1.4,
                      fontSize: lf,
                    ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'The Moo App was designed and developed by Apec Lanka.',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        height: 1.4,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
