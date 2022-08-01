import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/raw_data.dart';
import 'package:moo/widgets/select_field.dart';
import 'package:moo/widgets/widget.dart';

class MovieAddScreen extends StatefulWidget {
  final bool isUpdate;
  const MovieAddScreen({Key? key, this.isUpdate = false}) : super(key: key);

  @override
  State<MovieAddScreen> createState() => _MovieAddScreenState();
}

class _MovieAddScreenState extends State<MovieAddScreen> {
  final TextEditingController _nameEditController = TextEditingController();
  final TextEditingController _descriptionEditController =
      TextEditingController();
  final TextEditingController _yearEditController = TextEditingController();
  final TextEditingController _directorEditController = TextEditingController();
  final TextEditingController _actorsEditController = TextEditingController();
  final String _category = '';
  final String _language = '';
  final String _thumbURl = '';
  final String _fileDownloadUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a new movie',
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.done_all,
              size: 26,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            InputField(
              textEditingController: _nameEditController,
              hintText: "Name of the Movie",
            ),
            InputField(
              textEditingController: _descriptionEditController,
              hintText: "Description",
              maxLines: 5,
            ),
            InputField(
              textEditingController: _yearEditController,
              hintText: "Year",
            ),
            SelectField(
              hintText: "Select a Category",
              dataList: <String>[
                ...categories.map(
                  (e) => e.key + ' - ' + e.title,
                )
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                var data = value.toString().substring(0, 2);
                print(data);
              },
            ),
            SelectField(
              hintText: "Select a Language",
              dataList: <String>[
                ...languages.map(
                  (e) => e.key + ' - ' + e.data,
                )
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                var data = value.toString().substring(0, 2);
                print(data);
              },
            ),
            InputField(
              textEditingController: _directorEditController,
              hintText: "Director",
            ),
            InputField(
              textEditingController: _actorsEditController,
              hintText: "Actors",
              maxLines: 5,
            ),
            const SizedBox(
              height: 30,
            ),
            widget.isUpdate
                ? CustomButton(
                    name: 'Delete',
                    onPressed: () {},
                    bgcolor: Colors.red,
                    fontcolor: Colors.white,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
