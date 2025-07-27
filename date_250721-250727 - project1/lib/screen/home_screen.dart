import 'package:flutter/material.dart';

// 일정 추가시 일정 상세보기에 안넘어감 > 3일차에 디버깅 우선으로 해당 문제 해결과 복습 진행하기
// 25-07-26 할 일!
// TODO : 할일 수정 기능 구현하기
// 홈 스크린에 수정 또는 보기 기능 [클리어](상세보기 모드 클릭시 일정 상세 보기 화면으로 이동하며, 수정 모드는 수정 화면으로 이동하고 플로팅 버튼은 추가 화면으로 이동만 담당!)>
// 보기 기능일때는 기존 로직 유지 (완료)>
// 수정 기능일때는 수정 화면으로 이동 (완료) >
// 수정 화면은 추가 화면에 로직의 내용을 바꿔서 표시 (완료) >
// 수정 완료후 홈 스크린으로 돌아가기 (완료) >
// 이때 상세 내용에도 해당 내용이 전달 되어야 함
// 25-07-28 할일!
// TODO : 스크린 전환시 데이터 전달 무너짐 > 수정 필요!
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> schedule = {
    "title": "일정 1",
    "date": DateTime.now(),
    "description": "일정 1 설명",
    "location": "장소 1",
    "isCompleted": false,
  };
  List<Map<String, dynamic>> scheduleList = [];

  bool isEditMode = false; // false > 일정 추가 모드, true > 일정 수정 모드

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 초기 일정 데이터 추가
    scheduleList.add(schedule);
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      schedule['isCompleted']
                          ? Icons.check_circle
                          : Icons.circle,
                      color: schedule['isCompleted']
                          ? Colors.green
                          : Colors.grey,
                    ),
                    onTap: () {
                      if (!isEditMode) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("상세 보기 모드입니다!")));
                        Navigator.pushNamed(
                          context,
                          '/schedule_content',
                          arguments: {
                            "data": schedule, // 선택된 일정의 데이터
                            "mode": "view", // 상세 보기 모드임을 알리기 위한 인자
                            "scheduleIndex": idx, // 선택된 일정의 인덱스
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("수정 모드입니다!")));
                        Navigator.pushNamed(
                          context,
                          '/schedule_add',
                          arguments: {
                            "data": schedule, // 선택된 일정의 데이터
                            "mode": "edit", // 수정 모드임을 알리기 위한 인자
                            "scheduleIndex": idx, // 선택된 일정의 인덱스
                          },
                        );
                      }
                    },
                    leading: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditMode = !isEditMode; // 버튼 클릭 시 모드 전환
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isEditMode
                                  ? "일정 수정 모드로 전환되었습니다!"
                                  : "일정 상세 보기 모드로 전환되었습니다!",
                            ),
                          ),
                        );
                      },
                      child: Text(isEditMode ? "수정 모드!" : "상세 보기 모드!"),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("일정 추가 화면으로 이동!")));
          _MoveToAddScheduleScreen();
        },

        // 수정 모드시에는 수정 화면으로 이동, 추가 모드시에는 추가 화면으로 이동
        child: Icon(Icons.add),
        tooltip: "일정 추가",
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _MoveToAddScheduleScreen() async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("일정 추가 버튼이 눌렸습니다!")));
    // 데이터 받아서 scheduleList에 추가 > 반영 필요
    var result = await Navigator.pushNamed(context, '/schedule_add');
    if (result != null && result is Map<String, dynamic>) {
      result["mode"] = "add"; // 추가 모드임을 알리기 위한 인자
      setState(() {
        scheduleList.add(result);
      });
    }
  }
}
