import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tv_indonesia/screens/home.dart';

class Splass extends StatefulWidget {
  const Splass({super.key});

  @override
  State<Splass> createState() => _SplassState();
}

class _SplassState extends State<Splass> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAll(()=>Home(), duration: const Duration(milliseconds: 300), transition: Transition.fade);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              width: 150.0,
              image: AssetImage("images/logo.png"),
            ),
          ],
        ),
      ),
    );
  }
}
