import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const test1());
}

class test1 extends StatelessWidget {
  const test1({super.key});

  @override
  Widget build(BuildContext context) {
    void test2() {
      Navigator.of(context).pushNamed(
        "/profilescreen",
        arguments: {
          "profileData": {
            "profileId": "user123",
            "profileName": "홍길동",
            "profileAge": 25,
          },
        },
      );
    }

    void navigateToSettings() {
      Navigator.of(context).pushNamed( // 루트 네임을 통해 이동
        "/settingsScreen",
        arguments: { // 전달할 아규먼트
          "userSettings": { // 키값
            "theme": isDarkMode ? "dark" : "light", // 테마와 값
            "notifications": isNotificationEnabled, // 알림과 값
            "autoSave": isAutoSaveEnabled, // 자동 저장과 값
          },
          "onSettingsChanged": (Map<String, dynamic> newSettings) {
            setState(() {
              // 설정 업데이트 로직 작성
              isDarkMode = newSettings['theme'] == "dark",
              isNotificationEnabled = newSettings['notifications'] ?? false,
              isAutoSaveEnabled = newSettings['autoSave'] ?? false
            });
          },
          "todos": currentTodos,
        },
      );
    }


    // void test3(){
    //   final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    //   final profileData = arguments?['profileData'] ?? {};
    //   final profileName = profileData['profileName'] ?? "기본 이름";
    //   final profileAge = profileData['profileAge'] ?? 0;
    // }
    //
    // void _saveTodo() {
    //   var todo = Todo(
    //     id: "todo123",
    //     title: "새 할일",
    //     category: "업무",
    //     isCompleted: false,
    //   );
    //   // 이전 화면으로 todo 반환하는 코드 작성
    //   Navigator.of(context).pop(todo);
    // }

    // Map<String, List<Message>> buildGroupedMessages() {
    //   Map<String, List<Message>> grouped = {};
    //   for (var msg in messageList) {
    //     String timeSection = getTimeSection(msg.timeStamp);
    //
    //     if (!grouped.containsKey(timeSection)) {
    //       grouped[timeSection] = [];
    //     }
    //     grouped[timeSection]!.add(msg);
    //   }
    //   return grouped;
    // }
    //
    // List<Widget> buildTimelineView(Map<String, List<Message>> grouped) {
    //   List<Widget> widgets = [];
    //
    //   grouped.forEach((timeSection, messages) {
    //     // 헤더 추가
    //     widgets.add(TimeSectionHeader(timeSection, messages.length));
    //
    //     // 메시지들을 위젯으로 변환하여 추가
    //     widgets.addAll(messages.map((message) =>
    //         MessageBubble(message: message.text)
    //     ).toList());
    //   });
    //
    //   return widgets;
    // }

    // void test7(){
    //   // messages를 MessageBubble 위젯 리스트로 변환
    //   List<Widget> messageWidgets = messages
    //   .map((message) => MessageBubble(
    //     message: message.text,
    //     isUser: message.isUser,
    //     time: formatTimeStamp(message.timeStamp),
    //   )).toList();
    // }

    void test8() {
      for (int i = 0; i < messages.length; i++) {
        String timeToShow =
            (i == 0 || formatTime(messages[i]) != formatTime(messages[i - 1]))
            ? formatTime(messages[i])
            : "";
      }
    }

    return MaterialApp(
      home: DashBoardScreen(),
      routes: {
        "/todoListScreen": (context) {
          final arguments =
              ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>?;
          return TodoListScreen(
            todos: arguments?['todos'] ?? [],
            onAddedToDo: arguments?['onAddedToDo'] ?? (todo) {},
          );
        },
      },
    );
  }

  //   void showDatePicker() {
  //     showCupertinoDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (context) => Align(
  //         alignment: Alignment.center,
  //         child: Container(
  //           height: 300,
  //           child: CupertinoDatePicker(
  //             mode: CupertinoDatePickerMode.date,
  //             onDateTimeChanged: (date) => setState(() => selectedDate = date),
  //             initialDateTime: DateTime.now(),
  //             maximumDate: DateTime.now(),
  //           ),
  //         ),
  //       ),
  //     );
  //   }

  Future<void> addMessageAndSave(Message newMessage) async {
    // 1. 메시지 리스트에 추가
    setState(() {
      messageList.add(newMessage);
    });

    // 2. SharedPreferences에 저장
    final pref = await SharedPreferences.getInstance();
    final messageData = messageList
        .map(
          (msg) => {
            'text': msg.text,
            'timeStamp': msg.timeStamp.toIso8601String(), // ISO 8601 형식으로 변환
            'isUser': msg.isUser,
          },
        )
        .toList();

    await pref.setString('messages', jsonEncode(messageData));

    // 3. UI 업데이트를 위한 그룹핑
    final grouped = ();
    // UI 업데이트 로직...
  }




}

class _MyAppState extends State<MyApp> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // 반복 실행할 코드
    });
  }

  @override
  void dispose() {
    // 메모리 누수 방지 코드 작성
    timer?.cancel();
    super.dispose();
  }
}
