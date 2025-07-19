import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  // runApp(MaterialApp(home: Scaffold(body: ,),))
}

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  final WebViewController controller = WebViewController()
    ..loadRequest(Uri.parse("https://company.com"));

  @override
  Widget build(BuildContext context) {
    controller.loadRequest(Uri.parse("https://company.com"));
    return const Placeholder();
  }

  void moveToPage() {
    IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        );
      },
      icon: Icon(Icons.home),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
