import 'package:blog_hanan/elements/video_list.dart';
import 'package:flutter/material.dart';

import '../elements/VideoCopyList.dart';
import '../elements/drawer_class.dart';

class VideosCopy extends StatefulWidget {
  const VideosCopy({Key? key}) : super(key: key);

  @override
  State<VideosCopy> createState() => _VideosState();
}

class _VideosState extends State<VideosCopy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoCopyList(),
    );
  }
}




