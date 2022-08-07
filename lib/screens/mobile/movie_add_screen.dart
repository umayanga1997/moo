import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/helper/help_functions.dart';
import 'package:moo/helper/raw_data.dart';
import 'package:moo/models/movie_model.dart';
import 'package:moo/services/firebase.dart';
import 'package:moo/services/message.dart';
import 'package:moo/widgets/widget.dart';
import 'package:uuid/uuid.dart';

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
  final TextEditingController _fileDownloadIdController =
      TextEditingController();
  String _category = '';
  String _language = '';

  final formKey = GlobalKey<FormState>();

  PlatformFile? _thumbnailFile;
  bool _isThumbnailFile = true;

  bool _prcessing = false;
  bool _dprcessing = false;

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
    widget.isUpdate ? initValues() : () {};
  }

  initValues() {
    _nameEditController.text = widget.movieModel!.name!;
    _descriptionEditController.text = widget.movieModel!.description!;
    _yearEditController.text = widget.movieModel!.year!;
    _directorEditController.text = widget.movieModel!.director!;
    _actorsEditController.text = widget.movieModel!.actors!;
    _fileDownloadIdController.text = widget.movieModel!.downloadID!;
    _category = widget.movieModel!.category!;
    _language = widget.movieModel!.language!;
  }

  void selectThumbnail() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) _thumbnailFile = result.files.single;
      setState(() {
        _isThumbnailFile = true;
      });
    } catch (e) {
      errorMessage(message: e.toString());
    }
  }

  void saveData() async {
    try {
      var docID = const Uuid().v4();
      var thumbnailURL = await uploadfile(id: docID);

      fireStore.collection('movies').doc(docID).set({
        "id": docID,
        "name": _nameEditController.text.toString(),
        "description": _descriptionEditController.text.toString(),
        "thumbnailURl": thumbnailURL,
        "year": _yearEditController.text.toString(),
        "category": _category,
        "language": _language,
        "director": _directorEditController.text.toString(),
        "actors": _actorsEditController.text.toString(),
        "downloadID": _fileDownloadIdController.text.toString(),
      }).then((value) {
        setState(() {
          _prcessing = false;
        });
        clearFileds();
        successMessage(message: 'Data added successfully!');
      });
    } catch (e) {
      setState(() {
        _prcessing = false;
      });
      errorMessage(message: e.toString());
    }
  }

  void updateData() async {
    try {
      var thumbnailURL = widget.movieModel?.thumbnailURl;
      if (_thumbnailFile?.path != null) {
        // Delete previous image
        await deletefile(url: widget.movieModel?.thumbnailURl);
        // Upload New
        var docID = const Uuid().v4();
        thumbnailURL = await uploadfile(id: docID);
      }
      fireStore.collection('movies').doc(widget.movieModel?.id).update({
        "name": _nameEditController.text.toString(),
        "description": _descriptionEditController.text.toString(),
        "thumbnailURl": thumbnailURL,
        "year": _yearEditController.text.toString(),
        "category": _category,
        "language": _language,
        "director": _directorEditController.text.toString(),
        "actors": _actorsEditController.text.toString(),
        "downloadID": _fileDownloadIdController.text.toString(),
      }).then((value) {
        setState(() {
          _prcessing = false;
        });
        successMessage(message: 'Data updated successfully!');
      });
    } catch (e) {
      setState(() {
        _prcessing = false;
      });
      errorMessage(message: e.toString());
    }
  }

  void deleteData() async {
    try {
      // Delete previous image
      await deletefile(url: widget.movieModel?.thumbnailURl);

      fireStore
          .collection('movies')
          .doc(widget.movieModel?.id)
          .delete()
          .then((value) {
        // setState(() {
        //   _d_prcessing = false;
        // });
        Navigator.pop(context);
        successMessage(message: 'Data deleted successfully!');
      });
    } catch (e) {
      setState(() {
        _dprcessing = false;
      });
      errorMessage(message: e.toString());
    }
  }

  Future<String> uploadfile({String? id}) async {
    try {
      var refStore = await fireStorerage
          .ref('Thumbs')
          .child('mt_$id')
          .putFile(File(_thumbnailFile!.path!));
      var downloadURL = refStore.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      errorMessage(message: e.toString());
      return "";
    }
  }

  Future<void> deletefile({String? url}) async {
    try {
      await fireStorerage.refFromURL(url!).delete();
    } catch (e) {
      errorMessage(message: e.toString());
    }
  }

  void clearFileds() {
    _nameEditController.text = "";
    _descriptionEditController.text = "";
    _yearEditController.text = "";
    _directorEditController.text = "";
    _actorsEditController.text = "";
    _fileDownloadIdController.text = "";
    // _category = "";
    // _language = "";
    _thumbnailFile = null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _prcessing ? false : true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add a new movie',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            _prcessing
                ? const Progressor(
                    height: 25,
                    width: 25,
                    padding: EdgeInsets.only(right: 10.0),
                  )
                : IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          (_thumbnailFile?.path! != null ||
                              widget.movieModel?.thumbnailURl != null)) {
                        setState(() {
                          _prcessing = true;
                        });

                        if (widget.isUpdate) {
                          updateData();
                        } else {
                          saveData();
                        }
                      } else if (_thumbnailFile?.path == null) {
                        setState(() {
                          _isThumbnailFile = false;
                        });
                      } else {
                        setState(() {
                          _isThumbnailFile = true;
                        });
                      }
                    },
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
          child: Form(
            // autovalidateMode: AutovalidateMode.always,
            key: formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                InputField(
                    textEditingController: _nameEditController,
                    hintText: "Name of the Movie",
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name of the Movie';
                      }
                      return null;
                    }),
                InputField(
                    textEditingController: _fileDownloadIdController,
                    hintText: "Download ID",
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Download ID';
                      }
                      return null;
                    }),
                InputField(
                  textEditingController: _descriptionEditController,
                  hintText: "Description",
                  validatorFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                  maxLines: 5,
                ),
                InputField(
                    textEditingController: _yearEditController,
                    hintText: "Year",
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter year of the Movie';
                      }
                      return null;
                    }),
                SelectField(
                    currentItem: widget.isUpdate
                        ? "$_category - ${findCategoryValue(_category)}"
                        : null,
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
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a Category';
                      }
                      return null;
                    }),
                SelectField(
                    currentItem: widget.isUpdate
                        ? '$_language - ${findLanguageValue(_language)}'
                        : null,
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
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a Language';
                      }
                      return null;
                    }),
                InputField(
                    textEditingController: _directorEditController,
                    hintText: "Director",
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter director of the Movie';
                      }
                      return null;
                    }),
                InputField(
                    textEditingController: _actorsEditController,
                    hintText: "Actors",
                    maxLines: 5,
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter actors of the Movie';
                      }
                      return null;
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select File',
                        style: TextStyle(
                          color: isDark(context) ? greyColor3 : greyColor2,
                          fontSize: mf,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: FileCard(
                                  onSelect: selectThumbnail,
                                  name: 'Thumbnail',
                                  file: _thumbnailFile,
                                  fileUrl: widget.movieModel?.thumbnailURl,
                                  isImg: true,
                                ),
                              ),
                              // Flexible(
                              //   child: FileCard(
                              //     onSelect: selectMovieFile,
                              //     name: 'Movie File',
                              //     file: _movieFile,
                              //     fileUrl: widget.movieModel?.downloadID,
                              //     isImg: false,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      !_isThumbnailFile
                          ? const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Please select a Thumbnail Image',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 216, 14, 0),
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // _prcessing
                //     ? Padding(
                //         padding: const EdgeInsets.symmetric(vertical: 30.0),
                //         child: Text(
                //           'Data Processing...',
                //           style: TextStyle(
                //             fontSize: mf,
                //             color: mainColor,
                //           ),
                //           textAlign: TextAlign.center,
                //         ),
                //       )
                //     : const SizedBox.shrink(),
                widget.isUpdate
                    ? _prcessing
                        ? const SizedBox.shrink()
                        : _dprcessing
                            ? const Padding(
                                padding: EdgeInsets.only(
                                  top: 30.0,
                                ),
                                child: Progressor(),
                              )
                            : CustomButton(
                                icon: Icons.delete,
                                iconColor: Colors.white,
                                name: 'Delete',
                                onPressed: () {
                                  setState(() {
                                    _dprcessing = true;
                                  });
                                  deleteData();
                                },
                                bgcolor: Colors.red,
                                fontcolor: Colors.white,
                              )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
