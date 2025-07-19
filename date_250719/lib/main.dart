import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

//1번 문제
// class AutoSlideWidget extends StatefulWidget {
//   @override
//   _AutoSlideWidgetState createState() => _AutoSlideWidgetState();
// }
//
// class _AutoSlideWidgetState extends State<AutoSlideWidget> {
//   Timer? timer;
//   PageController controller = PageController();
//   int totalPages = 5;
//
//   // TODO: 이 메서드만 구현하세요 (5-8줄 예상)
//   @override
//   void initState() {
//     // 여기에 구현
//     super.initState();
//     Timer.periodic(Duration(seconds: 2), (Timer t) {
//       int currentPage = controller.page?.round() ?? 0; // 컨트롤러에서 현재 페이지를 가져옵니다.
//       if (currentPage < totalPages - 1) {
//         // 마지막 페이지 이전이라면
//         controller.nextPage(
//           // 다음 페이지로 이동
//           duration: Duration(milliseconds: 300), // 애니메이션 시간 설정
//           curve: Curves.easeInOut, // 애니메이션 곡선 설정
//         );
//       } else {
//         controller.jumpToPage(0); // 처음 페이지로 이동
//       }
//     });
//   }
// }

// 2번 문제
class CompletedTodoList extends StatelessWidget {
  final List<Todo> allTodos = [
    Todo('운동하기', true),
    Todo('공부하기', false),
    Todo('책읽기', true),
    Todo('요리하기', false),
  ];

  @override
  Widget build(BuildContext context) {
    final completedTodos = allTodos.where((todo) => todo.isCompleted).toList();

    return ListView.builder(
      itemCount: completedTodos.length,
      // TODO: 이 itemBuilder만 구현하세요 (5-7줄 예상)
      itemBuilder: (BuildContext context, int idx) {
        // 여기에 구현
        final todo = completedTodos[idx];
        return Card(child: Text(todo.title));
      },
    );
  }
}

class Todo {
  final String title;
  final bool isCompleted;
  Todo(this.title, this.isCompleted);
}

//3번 문제
class ProfileScreen extends StatelessWidget {
  // TODO: 이 메서드만 구현하세요 (6-10줄 예상)
  Map<String, String> getUserProfile(BuildContext context) {
    // 여기에 구현
    var args = ModalRoute.of(context)?.settings.arguments;
    final Map<String, String>? argsToMap = args is Map<String, String>
        ? args
        : null; // 전달된 인자가 있다면 그대로 반환
    if (argsToMap == null) {
      print('사용자 프로필 정보가 없습니다.');
      return {"name": "게스트", "email": "없음"}; // 전달된 인자가 있다면 그대로 반환
    } else {
      args = {
        "name": argsToMap["name"] ?? "게스트",
        "email": argsToMap["email"] ?? "없음",
      }; // 전달된 인자가 있다면 그대로 반환
      return args; // 전달된 인자가 없다면 빈 맵 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = getUserProfile(context);
    return Text('이름: ${profile['name']}, 이메일: ${profile['email']}');
  }
}

//4번 문제
// class Product {
//   final String name;
//   final double price;
//   final bool isAvailable;
//
//   Product({required this.name, required this.price, required this.isAvailable});
//
//   // TODO: 이 생성자만 구현하세요 (3-5줄 예상)
//   factory Product.fromJson(Map<String, dynamic> json) {
//     // 여기에 구현
//     // String convertName = json['name'] ?? '상품명 없음'; // 안정성 하락 타입 확인 불가
//     // double convertPrice = json['price']?.toDouble() ?? 0.0; // 안정성 하락 타입 확인 불가
//     // bool convertIsAvailable = json['isAvailable'] ?? false; // 안정성 하락 타입 확인 불가
//     // return Product(
//     //   name: convertName,
//     //   price: convertPrice,
//     //   isAvailable: convertIsAvailable,
//     // );
//     return Product(
//       name:
//           json['name'] as String? ??
//           '상품명 없음', // 해당 값이 해당 타입이라면 사용하지만, 널이면 '상품명 없음'으로 대체
//       price:
//           (json['price'] as num?)?.toDouble() ??
//           0.0, // 해당 값이 num 타입이라면 double로 변환, 널이면 0.0으로 대체
//       isAvailable:
//           json['isAvailable'] as bool? ??
//           false, // 해당 값이 bool 타입이라면 사용하지만, 널이면 false로 대체
//     );
//   }
// }

// 5번 문제
// class WishlistManager extends StatefulWidget {
//   @override
//   _WishlistManagerState createState() => _WishlistManagerState();
// }
//
// class _WishlistManagerState extends State<WishlistManager> {
//   List<String> wishlistIds = ['product1', 'product3'];
//
//   // TODO: 이 메서드만 구현하세요 (5-7줄 예상)
//   void updateWishlist(String productId) {
//     // 여기에 구현
//     setState(() {
//       wishlistIds.contains(productId)
//           ? wishlistIds.remove(productId)
//           : // 이미 위시리스트에 있다면 제거
//             wishlistIds.add(productId); // 없다면 추가
//     });
//   }
// }

// 6번 문제
class ProductSearch {
  List<Product> allProducts = [
    Product(name: 'iPhone 15', price: 1200.0),
    Product(name: 'Galaxy S24', price: 1100.0),
    Product(name: 'iPad Pro', price: 1000.0),
  ];

  // TODO: 이 메서드만 구현하세요 (3-5줄 예상)
  List<Product> filterProducts(String query) {
    // 여기에 구현
    if (query.isEmpty) {
      return allProducts; // 쿼리가 비어있으면 모든 상품 반환
    }
    return allProducts.where((value) {
      return value.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}

class Product {
  final String name;
  final double price;
  Product({required this.name, required this.price});
}

//7번 문제
// main() {
//   int originalPrice = 85000;
//   int discountPrice = 68000;
//   double calculatedPricePercent =
//       ((originalPrice - discountPrice) / originalPrice) *
//       100; // 할인율 계산 > ((원가 - 할인 가격) / 원가) * 100
//   double calculatePercent = double.parse(
//     calculatedPricePercent.toStringAsFixed(1), // 소수점 첫째 자리까지 반올림
//   );
//   print("${calculatePercent}%");
// }

//8번 문제 >> 저장용량 계산및 연산자 알고 넘어가기
String divideStorageBlocks(double gbSize, {int blockMb = 1024}) {
  if (gbSize <= 0 || blockMb <= 0) {
    throw ArgumentError("잘못된 입력입니다. GB 크기와 블록 크기는 양수여야 합니다.");
  }
  int gbToMb = (gbSize * blockMb).toInt(); // GB를 MB로 변환
  int blockCount = gbToMb ~/ blockMb; // 블록 크기로 나누기 > 몫
  int remainingMb = gbToMb % blockMb; // 나머지 MB 계산 > 나머지
  return "블록 개수: $blockCount, 남은 MB: $remainingMb";
}

main() {
  double gbSize = 1.5; // 예시 GB 크기
  print(divideStorageBlocks(gbSize));
}
