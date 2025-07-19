import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class SettingsManager {
  static const String _themeKey = 'theme_settings';

  // TODO: 이 메서드만 구현하세요 (5-8줄 예상)
  Future<void> saveThemeSetting(bool isDarkMode) async {
    // 여기에 핵심 저장 로직 구현
    try {
      var sharedPreferences = await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 가져오기
      Map<String, bool> data = {"darkMode": isDarkMode}; // 다크 모드 설정을 저장할 Map 생성
      var jsonEncode2 = jsonEncode(data); // Map을 JSON 문자열로 인코딩
      sharedPreferences.setString(_themeKey, jsonEncode2); // JSON 문자열을 SharedPreferences에 저장
    } catch (e) {
      print("오류 발생! : $e");
    }
  }
}

class TodoRepository {
  static const String _todosKey = 'saved_todos';

  // TODO: 이 메서드만 구현하세요 (6-10줄 예상)
  Future<List<Map<String, dynamic>>> loadTodos() async {
    // 여기에 핵심 로딩 로직 구현
    var sharedPreferences = await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 가져오기
    List<Map<String, dynamic>> todos = []; // 할일 목록을 저장할 리스트 초기화
    var string = sharedPreferences.getString(_todosKey); // 저장된 할일 목록 문자열 가져오기
    Map<String, dynamic> result = jsonDecode(string ?? '{}'); // JSON 문자열을 Map으로 디코딩
    if (result.isNotEmpty) { // 디코딩된 결과가 비어 있지 않은 경우
      todos.add(result);  // 디코딩된 Map을 리스트에 추가
      return todos; // 할일 목록 반환
    } else {
      return [];
    }
  }
}

class TodoScreen extends StatefulWidget {
  // ... 기존 코드
}

class _TodoScreenState extends State<TodoScreen> {
  List<Map<String, dynamic>> todos = [];

  // TODO: 이 메서드만 구현하세요 (8-12줄 예상)
  Future<void> toggleTodoStatus(int index) async {
    // 여기에 상태 토글 + 저장 로직 구현
    final todo = todos[index];
    setState(() {
      todo['isCompleted'] = !todo['isCompleted'];
    });
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final jsonEncode2 = jsonEncode(todos);
      sharedPreferences.setString("todoKey", jsonEncode2);
    } catch (e) {
      print("오류 발생! : $e");
    }
    print("Todo 상태가 변경되었습니다: ${todo['title']} - 완료 여부: ${todo['isCompleted']}");
  }
}

class TodoInputWidget extends StatefulWidget {
  // ... 기존 코드
}

class _TodoInputWidgetState extends State<TodoInputWidget> {
  TextEditingController controller = TextEditingController();

  // TODO: 이 메서드만 구현하세요 (6-10줄 예상)
  void validateAndShowFeedback(String input) {
    // 여기에 입력 검증 + 피드백 로직 구현
    if (input.trim().isEmpty) { // 입력이 비어 있는지 확인
      print("입력이 비어 있습니다. 다시 시도하세요.");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("입력이 비어 있습니다. 다시 시도하세요.",style: TextStyle(backgroundColor: Colors.red),)));
    }

    if (input.length > 50) {
      print("입력이 너무 깁니다. 50자 이하로 입력하세요.");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("입력이 너무 깁니다. 50자 이하로 입력하세요.",style: TextStyle(backgroundColor: Colors.red)));
    } else {
      setState(() {
        // 입력이 유효할 때의 로직
        print("유효한 입력: $input");
        widget.todos["title"] = input;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("유효한 입력: $input",style: TextStyle(backgroundColor: Colors.green))));
    }
    controller.clear();
  }
}

// ### **5. 동적 리스트 렌더링 - ListView.builder 최적화**
// **상황**: 할일 목록을 효율적으로 표시하고 완료된 항목은 다른 스타일로 구분
// **구임 범위**: buildTodoItem 메서드의 핵심 로직만 구현
// **제약조건**: 완료 상태에 따른 조건부 스타일링, 체크박스 상호작용
class TodoListView extends StatelessWidget {
  final List<Map<String, dynamic>> todos;
  final Function(int) onToggle;

  TodoListView({required this.todos, required this.onToggle});

