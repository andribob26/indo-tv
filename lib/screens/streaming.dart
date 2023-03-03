import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tv_indonesia/controllers/streaming_controller.dart';
import 'package:tv_indonesia/models/chanel_model.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class Streaming extends StatefulWidget {
  ChanelModel dataChanel;

  Streaming({super.key, required this.dataChanel});

  @override
  State<Streaming> createState() => _StreamingState();
}

class _StreamingState extends State<Streaming> {
  final StreamingController _streamingC = Get.put(StreamingController());
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    print(widget.dataChanel.url);
    // TODO: implement initState
    _initializeVideoPlayer(widget.dataChanel.url);
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.hasError) {
        // _streamingC.isPlay.value = false;
        _streamingC.isPlay.value = true;
        print(_videoPlayerController.value.errorDescription);
      }
      if (_videoPlayerController.value.isInitialized) {
        _streamingC.isPlay.value = true;
      }
      if (_videoPlayerController.value.isBuffering) {}
    });

    super.initState();
  }

  // @override

  @override
  void dispose() {
    print("hapus");
    // TODO: implement dispose
    _streamingC.isPlay.value = false;
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer(String url) async {
    _videoPlayerController = VideoPlayerController.network(url.toString());
    await Future.wait([
      _videoPlayerController.initialize().then((value) {
        _videoPlayerController.play();
      })
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: Obx(() {
                if (_streamingC.isPlay.value) {
                  return Chewie(
                    controller: ChewieController(
                      videoPlayerController: _videoPlayerController,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      looping: true,
                      allowFullScreen: true,
                      isLive: true,
                      errorBuilder: (context, errorMessage) {
                        print(errorMessage);
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(100.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.warning,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  errorMessage.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                  // return Container(
                  //   child: Text("ok"),
                  // );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red.shade900,
                    ),
                  );
                }
              }),
              // child: Center(
              //   child: CircularProgressIndicator(
              //     color: Colors.red.shade900,
              //   ),
              // ),
            ),
          ),
          Container(height: 1.5, color: Colors.white),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: widget.dataChanel.logo.isNotEmpty
                        ? Ink(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.dataChanel.logo.toString()),
                                  fit: BoxFit.contain,
                                )),
                            height: 60,
                            width: 60,
                          )
                        : Container(
                            height: 60,
                            width: 60,
                            child: Center(
                              child: Text(
                                widget.dataChanel.name.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      widget.dataChanel.name.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _streamingC.sharePressed(context);
                  },
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.fromLTRB(15.0, 15.0, 7.5, 15.0),
          //         child: Material(
          //           borderRadius: const BorderRadius.all(
          //             Radius.circular(50),
          //           ),
          //           color: Colors.red.shade900,
          //           child: InkWell(
          //             borderRadius: const BorderRadius.all(
          //               Radius.circular(50),
          //             ),
          //             onTap: () {
          // _streamingC.sharePressed(context);
          //             },
          //             child: const SizedBox(
          //               height: 40.0,
          //               child: Center(
          //                 child: Text(
          //                   "Bagikan",
          //                   style: TextStyle(
          //                     fontSize: 16.0,
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.fromLTRB(7.5, 15.0, 15.0, 15.0),
          //         child: Material(
          //           borderRadius: const BorderRadius.all(
          //             Radius.circular(50),
          //           ),
          //           color: Colors.red.shade900,
          //           child: InkWell(
          //             borderRadius: const BorderRadius.all(
          //               Radius.circular(50),
          //             ),
          //             onTap: () {},
          //             child: const SizedBox(
          //               height: 40.0,
          //               child: Center(
          //                 child: Text(
          //                   "Laporkan siaran mati",
          //                   style: TextStyle(
          //                     fontSize: 16.0,
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
