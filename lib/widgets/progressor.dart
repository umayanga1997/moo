import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';

class Progressor extends StatelessWidget {
  final double? value;
  final bool isCircular;
  final double? width;
  final double? strokeWidth;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const Progressor(
      {Key? key,
      this.value,
      this.isCircular = true,
      this.width,
      this.height,
      this.padding,
      this.strokeWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isCircular
          ? Padding(
              padding: padding ?? const EdgeInsets.all(0.0),
              child: SizedBox(
                width: width ?? 30,
                height: height ?? 30,
                child: CircularProgressIndicator(
                  strokeWidth: strokeWidth ?? 4,
                  // color: btnColor,
                  value: value,
                  // valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                // color: btnColor,
                value: value,
                valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                minHeight: 5,
              ),
            ),
    );
  }
}
