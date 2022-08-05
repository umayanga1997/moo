import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class PlayerScreen extends StatefulWidget {
  final String? url;
  const PlayerScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late VideoPlayerController? _videoPlayerController;

  bool isButtons = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url!)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _videoPlayerController?.play());
  }

  String getCurrentPosition() {
    try {
      final duration = Duration(
          milliseconds:
              _videoPlayerController!.value.position.inMilliseconds.round());

      return [duration.inHours, duration.inMinutes, duration.inSeconds]
          .map((e) => e.remainder(60).toString().padLeft(2, '0'))
          .join(':');
    } catch (e) {
      return "";
    }
  }

  Future setLandscape() async {
    try {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: []);
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      Wakelock.enable();
    } catch (e) {
      //
    }
  }

  Future setOrientation() async {
    try {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      Wakelock.disable();
    } catch (e) {
      //
    }
  }

  @override
  void dispose() {
    super.dispose();
    setOrientation();
    _videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _videoPlayerController != null &&
              _videoPlayerController!.value.isInitialized
          ? Container(
              color: Colors.white,
              child: OrientationBuilder(builder: (context, orientation) {
                final isPortrait = orientation == Orientation.portrait;
                return GestureDetector(
                  onTap: () {
                    try {
                      setState(() {
                        isButtons = !isButtons;
                      });
                      if (isButtons) {
                        Future.delayed(
                          const Duration(seconds: 5),
                          () {
                            setState(() {
                              isButtons = false;
                            });
                          },
                        );
                      }
                    } catch (e) {
                      //
                    }
                  },
                  child: Stack(
                    fit: isPortrait ? StackFit.loose : StackFit.expand,
                    alignment: Alignment.topCenter,
                    children: [
                      Stack(
                        fit: isPortrait ? StackFit.loose : StackFit.expand,
                        alignment: Alignment.topCenter,
                        children: [
                          AspectRatio(
                            aspectRatio:
                                _videoPlayerController!.value.aspectRatio,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: _videoPlayerController!.value.size.width,
                                height:
                                    _videoPlayerController!.value.size.height,
                                child: VideoPlayer(_videoPlayerController!),
                              ),
                            ),
                          ),
                          isButtons
                              ? Positioned(
                                  bottom: 20,
                                  left: 10,
                                  right: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: fcolorGrey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getCurrentPosition(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontSize: mf,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  try {
                                                    _videoPlayerController!
                                                            .value.isPlaying
                                                        ? _videoPlayerController!
                                                            .pause()
                                                        : _videoPlayerController!
                                                            .play();
                                                  } catch (e) {
                                                    //
                                                  }
                                                },
                                                child: Icon(
                                                  _videoPlayerController!
                                                          .value.isPlaying
                                                      ? Icons.stop_circle
                                                      : Icons.play_arrow,
                                                  size: 32,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: VideoProgressIndicator(
                                                    _videoPlayerController!,
                                                    allowScrubbing: true,
                                                    colors: VideoProgressColors(
                                                      playedColor: mainColor,
                                                      backgroundColor:
                                                          Colors.white,
                                                      bufferedColor:
                                                          indicolorGrey,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  isPortrait
                                                      ? setLandscape()
                                                      : setOrientation();
                                                },
                                                child: const Icon(
                                                  Icons.fullscreen,
                                                  size: 32,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ],
                  ),
                );
              }),
            )
          : Container(
              color: Colors.white,
              child: const Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
    );
  }
}
