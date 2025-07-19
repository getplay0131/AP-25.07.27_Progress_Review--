import 'package:flutter/material.dart';

void main() {
  List<Color> colors = [Colors.red, Colors.green, Colors.blue];

  runApp(
    MaterialApp(
      home: Scaffold(
        // body: Padding(
        //   padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     // children: [
        //     //   Flexible(
        //     //     fit: FlexFit.loose,
        //     //     child: Container(color: Colors.red),
        //     //   ),
        //     //   // Container(width: 50, height: 50, color: Colors.red),
        //     //   // Container(width: 50, height: 50, color: Colors.green),
        //     //   // Container(width: 50, height: 50, color: Colors.blue),
        //     //   Expanded(flex: 2, child: Container(color: Colors.blue)),
        //     // ],
        //     // 나쁜 예
        //     // children: [
        //     //   Container(width: 50, height: 50, color: Colors.red),
        //     //   Container(width: 50, height: 50, color: Colors.green),
        //     //   Container(width: 50, height: 50, color: Colors.blue),
        //     // ]
        //
        //     // 좋은 예로 변경
        //     // children: colors
        //     //     .map((color) => Container(width: 50, height: 50, color: color))
        //     //     .toList(),
        //   ),
        // ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 50),
                SizedBox(height: 16),
                Text("사용자 이름", style: TextStyle(fontSize: 20)),
                Text("안녕하세요! 플러터 개발자입니다."),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// class test extends StatefulWidget {
//   const test({super.key});
//
//   @override
//   State<test> createState() => _testState();
// }
//
// class _testState extends State<test> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
//
//   void generateRandomNumbers() {
//     setState(() {
//       numbers = uniqueNumbers.toList();
//     });
//   }
// }

// class _Footer extends StatelessWidget {
//   VoidCallback onPressed; // 콜백 함수 타입
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed, // 콜백 함수 호출
//       child: Text("숫자 생성"),
//     );
//   }
// }
