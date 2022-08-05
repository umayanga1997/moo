import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/helper/help_functions.dart';
import 'package:moo/models/movie_model.dart';
import 'package:moo/screens/mobile/player_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:moo/models/download_data_model.dart';
import 'package:moo/widgets/widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String image;
  final String index;
  final MovieModel? movie;
  const MovieDetailsScreen(
      {Key? key, required this.image, required this.index, required this.movie})
      : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  DownloadDataModel? downloadDataModel;
  Timer? _timer;
  late Dio dio;
  int _count = 30;
  String? progressMsg;
  bool isEnableDownloadLink = false;
  bool isDownloading = false;
  CancelToken? _cancelToken;

  @override
  void initState() {
    super.initState();
    generateDownloadURl();
  }

  generateDownloadURl() async {
    try {
      dio = Dio();
      String token = "f5e2b7a7c14adfbb2dff95241e44d4699a9vp";
      final downloadURLRespose = await dio.get(
          'https://uptobox.com/api/link?token=$token&file_code=${'d3j5br62buy6'}');
      downloadDataModel =
          DownloadDataModel.fromJson(jsonDecode(downloadURLRespose.data));
      setState(() {
        isEnableDownloadLink = false;
      });
      countSecounds();
      if (downloadDataModel!.statusCode == 16) {
        Future.delayed(
          const Duration(seconds: 30),
          () async {
            final newRes = await dio.get(
                'https://uptobox.com/api/link?token=$token&file_code=${'d3j5br62buy6'}&waitingToken=${downloadDataModel!.data!.waitingToken}');
            downloadDataModel =
                DownloadDataModel.fromJson(jsonDecode(newRes.data));
          },
        );
      }
    } catch (e) {
      //
    }
  }

  void countSecounds() {
    try {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (_count == 0) {
            setState(() {
              isEnableDownloadLink = true;
              _timer?.cancel();
            });
          } else {
            setState(() {
              _count--;
            });
          }
        },
      );
    } catch (e) {
      //
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _cancelToken?.cancel();
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
              !isEnableDownloadLink
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "Please wait for \n${_count}s to\ndownload or watch the movie",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: lf,
                            color: blColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : CustomButton(
                      name: 'Watch',
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerScreen(
                                url: downloadDataModel!.data!.dlLink),
                          ),
                        );
                      },
                    ),
              isEnableDownloadLink
                  ? !isDownloading
                      ? CustomButton(
                          name: 'Download',
                          onPressed: () async {
                            try {
                              Directory dir =
                                  Directory('/storage/emulated/0/Download');
                              var status = await Permission.storage.status;
                              if (status.isDenied) {
                                Permission.storage.request();
                              }
                              if (dir.path != "") {
                                dio = Dio();
                                _cancelToken = CancelToken();
                                double progress = 0;
                                String msg;

                                setState(() {
                                  isDownloading = true;
                                });

                                await dio.download(
                                  downloadDataModel!.data!.dlLink!,
                                  '${dir.path}/${widget.movie?.movieDownloadName}',
                                  cancelToken: _cancelToken,
                                  onReceiveProgress: (rcv, total) {
                                    msg =
                                        'received: ${formatBytes(rcv, 2)} out of total: ${formatBytes(total, 2)}';

                                    setState(() {
                                      progress = (rcv / total) * 100;
                                      progressMsg =
                                          "${progress.toStringAsFixed(0)}%\n$msg";
                                    });

                                    if (progress == 100) {
                                      setState(() {
                                        isDownloading = false;
                                      });
                                    } else if (progress < 100) {}
                                  },
                                  deleteOnError: true,
                                ).then((_) {
                                  setState(() {
                                    if (progress == 100) {
                                      isDownloading = false;
                                    }
                                  });
                                });
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Download folder was not found!"),
                                  ),
                                );
                              }
                            } catch (e) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content: Text(e.toString()),
                              //   ),
                              // );
                            }
                          },
                        )
                      : const SizedBox.shrink()
                  : const SizedBox.shrink(),
              isDownloading
                  ? Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Column(
                        children: [
                          CustomButton(
                            name: 'Cancle',
                            onPressed: () {
                              try {
                                _cancelToken?.cancel();
                                setState(() {
                                  isDownloading = false;
                                });
                              } catch (e) {
                                //
                              }
                            },
                          ),
                          Text(
                            progressMsg ?? "",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: mf,
                              color: fcolorGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
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
