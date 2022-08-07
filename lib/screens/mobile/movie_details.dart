import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/helper/help_functions.dart';
import 'package:moo/models/movie_model.dart';
import 'package:moo/screens/mobile/player_screen.dart';
import 'package:moo/services/message.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:moo/models/download_data_model.dart';
import 'package:moo/widgets/widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String index;
  final MovieModel? movie;
  const MovieDetailsScreen({Key? key, required this.index, required this.movie})
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
  double progress = 0;

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
          'https://uptobox.com/api/link?token=$token&file_code=${widget.movie?.downloadID ?? ""}');
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
                'https://uptobox.com/api/link?token=$token&file_code=${widget.movie?.downloadID ?? ""}&waitingToken=${downloadDataModel!.data!.waitingToken}');
            downloadDataModel =
                DownloadDataModel.fromJson(jsonDecode(newRes.data));
          },
        );
      }
    } catch (e) {
      errorMessage(message: e.toString());
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
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                placeholder: (context, url) => const SizedBox(
                  height: 200,
                  child: Progressor(),
                ),
                imageUrl: widget.movie?.thumbnailURl ?? "",
                width: double.infinity,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
              DetailCard(
                title: "Name of the movie",
                value: widget.movie?.name ?? "",
              ),
              DetailCard(
                title: "Year of the movie",
                value: widget.movie?.year ?? "",
              ),
              DetailCard(
                title: "Language",
                value: findLanguageValue(widget.movie?.language ?? ""),
              ),
              DetailCard(
                title: "Category",
                value: findCategoryValue(widget.movie?.category ?? ""),
              ),
              DetailCard(
                title: "Director",
                value: widget.movie?.director ?? "",
              ),
              DetailCard(
                title: "Actors",
                value: widget.movie?.actors ?? "",
              ),
              DetailCard(
                title: "About the movie",
                value: widget.movie?.description ?? "",
              ),
              !isEnableDownloadLink
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60.0),
                        child: Text(
                          "Please wait for \n${_count}s to\ndownload or watch the movie",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: lf,
                            color: greyColor2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : CustomButton(
                      name: 'Watch',
                      icon: Icons.movie,
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
                      ? Padding(
                          padding: const EdgeInsets.only(
                            bottom: 60,
                          ),
                          child: CustomButton(
                            icon: Icons.download,
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
                                  progress = 0;
                                  progressMsg = null;

                                  setState(() {
                                    isDownloading = true;
                                  });

                                  await dio.download(
                                    downloadDataModel!.data!.dlLink!,
                                    '${dir.path}/${widget.movie?.name!.trim()}',
                                    cancelToken: _cancelToken,
                                    onReceiveProgress: (rcv, total) {
                                      setState(() {
                                        progress = (rcv / total) * 100;
                                        progressMsg =
                                            'Downloading\n${progress.toStringAsFixed(2)}%\n${formatBytes(rcv, 2)} of ${formatBytes(total, 2)}';
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
                                        successMessage(
                                            message:
                                                "File downloaded successfully!");
                                      }
                                    });
                                  });
                                } else {
                                  errorMessage(
                                      message:
                                          "Download folder was not found!");
                                }
                              } catch (e) {
                                // errorMessage(message: e.toString());
                              }
                            },
                          ),
                        )
                      : const SizedBox.shrink()
                  : const SizedBox.shrink(),
              isDownloading
                  ? Padding(
                      padding: const EdgeInsets.only(
                        bottom: 60,
                      ),
                      child: Column(
                        children: [
                          CustomButton(
                            icon: Icons.cancel,
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
                              color: greyColor2,
                              height: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Progressor(
                            value: progress / 100,
                            isCircular: false,
                          )
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     bottom: 60,
              //   ),
              //   child: Center(
              //     child: Text(
              //       'Size of file\n 450MB',
              //       style: TextStyle(
              //         fontSize: mf,
              //         color: Colors.grey,
              //         decoration: TextDecoration.none,
              //       ),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
