import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';

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
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: mf,
            ),
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
        ),
      ),
    );
  }
}
