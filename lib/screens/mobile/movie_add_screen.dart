// import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/helper/raw_data.dart';
import 'package:moo/models/movie_model.dart';
// import 'package:moo/services/drive.dart';
// import 'package:googleapis/drive/v3.dart' as ga;
// import 'package:moo/services/firebase.dart';
// import 'package:path/path.dart' as path;
import 'package:moo/widgets/widget.dart';

class MovieAddScreen extends StatefulWidget {
  final bool isUpdate;
  final MovieModel? movieModel;
  const MovieAddScreen(
      {Key? key, this.isUpdate = false, required this.movieModel})
      : super(key: key);

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
  String _category = '';
  String _language = '';

  PlatformFile? _thumbnailFile;
  PlatformFile? _movieFile;

  // _uploadFileToGoogleDrive() async {
  //   try {
  //     // googleSignIn.onCurrentUserChanged
  //     //     .listen((GoogleSignInAccount? googleSignInAccount) async {
  //     //   if (googleSignInAccount != null) {}
  //     // });
  //     var client =
  //         GoogleHttpClient(await googleSignIn.currentUser!.authHeaders);
  //     var drive = ga.DriveApi(client);
  //     ga.File fileToUpload = ga.File();
  //     var file = File(_movieFile?.path ?? "");
  //     fileToUpload.parents = ["appDataFolder"];
  //     fileToUpload.name = path.basename(file.absolute.path);
  //     var response = await drive.files.create(
  //       fileToUpload,
  //       uploadMedia: ga.Media(file.openRead(), file.lengthSync()),
  //     );
  //     print(response.id);
  //   } catch (e) {
  //     print(e);
  //   }

  //   // _listGoogleDriveFiles();
  // }

  @override
  void initState() {
    super.initState();
  }

  void selectMovieFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) _movieFile = result.files.single;
    // Need to upload to google drive
    setState(() {});
  }

  void selectThumbnail() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) _thumbnailFile = result.files.single;
    // Need to convert result as Uint8List to upload to firebase storage
    setState(() {});
  }

  void saveData() {}

  void updateData() {}

  void deleteData() {}

  void uploadfile({String type = "tmb"}) {}
  void deletefile({String type = "tmb"}) {}

  void compressImage() {}

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
            onPressed: () => widget.isUpdate ? updateData() : saveData(),
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
                _category = data;
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
                _language = data;
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
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Files',
                    style: TextStyle(
                      color: fcolorGrey,
                      fontSize: mf,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: FileCard(
                              onSelect: selectThumbnail,
                              name: 'Thumbnail',
                              file: _thumbnailFile,
                              fileUrl: widget.movieModel!.thumbnailURl,
                              isImg: true,
                            ),
                          ),
                          Flexible(
                            child: FileCard(
                              onSelect: selectMovieFile,
                              name: 'Movie File',
                              file: _movieFile,
                              fileUrl: widget.movieModel!.downloadID,
                              isImg: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
