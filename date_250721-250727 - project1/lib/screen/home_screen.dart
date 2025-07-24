import 'package:flutter/material.dart';

// 일정 추가시 일정 상세보기에 안넘어감 > 3일차에 디버깅 우선으로 해당 문제 해결과 복습 진행하기

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> scheduleList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scheduleList.add({
      "title": "일정 1",
      "date": DateTime.now(),
      "description": "일정 1 설명",
      "location": "장소 1",
      "isCompleted": false,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "개인 일정 관리 앱!",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: scheduleList.length,
              itemBuilder: (context, idx) {
                print(scheduleList.length);
                var schedule = scheduleList[idx];
                // _addSchedule(schedule, idx);
                return ListTile(
                  title: Text(schedule['title']),
                  subtitle: Text(
                    "${schedule['date'].toLocal()} - ${schedule['description']}",
                  ),
                  trailing: Icon(
                    schedule['isCompleted'] ? Icons.check_circle : Icons.circle,
                    color: schedule['isCompleted'] ? Colors.green : Colors.grey,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/schedule_content',
                      arguments: {
                        'title': schedule['title'],
                        'date': schedule['date'],
                        'description': schedule['description'],
                        'location': schedule['location'],
                        'isCompleted': schedule['isCompleted'],
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addScheduleScreen,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _addScheduleScreen() async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("일정 추가 버튼이 눌렸습니다!")));
    // 데이터 받아서 scheduleList에 추가 > 반영 필요
    var result = await Navigator.pushNamed(context, '/schedule_add');
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        scheduleList.add(result);
      });
    }
  }
}
