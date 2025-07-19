import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyTodoScreen extends StatefulWidget {
  const MyTodoScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  void _saveToDo() {
    if (_formKey.currentState?.validate() == true) {
      // 검증 통과 시 실행할 코드
    }
  }

  @override
  State<MyTodoScreen> createState() => _MyTodoScreenState();
}

class _MyTodoScreenState extends State<MyTodoScreen> {
  @override
  Widget build(BuildContext context) {
    Navigator.of(context).pop(todo);
    // return ListView.builder(
    //   itemBuilder: (BuildContext context, int idx) {
    //     Todo todo = todos[idx];
    //     return Card(child: Text(todo.title));
    //   },
    //   itemCount: todos.length,
    // );
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return AddTodoScreen();
            },
          ),
        );
        if (result != null) {
          setState(() {
            todos.add(result);
          });
        }
      },
      child: Icon(Icons.add),
    );
  }
}
