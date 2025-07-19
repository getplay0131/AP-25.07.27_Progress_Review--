import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
void main() {
  runApp(const MaterialApp(home: Scaffold(body: ,),));


}

class test1 extends StatefulWidget {


  const test1({super.key});

  @override
  State<test1> createState() => _test1State();
}

class _test1State extends State<test1> {

  final homeurl = Uri.parse("https://flutter.dev");
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(homeurl);


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyHomePage  extends StatefulWidget {
  const MyHomePage ({super.key});

  @override
  State<MyHomePage > createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage > {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('회사 소개'),
      actions: [
        IconButton(
          onPressed: () {
            // 홈페이지로 돌아가는 코드 작성
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.home),
        ),
      ],
    ),
    ;
  }
}

class _ProductPageState extends State<ProductPage> {
  Color heartColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // 여기에 코드 작성
        setState(() {
          heartColor = heartColor == Colors.grey ? Colors.red : Colors.grey;
        });
      },
      icon: Icon(Icons.favorite, color: heartColor),
    );
  }
}
