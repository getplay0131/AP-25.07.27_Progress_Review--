import 'package:flutter/material.dart';

void main() {}

class test extends StatelessWidget {
  const test({super.key});

  // Map<String, List<Message>> groupMessages() {
  //   Map<String, List<Message>> result = {};
  //
  //   for (var msg in messages) {
  //     String time = getTimeSection(msg.timestamp);
  //
  //     if (!result.containsKey(time)) {
  //       result[time] = [];
  //     }
  //     result[time].add(msg);
  //   }
  //   return result;
  // }

  // List<Widget> widgets = [];
  // grouped.forEach((timeSection, messages) {
  // widgets.add(timeSection); // 헤더 위젯 추가
  //
  // for (var msg in messages) {
  // widgets.add(MessageBubble(text: msg.text));
  // }
  // });

  List<Widget> widgets = [];
  // 이 방식은 widgets가 가리키는 객체 자체가 새 인스턴스로 바뀌기 때문에, 만약 이 리스트가 상태(StatefulWidget의 state 등)로 관리되는 값이라면, Flutter의 상태 관리 메커니즘이 변경 사항을 감지하지 못하거나, 위젯 트리에서 제대로 반영되지 않을 수 있습니다.
  // widgets = buildWidgetList(data);
  // widgets = widgets.clear(); // 비우고
  // widgets = widgets.addAll(buildWidgetList(data)); // 새로 추가

  Widget buildTimeline(List<Message> messages) {
    // 1단계: 그룹핑
    Map<String, List<Message>> grouped = {};

    // 2단계: 위젯 생성
    List<Widget> widgets = [];
    grouped.forEach((key, value) => MessageBubble[key] = value);

    // 3단계: 반환
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Container(child: Text("Hello Flutter"))),
    );
  }
}
