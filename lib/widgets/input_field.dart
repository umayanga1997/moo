import 'package:flutter/material.dart';
import 'package:moo/helper/fonts.dart';

class InputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final int maxLines;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingContent;
  final BorderSide? borderSide;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final bool? isDense;
  final String? Function(String?)? validatorFunction;
  const InputField(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      this.maxLines = 1,
      this.validatorFunction,
      this.padding,
      this.isDense,
      this.borderSide,
      this.onChanged,
      this.paddingContent,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        focusNode: focusNode,
        validator: validatorFunction ??
            (_) {
              return null;
            },
        onChanged: onChanged ?? (_) {},
        controller: textEditingController,
        maxLines: maxLines,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: mf,
            ),
        decoration: InputDecoration(
          hintText: hintText,
          isDense: isDense,
          contentPadding: paddingContent,
        ),
      ),
    );
  }
}
