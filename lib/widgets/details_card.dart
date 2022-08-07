import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/helper/help_functions.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String value;
  const DetailCard({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: Theme.of(context).textTheme.headline1?.fontSize,
              color: isDark(context)
                  ? Theme.of(context).textTheme.headline3?.color
                  : Theme.of(context).textTheme.headline1?.color,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
