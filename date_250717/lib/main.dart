import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart'; // 가상의 Webview 패키지
import 'dart:math';
import 'package:flutter/src/widgets/widget_inspector.dart';

//
//
// //1번 문제
// class PostService {
//   // TODO: 이 메서드만 구현하세요 (3-5줄 예상)
//   Map<String, dynamic> createPostData(String content) {
//     // 여기에 구현
//     // 반환: {'content': content, 'timestamp': UTC_밀리초, 'utc_time': UTC_문자열}
//     return {
//       "content": content,
//       "timestamp": DateTime.now().toUtc().millisecondsSinceEpoch,
//       "utc_time": DateTime.now().toUtc().toIso8601String(),
//     };
//   }
// }
//
// //2번 문제
// class SettingsManager {
//   // TODO: 이 메서드만 구현하세요 (4-6줄 예상)
//   Future<void> saveUserTheme(String theme) async {
//     // 여기에 구현
//     // SharedPreferences 인스턴스 얻고 'user_theme' 키로 저장
//     final prefs = await SharedPreferences.getInstance();
//     if (theme.isNotEmpty) {
//       await prefs.setString('user_theme', theme);
//       print("정보 저장 완료");
//     }
//   }
//
//   // TODO: 이 메서드만 구현하세요 (4-6줄 예상)
//   Future<String> getUserTheme() async {
//     // 여기에 구현
//     // 기본값: 'light', null이면 기본값 반환
//     final prefs = await SharedPreferences.getInstance();
//     String? theme = prefs.getString('user_theme');
//     return theme ?? 'light';
//   }
// }
//
// //3번 문제
// class ApiDesigner {
//   // TODO: 이 메서드만 구현하세요 (5-8줄 예상)
//   String selectHttpMethod(String scenario) {
//     // 여기에 구현
//     // scenario: "get_user", "create_order", "update_profile", "delete_post"
//     // 반환: "GET", "POST", "PUT", "DELETE" 중 하나
//     Map<String, String> methodMap = {
//       "get_user": "GET",
//       "create_order": "POST",
//       "update_profile": "PUT",
//       "delete_post": "DELETE",
//     };
//     return methodMap[scenario] ?? "GET"; // 기본값은 GET
//   }
// }
//
// //4번 문제
// class WidgetOptimizer {
//   // TODO: 이 메서드만 구현하세요 (4-6줄 예상)
//   Widget createOptimalPadding(
//     Widget child,
//     double padding, {
//     Color? backgroundColor,
//   }) {
//     // 여기에 구현
//     // backgroundColor가 null이면 Padding, 있으면 Container 사용
//     // 반환: 최적화된 위젯
//     if (backgroundColor == null) {
//       return Padding(padding: EdgeInsets.all(padding), child: child);
//     } else {
//       return Container(
//         padding: EdgeInsets.all(padding),
//         color: backgroundColor,
//         child: child,
//       );
//     }
//   }
// }
//
// //5번 문제
// class ConstraintCalculator {
//   // TODO: 이 메서드만 구현하세요 (4-6줄 예상)
//   Size calculateChildSize(Size parentSize, EdgeInsets padding) {
//     // 여기에 구현
//     // parentSize: 부모 Container 크기
//     // padding: 내부 패딩
//     // 반환: 실제 자식 위젯이 사용 가능한 크기
//     double width = parentSize.width - padding.left - padding.right;
//     var widthTest = parentSize.width - padding.horizontal; // 위드와 동일
//     double height = parentSize.height - padding.top - padding.bottom;
//     var heightTest = parentSize.height - padding.vertical; // 하이트와 동일
//     return Size(width, height);
//   }
//
// //   main() {
// //     // 테스트용 main 함수
// //     print("width : ");
// //   }
// // }
//
// //6번 문제
//   class SafeNavigator {
//   // TODO: 이 메서드만 구현하세요 (5-7줄 예상)
//   bool safeGoBack(BuildContext context) {
//   // 여기에 구현
//   if (Navigator.canPop(context)) {
//   print("뒤로가기 가능!");
//   Navigator.pop(context);
//   return true;
//   } else {
//   print("뒤로가기 불가능!");
//   return false;
//   }
//   }
//
//   // TODO: 이 메서드만 구현하세요 (2-3줄 예상)
//   void smartGoBack(BuildContext context) {
//   // 여기에 구현
//   Navigator.of(context).maybePop();
//   }
//   }
//
// //7번 문제
//
//   class FavoriteManager extends StatefulWidget {
//   const FavoriteManager({super.key});
//
//   @override
//   State<FavoriteManager> createState() => _FavoriteManagerState();
//   }
//
//   class _FavoriteManagerState extends State<FavoriteManager> {
//   // 이미 선언된 상태
//   List<String> favorites = [];
//
//   // TODO: 이 메서드만 구현하세요 (5-7줄 예상)
//   void toggleFavorite(String item) {
//   // 여기에 구현
//   if (item.isEmpty) {
//   print("아이템이 비어있습니다.");
//   }
//   setState(() {
//   if (favorites.contains(item)) {
//   favorites.remove(item);
//   } else {
//   favorites.add(item);
//   }
//   });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//   // TODO: implement build
//   throw UnimplementedError();
//   }
//   }
//
// //8번 문제
//   class UserProfileManager {
//   Map<String, dynamic> currentProfile = {
//   'name': '홍길동',
//   'age': 25,
//   'email': 'hong@example.com',
//   };
//
//   // TODO: 이 메서드만 구현하세요 (4-6줄 예상)
//   void updateProfile(Map<String, dynamic> newData) {
//   // 여기에 구현
//   newData.forEach((key, value) {
//   if (currentProfile[key] != null) {
//   currentProfile[key] = value;
//   } else {
//   print("이미 존재하는 키: $key");
//   }
//   });
//   }
//   }
//
// //9번 문제
//   class FeedbackManager {
//   // TODO: 이 메서드만 구현하세요 (6-8줄 예상)
//   void showResultMessage(BuildContext context, bool isSuccess, String message) {
//   // 여기에 구현
//   // isSuccess에 따라 색상과 지속시간 다르게 설정
//   ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//   content: Text(
//   "data",
//   style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
//   ),
//   duration: isSuccess ? Duration(seconds: 1) : Duration(seconds: 2),
//   ),
//   );
//   }
//   }
//
// //10번 문제
class SafeDataParser {
  // TODO: 이 메서드만 구현하세요 (5-8줄 예상)
  String getStringValue(
    Map<String, dynamic> data,
    String key,
    String defaultValue,
  ) {
    // 여기에 구현
    if (data.containsKey(key) && data[key] is String) {
      return data[key] as String;
    } else {
      return defaultValue;
    }
  }
}

