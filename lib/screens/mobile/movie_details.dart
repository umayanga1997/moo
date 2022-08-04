import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/models/movie_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:moo/models/download_data_model.dart';
import 'package:moo/widgets/widget.dart';
// import 'package:video_player/video_player.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String image;
  final String index;
  final MovieModel movie;
  const MovieDetailsScreen(
      {Key? key, required this.image, required this.index, required this.movie})
      : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  // late VideoPlayerController? _videoPlayerController;
  @override
  void initState() {
    super.initState();
    // _videoPlayerController = VideoPlayerController.network(
    //     "https://drive.google.com/file/d/19U4LjSZT6WEZ4HVitt5frZXQLhVHNmci/preview")
    //   ..addListener(() => setState(() {}))
    //   ..setLooping(true)
    //   ..initialize().then((value) => _videoPlayerController?.play());
  }

  @override
  void dispose() {
    super.dispose();
    // _videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.index,
      // transitionOnUserGestures: true,
      // flightShuttleBuilder: (flightContext, animation, flightDirection,
      //     fromHeroContext, toHeroContext) {
      //   return Transform(
      //     transform: Matrix4.identity()..rotateX(-pi * animation.value),
      //     alignment: FractionalOffset.center,
      //     child: fromHeroContext.widget,
      //   );
      // },
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/${widget.image}",
                width: double.infinity,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
              // _videoPlayerController != null &&
              //         _videoPlayerController!.value.isInitialized
              //     ? VideoPlayer(_videoPlayerController!)
              //     : const CircularProgressIndicator(),
              const DetailCard(
                title: "Name of the movie",
                value: 'Chello Chello',
              ),
              const DetailCard(
                title: "Year of the movie",
                value: '2018',
              ),
              const DetailCard(
                title: "Language",
                value: 'English',
              ),
              const DetailCard(
                title: "Category",
                value: 'Horror',
              ),
              const DetailCard(
                title: "Director",
                value: 'Mr.Rahul',
              ),
              const DetailCard(
                title: "Actors",
                value: 'Srinath, pallawi, gowind',
              ),
              const DetailCard(
                title: "About the movie",
                value:
                    'This movie is very romance movie that giving the truth of message for our life.',
              ),
              CustomButton(
                name: 'Download',
                onPressed: () async {
                  var dio = Dio();
                  String token = "f5e2b7a7c14adfbb2dff95241e44d4699a9vp";
                  final response = await dio.get(
                      'https://uptobox.com/api/link?token=$token&file_code=${widget.movie.downloadID}');

                  Directory dir = Directory('/storage/emulated/0/Download');
                  var status = await Permission.storage.status;
                  if (status.isDenied) {
                    Permission.storage.request();
                  }
                  if (dir.path != "") {
                    var datamodel =
                        DownloadDataModel.fromJson(jsonDecode(response.data));

                    final taskId = await FlutterDownloader.enqueue(
                      url: datamodel.data!.dlLink!,
                      savedDir: dir.path,
                      fileName: widget.movie.movieDownloadName,
                      showNotification:
                          true, // show download progress in status bar (for Android)
                      openFileFromNotification:
                          true, // click on notification to open downloaded file (for Android)
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Download folder was not found!"),
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 60,
                ),
                child: Center(
                  child: Text(
                    'Size of file\n 450MB',
                    style: TextStyle(
                      fontSize: mf,
                      color: Colors.grey,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
