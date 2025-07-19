import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(const MaterialApp(home: Scaffold()));
}

Future<void> saveData() async {
  final pref = await SharedPreferences.getInstance();

  Map<String, dynamic> data = {"name": "홍길동", "age": 25};
  pref.setString("user_data", jsonEncode(data));

  String? jsonData = pref.getString("user_data");
  if (jsonData != null) {
    Map<String, dynamic> data = jsonDecode(jsonData);
  }
}

class test5 extends StatefulWidget {
  const test5({super.key});

  @override
  State<test5> createState() => _test5State();
}

class _test5State extends State<test5> {
  @override
  Widget build(BuildContext context) {
    if (Navigator.canPop(context)) {
      // 다른 로직 실행
      Navigator.pop(context);
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('메시지')));

    // return ListView.builder(itemBuilder: itemBuilder, itemCount: ,);
    return TextField(
      controller: controller,
      autofocus: true,
      onSubmitted: (value) {
        if (text.isNotEmpty) {
          setState(() {
            todos.add(Todo(
              id: DateTime.now().toString(),
              title: value,
              category: "일상",
              priority: "중",
              isCompleted: false,
            ));
          });
        }
      },
    )

  }

  Future<void> addAndSaveTodo(String title) async {
    final pref = await SharedPreferences.getInstance();

    List<Todo> todos = [];

    setState(() {
      todos.add(Todo(
        id: DateTime.now().toString(),
        title: title,
        category: "일상",
        priority: "중",
        isCompleted: false,
      ));
    });

    // SharedPreferences에 저장
    pref.setString("todos", jsonEncode(todos.last));

    // 사용자에게 피드백
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('할일이 저장되었습니다!'))
    );
  }

}

class Todo {
  final String id;
  final String title;
  final String category;
  String priority;
  bool isCompleted;

  const Todo({
    required this.id,
    required this.title,
    required this.category,
    this.priority,
    this.isCompleted,
  });
}
