import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  // runApp(const MyApp());
}

//### **1. 카운터 상태 업데이트 - setState 메서드만 구현**
// **상황**: 버튼을 누를 때마다 카운터가 증가하는 앱을 만들고 있습니다.
// **구현 범위**: onPressed 콜백 내부의 setState 부분만 작성
// **제약조건**: counter 변수는 이미 선언되어 있음

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // TODO: 이 부분만 구현하세요 (3-4줄 예상)
        setState(() {
          counter++;
        });
        print('카운트가 증가했습니다: $counter');
      },
      child: Text('카운트: $counter'),
    );
  }
}

//### **2. Todo 완료 상태 토글 - createState 메서드 구현**
// **상황**: Todo 항목의 완료/미완료 상태를 토글하는 위젯을 만듭니다.
// **구현 범위**: createState 메서드만 구현
// **제약조건**: 학습 자료의 CompletedToggle 패턴 활용

class Todo {
  final String id;
  final String title;
  bool isCompleted;

  Todo({required this.id, required this.title, this.isCompleted = false});
}

class CompletedToggle extends StatefulWidget {
  final Todo todo;
  final VoidCallback onToggle;

  CompletedToggle({Key? key, required this.todo, required this.onToggle})
    : super(key: key);

  // TODO: 이 메서드만 구현하세요 (1줄)
  @override
  _CompletedToggleState createState() => _CompletedToggleState();
}

class _CompletedToggleState extends State<CompletedToggle> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.todo.isCompleted,
      onChanged: (value) {
        setState(() {
          widget.todo.isCompleted = value ?? false;
        });
        widget.onToggle();
      },
    );
  }
}

//### **3. 동적 리스트 구현 - itemBuilder 콜백 구현**
// **상황**: Todo 리스트를 동적으로 표시하는 ListView.builder를 만듭니다.
// **구현 범위**: itemBuilder 콜백 함수 내부만 구현
// **제약조건**: todos 리스트가 이미 제공됨

// **구현해야 할 기능**:
// - 각 Todo 항목을 Card 위젯으로 감싸기
// - 제목과 완료 상태를 Text로 표시
// - 완료된 항목은 취소선 스타일 적용

class TodoListScreen extends StatelessWidget {
  final List<Todo> todos = [
    Todo(id: "1", title: "Flutter 공부", isCompleted: false),
    Todo(id: "2", title: "앱 개발", isCompleted: true),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final todo = todos[index];
        return Card(
          child: ListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(todo.isCompleted ? '완료됨' : '미완료'),
          ),
        );
      },
    );
  }
}

//### **4. 편집 다이얼로그 - showDialog 구현**
// **상황**: Todo 항목을 편집할 수 있는 다이얼로그를 표시합니다.
// **구현 범위**: _showEditDialog 메서드 내부만 구현
// **제약조건**: 학습 자료의 Dialog 패턴 활용

class TodoEditWidget extends StatefulWidget {
  final Todo todo;
  const TodoEditWidget({super.key, required this.todo});

  @override
  State<TodoEditWidget> createState() => _TodoEditWidgetState();
}

class _TodoEditWidgetState extends State<TodoEditWidget> {
  Todo get todo => widget.todo;

  void _showEditDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = todo.title;

    // TODO: 이 부분만 구현하세요 (8-12줄 예상)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Todo 편집'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: '할 일을 입력하세요'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todo.title = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('저장'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => _showEditDialog(context),
      ),
    );
  }
}

// ### **5. WebView 설정 - WebViewController 초기화**
// **상황**: 앱 내에서 웹페이지를 표시하는 WebView를 구현합니다.
// **구현 범위**: _initializeController 메서드 내부만 구현
// **제약조건**: 학습 자료의 WebView 패턴 활용

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;

  void _initializeController() {
    // TODO: 이 부분만 구현하세요 (4-6줄 예상)
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;

  void _initializeController() {
    // TODO: 이 부분만 구현하세요 (4-6줄 예상)
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}

class TodoItemWidget extends StatelessWidget {
  final Todo todo;

  TodoItemWidget({required this.todo});

  void _navigateToDetail(BuildContext context) {
    // TODO: 이 부분만 구현하세요 (4-6줄 예상)
    Navigator.of(context).pushNamed("todoDetail", arguments: todo);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      onTap: () => _navigateToDetail(context),
    );
  }
}
