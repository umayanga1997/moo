import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final int maxLines;
  final EdgeInsetsGeometry? padding;
  final BorderSide? borderSide;
  final Function(String)? onChanged;
  final String? Function(String?)? validatorFunction;
  const InputField(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      this.maxLines = 1,
      this.validatorFunction,
      this.padding,
      this.borderSide,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        validator: validatorFunction ??
            (_) {
              return null;
            },
        onChanged: onChanged ?? (_) {},
        controller: textEditingController,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          // isDense: true,
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: borderSide ??
                BorderSide(
                  style: BorderStyle.solid,
                  width: 0.5,
                  color: fcolorGrey.withOpacity(0.7),
                ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
