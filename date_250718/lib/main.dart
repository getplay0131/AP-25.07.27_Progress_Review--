import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';

//1번 문제
class GameSettings {
  String playerName;
  int level;
  List<String> achievements;

  GameSettings({
    required this.playerName,
    required this.level,
    required this.achievements,
  });

  // TODO: 이 메서드만 구현하세요 (6-8줄 예상)
  Future<void> saveSettings() async {
    // 여기에 구현
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> settingsMap = {
      'playerName': playerName,
      'level': level,
      'achievements': achievements,
    };
    var jsonEncode1 = jsonEncode(settingsMap);
    await prefs.setString('game_settings', jsonEncode1);
    print('Game settings saved: $jsonEncode1');
  }
}

//2번 문제
// 이미 제공된 코드
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: 이 부분만 구현하세요 (5-7줄 예상)
    // arguments에서 profileData 추출하고 각 필드에 안전하게 접근

    // 여기에 구현
    var arguments2 = ModalRoute.of(context)?.settings.arguments;
    Map<String, dynamic> profileData = arguments2 as Map<String, dynamic>;
    String profileId = profileData['id'] ?? '알 수 없음';
    String profileName = profileData['name'] ?? '이름 없음';
    String profileEmail = profileData['email'] ?? '이메일 없음';

    return Scaffold(
      appBar: AppBar(title: Text("프로필")),
      body: Column(
        children: [
          Text("ID: $profileId"),
          Text("이름: $profileName"),
          Text("이메일: $profileEmail"),
        ],
      ),
    );
  }
}

//3번 문제
class AppInitializer {
  // TODO: 이 메서드만 구현하세요 (4-6줄 예상)
  Future<void> initializeApp() async {
    // 여기에 구현
    final prefs = await SharedPreferences.getInstance();
    await loadPlayerData();
    await setupGame();
  }

  // 이미 제공된 메서드들
  Future<void> loadPlayerData() async {
    /* 구현됨 */
  }
  Future<void> setupGame() async {
    /* 구현됨 */
  }
}

//4번 문제
class ScoreAnalyzer {
  Map<String, int> subjectScores = {'수학': 95, '국어': 88, '영어': 92, '과학': 91};

  // TODO: 이 메서드만 구현하세요 (6-8줄 예상)
  void analyzeScores() {
    subjectScores.forEach((subject, score) {
      // 여기에 구현
      if (score >= 90) {
        print("$subject : 우수");
      } else if (score < 90) {
        print("$subject : 보통");
      }
    });
  }
}

// 5번 문제
// 이미 제공된 코드
class UserProfile {
  String? name;
  String? email;

  UserProfile({this.name, this.email});
}

// TODO: 이 함수만 구현하세요 (3-5줄 예상)
String getUserDisplayName(UserProfile? profile) {
  // 여기에 구현
  if (profile == null) {
    return "익명 사용자";
  }
  if (profile.name == null) {
    return "이름 없음";
  }

  return profile.name!;
}

// 6번 문제
class AppConfig {
  final String theme;
  final String language;
  final bool soundEnabled;

  AppConfig({
    required this.theme,
    required this.language,
    required this.soundEnabled,
  });
}

class AppConfigManager {
  static const String CONFIG_KEY = 'app_config';

  // TODO: 이 메서드만 구현하세요 (7-10줄 예상)
  static Future<AppConfig> loadConfig() async {
    // 여기에 구현
    final prefs = await SharedPreferences.getInstance();
    var string = prefs.getString(CONFIG_KEY);
    if (string == null) {
      return createDefault();
    } else {
      var jsonDecode2 = jsonDecode(string);
      return AppConfig(
        theme: jsonDecode2["theme"],
        language: jsonDecode2["language"],
        soundEnabled: jsonDecode2["soundEnabled"],
      );
    }
  }

  // 이미 제공된 메서드
  static AppConfig createDefault() {
    return AppConfig(theme: 'light', language: 'ko', soundEnabled: true);
  }
}

// 7번 문제

// TODO: 이 함수만 구현하세요 (3-4줄 예상)
int calculateCompoundInterest(int principal, double rate, int years) {
  // 여기에 구현

  return (principal * pow((1 + rate), years)).toDouble().round();
}

main() {
  print(calculateCompoundInterest(100000, 0.5, 5));
}

//8번 문제
// TODO: 이 함수만 구현하세요 (3-4줄 예상)
double calculateDiscountRate(double originalPrice, double salePrice) {
  // 여기에 구현
  if (originalPrice <= 0 || salePrice < 0 || salePrice > originalPrice) {
    throw ArgumentError("잘못된 가격이 입력되었습니다.");
  }
  double discountRate = ((originalPrice - salePrice) / originalPrice) * 100;
  return double.parse(discountRate.toStringAsFixed(2)); // 소수점 둘째 자리까지 반올림
}
