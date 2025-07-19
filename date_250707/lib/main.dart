import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: rowtest()));
  // List<String> items = ['Apple', 'Banana', 'Cherry'];
  // List<Widget> widgets = [];
  //
  // // forEach를 사용해서 Text 위젯으로 변환하는 코드 완성
  // items.forEach((item) {
  //   widgets.add(Text(item));
  // });
  List<String> messages = ['Hello', 'World'];
  List<Widget> widgets = messages.map((item) => Text(item)).toList();
}

class rowtest extends StatelessWidget {
  const rowtest({super.key});

  @override
  Widget build(BuildContext context) {
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [Text('A'), Text('B'), Text('C')],
    // )
    // ;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          child: Text(
            "test",
            style: TextStyle(color: Color(0xFF000000), fontSize: 20),
          ),
        ),
      ],
    );
  }
}

class ScoreHistogram extends StatelessWidget {
  final Map<String, int> scoreData = {"90-100": 12, "80-89": 18, "70-79": 15};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: scoreData.entries.map((entry) {
        return Container(
          color: Colors.blue[200],
          child: Row(
            children: [Text('${entry.key}: '), Text('${entry.value}명')],
          ),
        );
      }).toList(),
    );
  }
}