//
// //11번 문제
void navigateToPage(BuildContext context, String url) {
  // WebViewController()..loadRequest(
  //   url.contains("intranet.company.com")
  //       ? Uri.parse(url)
  //       : Uri.parse("https://www.example.com"),
  // );
  // 여기에 구현
  if (url.contains("intranet.company.com")) {
    // 가상의 Webview 패키지 사용
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  } else {
    // 일반적인 URL 처리
    print("일반 URL로 이동: $url");
  }
}

//
// //12번 문제
//   class TimerWidget extends StatefulWidget {
//   Timer? timer;
//   int count = 0;
//
//   // TODO: 이 메서드만 구현하세요 (3-4줄 예상)
//   @override
//   void initState() {
//   // 여기에 구현
//   super.initState();
//   timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
//   print("타이머가 실행되었습니다.");
//   count++;
//   });
//   if (count > 5) {
//   print("타이머가 5번 이상 실행되었습니다.");
//   timer?.cancel();
//   }
//   }
//
//   // TODO: 이 메서드만 구현하세요 (3-4줄 예상)
//   @override
//   void dispose() {
//   // 여기에 구현
//   // 타이머 정리
//   timer?.cancel();
//   super.dispose();
//   }
//   }
//
// //13번 문제
//   class ProductFilter {
//   List<Map<String, dynamic>> products = [
//   {'name': '아이폰 케이스', 'price': 15000},
//   {'name': '갤럭시 충전기', 'price': 25000},
//   {'name': '무선 이어폰', 'price': 89000},
//   ];
//
//   // TODO: 이 메서드만 구현하세요 (4-6줄 예상)
//   List<Map<String, dynamic>> filterProducts(String query) {
//   // 여기에 구현
//   List<Map<String, dynamic>> result = [];
//   result = products.where((value) {
//   return value["name"].toString().toLowerCase().contains(
//   query.toLowerCase(),
//   );
//   }).toList();
//   return result.isEmpty ? [] : result;
//   }
//   }
//
// // 14번 문제
//   class UserInitializer {
//   // TODO: 이 메서드만 구현하세요 (6-8줄 예상)
//   Future<Map<String, dynamic>> initializeUser(String userId) async {
//   // 여기에 구현
//   // 1. await authenticateUser(userId)
//   // 2. await loadUserProfile(userId)
//   // 3. await loadUserSettings(userId)
//   // 결과를 Map으로 반환
//   var userCheck = await authenticateUser(userId);
//   if (!userCheck) {
//   return Map<String, dynamic>.from({
//   'authenticated': false,
//   'profile': null,
//   'settings': null,
//   });
//   }
//
//   var userLoad = await loadUserProfile(userId);
//   var userSetting = await loadUserSettings(userId);
//   return Map<String, dynamic>.from({
//   'authenticated': userCheck,
//   'profile': userLoad,
//   'settings': userSetting,
//   });
//   }
//
//   // 이미 구현된 메서드들
//   Future<bool> authenticateUser(String userId) async => true;
//   Future<Map<String, dynamic>> loadUserProfile(String userId) async => {
//   'name': '사용자',
//   };
//   Future<Map<String, dynamic>> loadUserSettings(String userId) async => {
//   'theme': 'dark',
//   };
//   }
//
// // 15번 문제
//   class UserParser {
//   // TODO: 이 메서드만 구현하세요 (8-10줄 예상)
//   Map<String, dynamic> parseUserData(String jsonString) {
//   // 여기에 구현
//   try {
//   var jsonDecode2 = jsonDecode(jsonString);
//   if (jsonDecode2["id"] != null &&
//   jsonDecode2["name"] != null &&
//   jsonDecode2["email"] != null &&
//   jsonDecode2["city"] != null) {
//   return Map<String, dynamic>.from({
//   'id': jsonDecode2["id"],
//   'name': jsonDecode2["name"],
//   'email': jsonDecode2["email"],
//   'city': jsonDecode2["city"],
//   });
//   } else {
//   throw FormatException("필수 키가 누락되었습니다.");
//   }
//   } catch (e) {
//   print("JSON 파싱 오류: $e");
//   return {};
//   }
//   }
//   }
//
// //16번 문제
//   class FormValidator {
//   // TODO: 이 메서드만 구현하세요 (6-8줄 예상)
//   Map<String, String?> validateForm(String email, String password) {
//   // 여기에 구현
//   Map<String, String?> checkValue = {};
//   if (email.isEmpty || email.contains("@") == false) {
//   checkValue['email'] = "이메일 형식이 잘못되었습니다.";
//   } else {
//   checkValue['email'] = null;
//   }
//   if (password.isEmpty) {
//   checkValue['password'] = "비밀번호는 필수입니다.";
//   } else if (password.length < 8) {
//   checkValue['password'] = "비밀번호는 8자 이상이어야 합니다.";
//   } else {
//   checkValue['password'] = null;
//   }
//   return checkValue;
//   }
//   }
//
// //17번 문제
// // **문제**: 원가 45,000원인 상품이 32,400원에 판매될 때, 할인율을 계산하고 "XX.XX%" 형태로 반환하는 코드를 작성하시오.
// // 힌트 : 할인율 = ((원가 - 판매가) / 원가) * 100
//
// // void main() {
// //   double originalPrice = 45000;
// //   double salePrice = 32400;
// //
// //   double discountRate = calculateDiscountRate(originalPrice, salePrice);
// //   print("할인율: ${discountRate}%"); // 결과: 할인율: XX.XX%
// // }
//
//   double calculateDiscountRate(double originalPrice, double salePrice) {
//   // 여기에 구현
//   if (originalPrice <= 0 || salePrice < 0 || salePrice > originalPrice) {
//   throw ArgumentError("잘못된 가격이 입력되었습니다.");
//   }
//   double discountRate =
//   ((originalPrice - salePrice) / originalPrice) * 100; // 할인율 계산
//   return double.parse(discountRate.toStringAsFixed(2)); // 소수점 둘째 자리까지 반올림
//   }
//
// // 18번 문제
// // void main() {
// //   int totalPrice = 35000; // 예시 총 가격
// //   int shippingPrice = calculateShippedPrice(totalPrice);
// // }
//
//   int calculateShippedPrice(int totalprice) {
//   if (totalprice >= 50000) {
//   return 0; // 무료 배송
//   } else if (totalprice >= 30000) {
//   return 2500; // 2,500원 배송비
//   } else if (totalprice < 30000) {
//   return 3500; // 3,500원 배송비
//   }
//   throw ArgumentError("잘못된 금액이 입력되었습니다.");
//   }
//
// // 19번 문제
// // main() {
// //   int radius = 4;
// //   int height = 12;
// //   double volume = calculateCylinderVolume(radius, height);
// // }
//
//   double calculateCylinderVolume(int radius, int height) {
//   if (radius <= 0 || height <= 0) {
//   throw ArgumentError("반지름과 높이는 양수여야 합니다.");
//   }
//   double volume = 1 / 3 * pi * radius * radius * height; // 원기둥 부피 계산
//   return double.parse(volume.toStringAsFixed(2)); // 소수점 둘째 자리까지 반올림
//   }
//
// // 20번 문제
//
// }
void main() {
  int inputPrice = 100000; // 예시 입력 가격
  int inputMonth = 60;
  double interest = 0.03;
  int years = 5; // 예시 입력 연수

  int totalPrice = (inputPrice * pow(1 + interest, years)).round();
  print("총 납입금: $totalPrice");
}
