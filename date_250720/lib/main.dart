import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
// import 'package:shared_preferences/shared_preferences.dart';

//1번 문제
class SettingsPage extends StatelessWidget {
  // TODO: 이 메서드만 구현하세요
  void handleBackButton(BuildContext context) {
    // 여기에 구현
    if (Navigator.of(context).canPop()) {
      print("뒤로가기 가능!");
      Navigator.of(context).pop();
    } else {
      print("뒤로가기 불가능!");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("뒤로갈 수 없습니다.")));
      throw Exception("뒤로갈 수 없습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(/* 이미 구현됨 */);
  }
}

// 2번 문제
class Number2 extends StatefulWidget {
  const Number2({super.key});

  @override
  State<Number2> createState() => _Number2State();
}

class _Number2State extends State<Number2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // TODO: 이 validator만 구현하세요
      validator: (value) {
        // 여기에 구현
        if (value == null || value.isEmpty) {
          return '이메일을 입력하세요';
        } else if (value.length < 5) {
          return '최소 5글자 이상 입력해주세요';
        } else if (value.length > 10) {
          return '최대 10글자 이하로 입력해주세요';
        } else if (!value.contains("@")) {
          return '올바른 이메일 형식이 아닙니다';
        } else {
          return null; // 유효한 경우 null 반환
        }
      },
    );
    ;
  }
}

//3번 문제
class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;
  bool isLoading = false;

  // TODO: 이 메서드만 구현하세요
  Future<void> incrementWithDelay() async {
    // 여기에 구현
    setState(() {
      isLoading = true;
    });
    print("카운터 증가 시작");
    Timer.periodic(Duration(seconds: 2), (Timer t) {
      counter++;
    });
    print("카운터 증가 완료");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw SizedBox();
  }
}

//4번 문제
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: 여기만 구현하세요 (ElevatedButton 사용)
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.blue, // 기본 색상은 파란색
      ),
      child: Text(text),
    );
  }
}

//5번 문제
class UserManager {
  List<Map<String, dynamic>> users = [
    {'name': '김철수', 'score': 85},
    {'name': '이영희', 'score': 92},
    {'name': '박민수', 'score': 78},
  ];

  // TODO: 이 메서드만 구현하세요
  List<String> getTopUserNames(int minScore) {
    // 여기에 구현 (where + map + toList 패턴)
    return users
        .where((user) => user["score"] >= minScore)
        .map((user) => user["name"] as String)
        .toList();
  }
}

//6번 문제
class DataService {
  BuildContext context;
  DataService(this.context);

  // TODO: 이 메서드만 구현하세요
  void showSuccessMessage(String message) {
    // 여기에 구현 (ScaffoldMessenger 사용)
    if (message.trim().isEmpty) {
      throw Exception("메시지가 비어있습니다.");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: Duration(seconds: 2)),
      );
    }
  }
}

//7번 문제
main() {
  double result = sqrt(8 * 18);
  print("result : $result");
}
