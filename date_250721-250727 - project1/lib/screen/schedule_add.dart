import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ScheduleAdd extends StatefulWidget {
  ScheduleAdd({Key? key}) : super(key: key);

  @override
  State<ScheduleAdd> createState() => _ScheduleAddState();
}

class _ScheduleAddState extends State<ScheduleAdd> {
  final _formKey = GlobalKey<FormState>();

  // 데이터 입력받기 위한 컨트롤러 선언 > 추후 텍스트필드에 연결 > 마지막에 디스포즈 필요
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;

  String title = "";
  DateTime date = DateTime.now();
  String description = "";
  String location = "";
  bool isCompleted = false;

  String currentMode = "";

  int _selectedIndex = 0; // 현재 선택된 인덱스

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    var args = ModalRoute.of(context)?.settings.arguments;
    setState(() {
      if (args != null && args is Map<String, dynamic>) {
        // args가 null이 아니고 Map<String, dynamic> 타입인 경우에만 처리
        title = args['title'] ?? '';
        date = args['date'] ?? DateTime.now();
        description = args['description'] ?? '';
        location = args['location'] ?? '';
        isCompleted = args['isCompleted'] ?? false;
        currentMode = args['mode'] ?? 'add'; // 'add' 또는 'edit' 모드
        _selectedIndex = args['selectedIndex'] ?? 0; // 선택된 인덱스 초기화
      } else {
        // 초기값 설정
        title = '';
        date = DateTime.now();
        description = '';
        location = '';
        isCompleted = false;
        currentMode = 'add';
        _selectedIndex = 0; // 초기 선택된 인덱스
      }
    });

    setState(() {
      if (currentMode == "edit") {
        // 수정 모드일 때 기존 데이터로 컨트롤러 초기화
        _titleController.text = title;
        _descriptionController.text = description;
        _locationController.text = location;
      } else {
        // 추가 모드일 때 컨트롤러 초기화
        _titleController.clear();
        _descriptionController.clear();
        _locationController.clear();
      }
    });
    print("didChangeDependencies called");
    print("===== loading data =====");
    print("title: $title");
    print("date: $date");
    print("description: $description");
    print("location: $location");
    print("isCompleted: $isCompleted");
    print("currentMode: $currentMode");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
    print("initState called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _showDatePicker(BuildContext context) async {
    DateTime tempPicked = date;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 300,
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: CupertinoDatePicker(
                  initialDateTime: date,
                  mode: CupertinoDatePickerMode.dateAndTime,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newDate) {
                    tempPicked = newDate;
                  },
                ),
              ),
              CupertinoButton(
                child: Text('확인'),
                onPressed: () {
                  setState(() {
                    date = tempPicked;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentMode == "edit" ? "일정 수정하기" : "일정 추가하기",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) // context가 유효한지 확인
              {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("홈 버튼이 눌렸습니다!")));
                Navigator.maybePop(context);
              }
            },
            icon: Icon(Icons.home, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          inputForm(
            titleController: _titleController,
            descriptionController: _descriptionController,
            locationController: _locationController,
          ),
          _buildTimeSection(currentMode),
          Checkbox(
            value: isCompleted,
            onChanged: (value) {
              // 체크박스 상태 변경 시 호출되는 콜백
              setState(() {
                isCompleted = value ?? false;
              });
            },
          ),
          ElevatedButton(
            onPressed: _collectAndValidateData,
            child: Text(currentMode == "edit" ? "일정 수정하기" : "일정 추가하기"),
          ),
          SizedBox(height: 20),
          Text(
            "현재 모드: $currentMode",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget inputForm({
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required TextEditingController locationController,
  }) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: "제목"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '제목을 입력해주세요.';
                }

                if (value.length > 20) {
                  return '제목은 20자 이내로 입력해주세요.';
                }

                if (value.length < 2) {
                  return '제목은 2자 이상 입력해주세요.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "설명"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '설명을 입력해주세요.';
                }

                if (value.length < 2) {
                  return '설명은 2자 이상 입력해주세요.';
                }
                if (value.length > 100) {
                  return '설명은 100자 이내로 입력해주세요.';
                }

                return null;
              },
            ),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(labelText: "위치"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '위치를 입력해주세요.';
                }
                if (value.length < 1) {
                  return '위치는 1자 이상 입력해주세요.';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  void _collectAndValidateData() {
    print("제목: ${_titleController.text.trim()}");
    print("설명: ${_descriptionController.text.trim()}");
    print("위치: ${_locationController.text.trim()}");
    if (_formKey.currentState!.validate()) {
      setState(() {
        title = _titleController.text.trim();
        description = _descriptionController.text.trim();
        location = _locationController.text.trim();
      });
      // 데이터가 유효하면 다음 화면으로 이동
      if (context.mounted) // context가 유효한지 확인
      {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("일정이 추가되었습니다.!")));
        // 데이터를 홈화면에 전달
        Navigator.pop(context, {
          'title': title,
          'date': date,
          'description': description,
          'location': location,
          'isCompleted': isCompleted,
        });
        Navigator.of(context).pushNamed(
          "/home_screen",
          arguments: {
            'title': title,
            'date': date,
            'description': description,
            'location': location,
            'isCompleted': isCompleted,
            "mode": currentMode, // 현재 모드 전달
          },
        );
      }
    } else {
      // 데이터가 유효하지 않으면 에러 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("입력한 데이터를 확인해주세요."),
          backgroundColor: Colors.red,
        ),
      );
    }
    _titleController.clear();
    _descriptionController.clear();
    _locationController.clear();
  }

  Widget _buildTimeSection(String currentMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "선택된 날짜/시간: ${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} "
          "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(width: 12),
        ElevatedButton(
          onPressed: () => _showDatePicker(context),
          child: Text(currentMode == "edit" ? "날짜/시간 수정" : "날짜/시간 선택"),
        ),
      ],
    );
  }
}
