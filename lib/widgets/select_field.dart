import 'package:flutter/material.dart';

class SelectField extends StatelessWidget {
  final List<DropdownMenuItem<String>> dataList;
  final String hintText;
  final Function(String?) onChanged;
  const SelectField(
      {Key? key,
      required this.dataList,
      required this.hintText,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DropdownButtonFormField(
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
          ),
        ),
      ),
    );
  }
}
