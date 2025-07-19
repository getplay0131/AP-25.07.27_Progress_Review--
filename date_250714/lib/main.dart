import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {}

//1번 문제
class _ThemeAwareWidgetState extends State<ThemeAwareWidget> {
  Color? _currentColor;

  @override
  void didChangeDependencies() {
    // TODO: 이 메서드만 구현하세요
    super.didChangeDependencies();
    setState(() {
      _currentColor = Theme.of(context).primaryColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: _currentColor, child: Text('테마 인식 위젯'));
  }
}

//2번 문제
class UserService {
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    // TODO: 이 메서드만 구현하세요
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(userData);
    await prefs.setString('userData', jsonString);
    print('User data saved: $userData');
  }
}

//3번 문제
class UserService {
  Future<Map<String, dynamic>> loadUserData() async {
    // TODO: 이 메서드만 구현하세요
    final prefs = await SharedPreferences.getInstance();
    var string = prefs.getString("user-data");
    if (string != null) {
      var jsonDecode2 = jsonDecode(string ?? "{}");
      print('User data loaded: $jsonDecode2');
      return jsonDecode2;
    }
    print('No user data found');
    return {};
  }
}

//4번 문제
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // TODO: 이 부분만 구현하세요
          Container(height: 60, color: Colors.blue, child: Text("헤더!")),
          Expanded(child: ListView()),
          ElevatedButton(onPressed: null, child: Text("저장!")),
        ],
      ),
    );
  }
}

//5번 문제
class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool _hasChanges = true;

  Future<void> _handleExit() async {
    // TODO: 이 메서드만 구현하세요
    if (Navigator.canPop(context) && _hasChanges) {
      bool? shouldExit = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('변경사항이 있습니다'),
            content: Text('저장하지 않고 나가시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('아니요'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('네'),
              ),
            ],
          );
        },
      );

      if (shouldExit == true) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _handleExit,
        ),
      ),
    );
  }
}

//6번 문제
class FileUploadService {
  void showProgressSnackBar(BuildContext context, String message) {
    // TODO: 이 메서드만 구현하세요
    // **구현해야 할 기능**:
    // - ScaffoldMessenger로 SnackBar 표시
    // - Row로 CircularProgressIndicator + SizedBox(width: 16) + Text 배치
    // - action으로 '취소' 버튼 추가
    // - duration은 10초로 설정
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text("로딩 중!"),
          ],
        ),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: '취소',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> uploadFile() async {
    showProgressSnackBar(context, "파일 업로드 중...");
    // 업로드 로직...
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
