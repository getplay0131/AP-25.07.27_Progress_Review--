import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Timer? timer;
  // timer = Timer.periodic(Duration(seconds: 2), (timer) {
  // // 반복 실행할 코드
  // });
  PageController controller = PageController();

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return PageView(
    //   controller: controller.animateToPage(
    //       nextPage,
    //       duration: Duration(milliseconds: 500),
    //       curve: Curves.linear
    //   );

    );
  }
}
