import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  final String? url;
  const PlayerScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url!)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _videoPlayerController?.play());
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: _videoPlayerController != null &&
              _videoPlayerController!.value.isInitialized
          ? VideoPlayer(_videoPlayerController!)
          : const SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ),
    );
  }
}
