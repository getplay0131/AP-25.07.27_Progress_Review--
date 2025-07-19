import 'package:flutter/material.dart';

//
// // 1번 문제
class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  List<String> todos = [];

  // TODO: 이 메서드만 구현하세요
  void _addTodo() {
    // 여기에 구현
    String todoText = _controller.text.trim();
    if (todoText.isNotEmpty) {
      setState(() {
        todos.add(todoText);
        _controller.clear();
      });
    }
    TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: '할 일 입력',
        hintText: "할 일을 입력하세요",
        border: OutlineInputBorder(),
        suffixIcon: IconButton(icon: Icon(Icons.add), onPressed: _addTodo),
      ),
      autofocus: true,
      onSubmitted: (value) {
        _addTodo();
      },
    );
  }
}
//
// // 2번 문제
// class Product {
//   final String name;
//   final int price;
//   Product(this.name, this.price);
// }
//
// class ProductList extends StatelessWidget {
//   final List<Product> products = [
//     Product("iPhone", 1200000),
//     Product("Galaxy", 1000000),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         // TODO: 여기만 구현하세요
//         var product = products[index];
//         return ListTile(
//           title: Text(product.name),
//           subtitle: Text("${product.price}원"),
//           trailing: IconButton(
//             icon: Icon(Icons.add_shopping_cart),
//             onPressed: () {
//               // 장바구니에 추가하는 로직
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('${product.name}이(가) 장바구니에 추가되었습니다.')),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
//
// // 3번 문제
// class User {
//   final String name;
//   final int age;
//   final String email;
//
//   User(this.name, this.age, this.email);
//
//   // TODO: 이 메서드만 구현하세요
//   factory User.fromJson(Map<String, dynamic> json) {
//     // 여기에 구현
//     return User(
//       json['name'] as String,
//       json['age'] as int,
//       json['email'] as String,
//     );
//   }
// }
//
// // 4번 문제
// class CartItem {
//   final String productId;
//   final String name;
//   int quantity;
//
//   CartItem({required this.productId, required this.name, this.quantity = 1});
// }
//
// class CartManager extends StatefulWidget {
//   @override
//   _CartManagerState createState() => _CartManagerState();
// }
//
// class _CartManagerState extends State<CartManager> {
//   List<CartItem> cartItems = [];
//
//   // TODO: 이 메서드만 구현하세요
//   void addToCart(String productId, String productName) {
//     // 여기에 구현
//     try {
//       final existingItem = cartItems.firstWhere(
//         (item) => item.productId == productId,
//       );
//       setState(() {
//         existingItem.quantity++;
//       });
//     } catch (e) {
//       setState(() {
//         cartItems.add(CartItem(productId: productId, name: productName));
//         print("새로운 아이템이 장바구니에 추가되었습니다: $productName");
//         print("오류 발생! : $e");
//       });
//     }
//   }
// }
//
// // 5번 문제
// class WishlistManager extends StatefulWidget {
//   @override
//   _WishlistManagerState createState() => _WishlistManagerState();
// }
//
// class _WishlistManagerState extends State<WishlistManager> {
//   List<String> wishlistIds = [];
//
//   // TODO: 이 메서드만 구현하세요
//   void toggleWishlist(String productId) {
//     // 여기에 구현
//     try {
//       if (wishlistIds.contains(productId)) {
//         setState(() {
//           wishlistIds.remove(productId);
//           print("위시리스트에서 제거되었습니다: $productId");
//         });
//       }
//     } catch (e) {
//       setState(() {
//         wishlistIds.add(productId);
//         print("위시리스트에 추가되었습니다: $productId");
//       });
//       print("오류 발생! : $e");
//     }
//   }
// }
//
// // 6번 문제
// class Product {
//   final String id;
//   final String name;
//   final int price;
//
//   Product(this.id, this.name, this.price);
// }
//
// class ProductListScreen extends StatelessWidget {
//   final List<Product> products = [
//     Product("1", "iPhone", 1200000),
//     Product("2", "Galaxy", 1000000),
//   ];
//
//   // TODO: 이 메서드만 구현하세요
//   void navigateToDetail(BuildContext context, Product product) {
//     // 여기에 구현
//     Navigator.of(context).pushNamed("productDetail", arguments: product);
//     print("네비게이션이 호출되었습니다: ${product.name}");
//   }
// }

// 7번 문제
// TODO: 이 함수만 구현하세요 (원가, 판매가 → 할인율 반환)
double calculateDiscountRate(int originalPrice, int salePrice) {
  // 여기에 구현
  if (originalPrice <= 0 || salePrice < 0 || salePrice > originalPrice) {
    throw ArgumentError("잘못된 가격이 입력되었습니다.");
  }
  double discountRate =
      ((originalPrice - salePrice) / originalPrice) *
      100; // 할인율 계산 , ((원가 - 할인금액) / 원가) * 100
  return double.parse(
    discountRate.toStringAsFixed(1),
  ); // 소수점 첫째 자리까지 반올림 >> 변환한다. 소수점 1자리만 포함해서
}

/*void main() {
  double result = calculateDiscountRate(89000, 67000);
  print("할인율: ${result}%"); // 결과: 24.7%
}*/

// 8번 문제
// TODO: 이 함수만 구현하세요
int calculateShipping(int totalAmount) {
  // 여기에 구현
  if (totalAmount < 0) {
    throw ArgumentError("잘못된 금액이 입력되었습니다.");
  }
  if (totalAmount >= 50000) {
    return 0; // 무료 배송
  } else if (totalAmount >= 30000) {
    return 2500; // 2,500원 배송비
  } else {
    return 3500; // 3,500원 배송비
  }
}

void main() {
  print("139,000원 주문: ${calculateShipping(139000)}원"); // 0원
  print("35,000원 주문: ${calculateShipping(35000)}원"); // 2,500원
  print("25,000원 주문: ${calculateShipping(25000)}원"); // 3,500원
}
