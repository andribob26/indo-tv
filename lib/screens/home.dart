import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tv_indonesia/controllers/home_controller.dart';
import 'package:tv_indonesia/screens/streaming.dart';
import 'package:tv_indonesia/screens/search.dart';

import '../models/chanel_model.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _homeC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: true,
              pinned: true,
              snap: true,
              elevation: 2.0,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text(
                  "Siaran Langsung",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                background: ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Colors.black])
                        .createShader(bounds);
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      'images/bgapp.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // actions: [
              //   IconButton(
              //     icon: const Icon(Icons.search),
              //     onPressed: () {
              //       Get.to(() => const Search(),
              //           transition: Transition.rightToLeft);
              //     },
              //   )
              // ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(15.0),
              // ignore: prefer_is_empty
              sliver: Obx(() => _homeC.listChanel.value.length > 0
                  ? SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15.0,
                              crossAxisSpacing: 15.0),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          List<ChanelModel> data = _homeC.listChanel.value;
                          return Material(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              // color: Colors.white,
                              child: InkWell(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                onTap: () {
                                  print(data[index].id);
                                  Get.to(
                                      () => Streaming(dataChanel: data[index]),
                                      transition: Transition.fadeIn);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Ink(
                                    // decoration: BoxDecoration(
                                    //   borderRadius:
                                    //       const BorderRadius.all(
                                    //     Radius.circular(15.0),
                                    //   ),
                                    //   image: DecorationImage(
                                    //     image: NetworkImage(_homeC
                                    //         .listChanel.value[index].logo
                                    //         .toString()),
                                    //     fit: BoxFit.contain,

                                    //   ),
                                    // ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            _homeC.listChanel.value[index].logo
                                                .toString(),
                                            fit: BoxFit.contain,
                                            filterQuality: FilterQuality.low,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress != null) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.red.shade900,
                                                  ),
                                                );
                                              } else {
                                                return child;
                                              }
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              print("error");
                                              return Center(
                                                child: Text(
                                                  _homeC.listChanel.value[index]
                                                      .name
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            _homeC.listChanel.value[index].name
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 8.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                        childCount: _homeC.listChanel.value.length,
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: SizedBox(
                      height: MediaQuery.of(context).size.height - 235,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.red.shade900,
                        ),
                      ),
                    ))),
            ),

            // Container(
            //   child: Text("ok"),
            // )
          ],
        ));
  }
}
