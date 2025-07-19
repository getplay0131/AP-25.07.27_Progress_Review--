import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  runApp(const MaterialApp(home: Scaffold()));
}

class test1 extends StatefulWidget {
  const test1({super.key});

  @override
  State<test1> createState() => _test1State();
}

// class _test1State extends State<test1> {
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onSubmitted: (value) {
//         // 여기에 코드 작성
//         setState(() {
//           todo.title = value;
//         });
//       },
//     );
//   }
// }

class test2 extends StatefulWidget {

  VoidCallback test;
  const test2({super.key});

  @override
  State<test2> createState() => _test2State();
}

class _test2State extends State<test2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:,
    );
  }

  TextField test7(List<Todo> todos) {
    TextEditingController controller = TextEditingController();
    var text = controller.text;
    // return TextField(
    //   controller: TextEditingController(),
    //   onSubmitted: (value) {
    //     if (text.isNotEmpty) {
    //       setState(() {
    //       todos.add(value);
    //       });
    //     }
    //   },
    // );
    return TextField(controller: controller,autofocus: true,
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
      decoration: InputDecoration(
        hintText: "새 할일",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Future<void> test2(int index, List<Todo> todos) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // 여기에 AlertDialog 구조 작성
        title: Text("할일 편집!"),
        content: TextField(
          autofocus: true,
          controller: TextEditingController(),
          decoration: InputDecoration(
            hintText: "이곳에 수정 내용을 입력해주세요!",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  // 여기에 취소 버튼 동작 작성
                  Navigator.pop(context);
                },
                child: Text("취소"),
              ),
              ElevatedButton(
                onPressed: () {
                  // 여기에 저장 버튼 동작 작성
                  widget.todos[widget.index].title = "수정된 내용"; // 예시로 수정
                  Navigator.pop(context);
                },
                child: Text("저장"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class test11 extends StatefulWidget {
  const test11({super.key});

  @override
  State<test11> createState() => _test11State();
}

class _test11State extends State<test11> {
  @override
  Widget build(BuildContext context) {
    return  OutlinedButton(onPressed: () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // 여기에 AlertDialog 구조 작성
          title: Text("할일 편집!"),
          content: TextField(
            autofocus: true,
            controller: TextEditingController(),
            decoration: InputDecoration(
              hintText: "이곳에 수정 내용을 입력해주세요!",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // 여기에 취소 버튼 동작 작성
                    Navigator.pop(context);
                  },
                  child: Text("취소"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 여기에 저장 버튼 동작 작성
                    widget.todos[widget.index].title = "수정된 내용"; // 예시로 수정
                    Navigator.pop(context);
                  },
                  child: Text("저장"),
                ),
              ],
            ),
          ],
        ),
      );
    }, child: Text("할일 제목!"));
  }
}



Future<void> test11(int index, List<Todo> todos) async {



}


class Todo {
  final String id;
  final String title;
  final String category;
  String priority;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    required this.isCompleted,
  });
}
