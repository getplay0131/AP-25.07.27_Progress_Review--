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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
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
          "일정 추가",
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
          _buildTimeSection(),
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
            child: Text("일정 추가 하기!"),
          ),
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

  Widget _buildTimeSection() {
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
          child: Text("날짜/시간 선택"),
        ),
      ],
    );
  }
}