  // TODO: 이 메서드만 구현하세요 (8-12줄 예상)
  Widget buildTodoItem(int index) {
    // 여기에 개별 Todo 항목 위젯 구현
    final todo = todos[index];
    return ListTile( // ListTile 위젯을 사용하여 Todo 항목을 표시
      title: Text(
        todo['title'],
        style: TextStyle(
          decoration: todo['isCompleted'] ? TextDecoration.lineThrough : null,
          color: todo['isCompleted'] ? Colors.grey : Colors.black,
        ),
      ),
      leading: Checkbox( // 리스트 타일에 왼쪽 끝에 체크박스 추가
        value: todo['isCompleted'], // 체크박스의 상태를 Todo의 완료 여부로 설정
        onChanged: (value) {
          onToggle(index);
        },
      ),
      trailing: IconButton( // 리스트 타일에 오른쪽 끝에 요소 추가
        icon: Icon(Icons.delete),
        onPressed: () {
          // 삭제 로직 구현
          todos.removeAt(index); // 해당 인덱스의 Todo 삭제
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => buildTodoItem(index),
    );
  }
}

// ### **6. 안전한 네비게이션 - 뒤로가기 확인 시스템**
// **상황**: 중요한 화면에서 뒤로가기 시 사용자에게 확인을 받는 안전장치
// **구현 범위**: showExitConfirmation 메서드의 핵심 로직만 구현
// **제약조건**: AlertDialog 사용, canPop 검증 포함

class ImportantScreen extends StatelessWidget {

  // TODO: 이 메서드만 구현하세요 (10-15줄 예상)
  Future<void> showExitConfirmation(BuildContext context) async {
    // 여기에 확인 다이얼로그 + 안전한 뒤로가기 로직 구현
    if (Navigator.canPop(context)) { // 현재 화면에서 뒤로갈 수 있는지 확인
      final shouldExit = await showDialog<bool>( // AlertDialog를 사용하여 확인 다이얼로그 표시 > 불리언 값 반환으로 이후 처리
        context: context,
        builder: (context) => AlertDialog(
          title: Text("뒤로가기 확인"),
          content: Text("정말로 이 화면을 나가시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("아니요"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("네"),
            ),
          ],
        ),
      );

      if (shouldExit == true) {
        Navigator.of(context).pop(); // 뒤로가기
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showExitConfirmation(context);
        return false;
      },
      child: Scaffold(/* ... */),
    );
  }
}

// ### **7. 설정 화면 통합 시스템 - 레이아웃과 데이터 저장**
// **상황**: 사용자 설정을 변경하고 즉시 저장하는 완전한 설정 화면 구현
// **구현 범위**: buildSettingsBody 메서드의 핵심 로직만 구현
// **제약조건**: Column과 Row 조합, 실시간 저장, 적절한 여백 적용
class SettingsScreen extends StatefulWidget {
  // ... 기존 코드
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool isNotificationEnabled = true;

  // TODO: 이 메서드만 구현하세요 (12-18줄 예상)
  Widget buildSettingsBody() {
    // 여기에 설정 옵션들과 레이아웃 구현
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text("다크 모드"),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                  saveSetting("darkMode", value); // 다크 모드 설정 저장
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("알림 활성화"),
              Switch(
                value: isNotificationEnabled,
                onChanged: (value) {
                  setState(() {
                    isNotificationEnabled = value;
                  });
                  saveSetting("notification", value); // 알림 설정 저장
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> saveSetting(String key, dynamic value) async {
    // 저장 로직은 이미 구현됨
  }
}

class SearchableTodoList extends StatefulWidget {
  // ... 기존 코드
}

class _SearchableTodoListState extends State<SearchableTodoList> {
  List<Map<String, dynamic>> allTodos = [];
  List<Map<String, dynamic>> filteredTodos = [];
  String searchQuery = '';
  bool showCompletedOnly = false;

  // TODO: 이 메서드만 구현하세요 (8-12줄 예상)
  void applyFilters() {
    // 여기에 검색어와 완료 상태 필터링 로직 구현
    filteredTodos = allTodos.where((todo) {
      final matchesSearch = todo['title'].toLowerCase().contains(searchQuery.toLowerCase()); // 검색어 필터링
      final matchesCompletion = !showCompletedOnly || todo['isCompleted']; // 완료 상태 필터링
      return matchesSearch && matchesCompletion; // 검색어와 완료 상태 모두 일치하는 항목만 필터링
    }).toList();
    setState(() {
      showCompletedOnly = showCompletedOnly; // 상태 업데이트
    });
  }
}

