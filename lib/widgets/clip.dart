import 'package:flutter/material.dart';
import 'package:moo/helper/fonts.dart';

class ClipWidget extends StatelessWidget {
  final Color bgbrcolor;
  final Color color;
  final String title;
  final bool isBorder;

  const ClipWidget(
      {Key? key,
      required this.bgbrcolor,
      required this.color,
      required this.title,
      this.isBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: isBorder ? Colors.white : bgbrcolor,
      shape: RoundedRectangleBorder(
        side: isBorder
            ? BorderSide(
                color: bgbrcolor,
                width: 0.5,
                style: BorderStyle.solid,
              )
            : BorderSide.none,
        borderRadius: BorderRadius.circular(8.0),
      ),
      label: Text(
        title,
        style: TextStyle(
          fontSize: lf,
          fontWeight: FontWeight.w500,
          color: isBorder ? bgbrcolor : color,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
