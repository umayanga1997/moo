import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';

class SelectField extends StatelessWidget {
  final List<DropdownMenuItem<String>> dataList;
  final String hintText;
  final String? currentItem;
  final Function(String?) onChanged;
  final String? Function(String?) validatorFunction;
  const SelectField(
      {Key? key,
      required this.dataList,
      required this.hintText,
      required this.onChanged,
      required this.validatorFunction,
      required this.currentItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DropdownButtonFormField(
        validator: validatorFunction,
        value: currentItem,
        items: dataList,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 0.5,
              color: fcolorGrey.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
