import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Function onPressed;
  final dynamic bgcolor;
  final dynamic fontcolor;
  const CustomButton(
      {Key? key,
      required this.name,
      required this.onPressed,
      this.bgcolor,
      this.fontcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        top: 30.0,
      ),
      child: Center(
        child: SizedBox(
          width: size.width / 2,
          child: OutlinedButton(
            onPressed: () => onPressed(),
            clipBehavior: Clip.antiAlias,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 25,
              ),
              backgroundColor: bgcolor ?? Colors.white,
              alignment: Alignment.center,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                // side: BorderSide(
                //   color: btnColor,
                //   width: 2,
                //   style: BorderStyle.solid,
                // ),
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: fontcolor ?? btnColor,
                fontSize: mf,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
