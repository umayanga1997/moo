import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';

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
            style: TextStyle(
              fontSize: mf,
              color: fcolorGrey,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: lf,
              color: mainColor,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
