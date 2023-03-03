import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class StreamingController extends GetxController {
  final isPlay = Rx<bool>(false);

  Future<void> sharePressed(context) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      "text",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
