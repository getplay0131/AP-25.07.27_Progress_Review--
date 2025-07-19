import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();

  // Map<String, List<Message>> buildGroupedMessages() {
  //   Map<String, List<Message>> groupedMessages = {};
  //
  //   for (var msg in messageList) {
  //     String timeSection = getTimeSection(msg.timeStamp);
  //
  //     if (!groupedMessages.containsKey(timeSection)) {
  //       groupedMessages[timeSection] = msg;
  //     }
  //     groupedMessages[timeSection]!.add(msg);
  //   }
  //   return groupedMessages;
  // }
  //
  // // timestamp: 1672531200000 (milliseconds)
  // DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

  // List<Message> messages = [/* 메시지들 */];
  //
  // List<Widget> widgets = messages.map((message) {
  //   return MessageBubble(
  //     message: message.text,
  //     isUser: message.isUser,
  //     time: formatTimeStamp(message.timeStamp),
  //   );
  // }).toList();

  // Container(
  // padding: EdgeInsets.all(16),
  // decoration: BoxDecoration(
  // color: Colors.blue,
  // borderRadius: BorderRadius.circular(15),
  // ),
  // child: Text(timeSection),
  // )

  List<Widget> buildTimelineView(Map<String, List<Message>> groupedMessages) {
    List<Widget> timelineWidgets = [];

    groupedMessages.forEach((timeSection, messages) {
      // 시간대 헤더 추가
      timelineWidgets.add(Messages);

      // 메시지들을 위젯으로 변환하여 추가
      timelineWidgets.addAll(
        messages.map((msg) => groupedMessages[timeSection] = messages).toList(),
      );
    });

    return timelineWidgets;
  }
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    // Navigator.of(
    //   context,
    // ).push(MaterialPageRoute(builder: (context) => TestScreen()));

    // return ListView.builder(
    //   itemCount: messages.length,
    //   itemBuilder: (context, index) => MessageBubble(message: messages[index]),
    // )

    // 변환된 코드
    // Expanded(
    //   child: SingleChildScrollView(child: Column(children: [MessageBubble(message: messages[index]])),
    // );
    return Scaffold();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();

  void sendMessage() {
    String inputText = _textEditingController.text;

    if (inputText.trim().isNotEmpty) {
      setState(() {
        messageList.add(
          Message(
            text: inputText,
            isUser: true,
            timeStamp: DateTime.now(),
            success: true,
          ),
        );
        _textEditingController.text();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // 컨트롤러는 이미 초기화됨
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
