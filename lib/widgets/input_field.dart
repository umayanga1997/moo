import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final int maxLines;
  final String Function(String?) validatorFunction;
  const InputField(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      this.maxLines = 1,
      required this.validatorFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        validator: validatorFunction,
        controller: textEditingController,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          // isDense: true,
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
