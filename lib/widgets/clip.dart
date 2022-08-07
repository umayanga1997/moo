import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';

class ClipWidget extends StatelessWidget {
  final String title;
  final bool isBorder;
  final Color? bgColor;

  const ClipWidget(
      {Key? key, required this.title, this.isBorder = false, this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: bgColor,
      shape: isBorder
          ? Theme.of(context).chipTheme.shape
          : Theme.of(context).chipTheme.shape?.copyWith(
                side: BorderSide.none,
              ),
      label: Text(
        title,
        style: TextStyle(
          fontSize: Theme.of(context).chipTheme.labelStyle?.fontSize,
          fontWeight: FontWeight.w500,
          color: !isBorder
              ? whiteColor
              : Theme.of(context).chipTheme.labelStyle?.color,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
