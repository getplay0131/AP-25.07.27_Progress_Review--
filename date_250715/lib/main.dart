import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {}

// 1번 문제
// 상품 모델
class Product {
  final String id;
  final String name;
  final int price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

// 메인 상품 목록 화면
class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(id: '1', name: '무선 이어폰', price: 89000, imageUrl: 'earbuds.jpg'),
    Product(id: '2', name: '스마트워치', price: 299000, imageUrl: 'watch.jpg'),
    Product(id: '3', name: '노트북 파우치', price: 45000, imageUrl: 'pouch.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('상품 목록')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text(product.name),
            subtitle: Text('${product.price}원'),
            onTap: () => navigateToProductDetail(context, product),
          );
        },
      ),
    );
  }

  // TODO: 이 메서드만 구현하세요
  void navigateToProductDetail(BuildContext context, Product product) {
    // '/product_detail' 라우트로 이동하며 상품 정보 전달
    Map<String, dynamic> arguments = {
      'id': product.id,
      'name': product.name,
      'price': product.price,
      'imageUrl': product.imageUrl,
    };
    Navigator.of(context).pushNamed("product_detail", arguments: arguments);
  }
}

// 2번 문제
class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: 여기에 arguments 추출 로직 구현
    // ModalRoute를 통해 전달받은 상품 정보 추출
    final arguments =
        ModalRoute.of(context)?.settings.arguments
            as Map<String, dynamic>; // 이 부분 구현

    final productId = arguments["id"] ?? ""; // arguments에서 추출
    final productName = arguments["name"] ?? ""; // arguments에서 추출
    final productPrice = arguments["price"] ?? 0; // arguments에서 추출
    final productImage = arguments["imageUrl"] ?? ""; // arguments에서 추출

    return Scaffold(
      appBar: AppBar(title: Text(productName)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.image, size: 80, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Text(
              '상품 ID: $productId',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              productName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${productPrice}원',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// 3번 문제
class CartItem {
  final String productId;
  final String productName;
  final int price;
  int quantity;

  CartItem({
    required this.productId,
    required this.productName,
    required this.price,
    this.quantity = 1,
  });
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(productId: '1', productName: '무선 이어폰', price: 89000, quantity: 1),
    CartItem(productId: '2', productName: '스마트워치', price: 299000, quantity: 2),
  ];

  // TODO: 이 메서드만 구현하세요
  void addToCart(String productId, String productName, int price) {
    // 같은 상품이 있으면 수량 증가, 없으면 새로 추가
    for (var cart in cartItems) {
      if (cart.productId == productId) {
        setState(() {
          cart.quantity += 1; // 수량 증가
        });
        return; // 이미 장바구니에 있으므로 종료
      } else {
        setState(() {
          cartItems.add(
            CartItem(
              productId: productId,
              productName: productName,
              price: price,
            ),
          );
        });
        return; // 새로 추가했으므로 종료
      }
    }
  }

  // TODO: 이 메서드만 구현하세요
  void removeFromCart(String productId) {
    // 해당 상품을 장바구니에서 완전 제거
    setState(() {
      for (var cart in cartItems) {
        if (cart.productId == productId) {
          cartItems.remove(cart);
          break; // 제거 후 루프 종료
        }
      }
    });
  }

  int getTotalPrice() {
    return cartItems.fold(
      0,
      (total, item) => total + (item.price * item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('장바구니')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item.productName),
                  subtitle: Text('${item.price}원 x ${item.quantity}개'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => removeFromCart(item.productId),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              '총 금액: ${getTotalPrice()}원',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// 4번 문제
class UserSettings {
  String username;
  bool isDarkMode;
  String language;
  bool notificationsEnabled;

  UserSettings({
    this.username = '사용자',
    this.isDarkMode = false,
    this.language = 'ko',
    this.notificationsEnabled = true,
  });
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserSettings settings = UserSettings(
    username: '홍길동',
    isDarkMode: true,
    language: 'ko',
    notificationsEnabled: false,
  );

  // TODO: 이 메서드만 구현하세요
  Future<void> saveUserSettings() async {
    // settings 객체를 JSON으로 변환하여 SharedPreferences에 저장
    // 키는 'user_settings'로 사용
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      'username': settings.username,
      'isDarkMode': settings.isDarkMode,
      'language': settings.language,
      'notificationsEnabled': settings.notificationsEnabled,
    };
    String settingsJson = jsonEncode(data);
    await prefs.setString('user_settings', settingsJson);
  }

  Future<void> loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    String? settingsJson = prefs.getString('user_settings');
    if (settingsJson != null) {
      Map<String, dynamic> data = jsonDecode(settingsJson);
      setState(() {
        settings.username = data['username'] ?? '사용자';
        settings.isDarkMode = data['isDarkMode'] ?? false;
        settings.language = data['language'] ?? 'ko';
        settings.notificationsEnabled = data['notificationsEnabled'] ?? true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('설정')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: '사용자명'),
              controller: TextEditingController(text: settings.username),
              onChanged: (value) => settings.username = value,
            ),
            SwitchListTile(
              title: Text('다크 모드'),
              value: settings.isDarkMode,
              onChanged: (value) => setState(() => settings.isDarkMode = value),
            ),
            SwitchListTile(
              title: Text('알림 허용'),
              value: settings.notificationsEnabled,
              onChanged: (value) =>
                  setState(() => settings.notificationsEnabled = value),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveUserSettings, child: Text('설정 저장')),
          ],
        ),
      ),
    );
  }
}

// 5번 문제
class ProductSearchScreen extends StatefulWidget {
  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final List<Product> allProducts = [
    Product(id: '1', name: '아이폰 케이스', price: 25000, imageUrl: 'case1.jpg'),
    Product(id: '2', name: '갤럭시 케이스', price: 22000, imageUrl: 'case2.jpg'),
    Product(id: '3', name: '무선 충전기', price: 45000, imageUrl: 'charger.jpg'),
    Product(id: '4', name: '스마트 워치', price: 299000, imageUrl: 'watch.jpg'),
    Product(id: '5', name: '아이패드 케이스', price: 35000, imageUrl: 'ipad_case.jpg'),
  ];

  List<Product> filteredProducts = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
  }

  // TODO: 이 메서드만 구현하세요
  void filterProducts(String query) {
    // query가 비어있으면 전체 목록, 아니면 이름에 query가 포함된 상품만 필터링
    // setState로 화면 업데이트
    setState(() {
      if (query.isEmpty) {
        filteredProducts = allProducts;
      } else {
        filteredProducts = allProducts
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(); // 웨어로 조건을 걸고 소문자로 변환해 정확히 비교한다.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('상품 검색')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: '상품명을 입력하세요',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                searchQuery = value;
                filterProducts(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ListTile(
                  leading: Icon(Icons.shopping_bag),
                  title: Text(product.name),
                  subtitle: Text('${product.price}원'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//6번 문제
class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<Product> allProducts = [
    Product(id: '1', name: '무선 이어폰', price: 89000, imageUrl: 'earbuds.jpg'),
    Product(id: '2', name: '스마트 워치', price: 299000, imageUrl: 'watch.jpg'),
    Product(id: '3', name: '노트북 파우치', price: 45000, imageUrl: 'pouch.jpg'),
  ];

  List<String> wishlistIds = ['1']; // 초기에 상품 1이 위시리스트에 있음

  // TODO: 이 메서드만 구현하세요
  void toggleWishlist(String productId) {
    // productId가 위시리스트에 있으면 제거, 없으면 추가
    // setState로 화면 업데이트
    setState(() {
      for (var list in wishlistIds) {
        if (list.contains(productId)) {
          wishlistIds.remove(productId); // 위시리스트에서 제거
          return; // 제거 후 종료
        } else {
          wishlistIds.add(productId); // 위시리스트에 추가
          return; // 추가 후 종료
        }
      }
    });
  }

  bool isInWishlist(String productId) {
    return wishlistIds.contains(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('위시리스트')),
      body: ListView.builder(
        itemCount: allProducts.length,
        itemBuilder: (context, index) {
          final product = allProducts[index];
          final isWished = isInWishlist(product.id);

          return ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text(product.name),
            subtitle: Text('${product.price}원'),
            trailing: IconButton(
              icon: Icon(
                isWished ? Icons.favorite : Icons.favorite_border,
                color: isWished ? Colors.red : Colors.grey,
              ),
              onPressed: () => toggleWishlist(product.id),
            ),
          );
        },
      ),
    );
  }
}

//7번 문제
//**문제**: 원가 89,000원 상품을 67,000원에 판매할 때 할인율을 소수점 첫째 자리까지 구하세요.
//* 힌트: 할인율 = (원가 - 판매가) / 원가 * 100

double calculateDiscountRate(int originalPrice, int salePrice) {
  // 할인율 계산
  double discountRate = ((originalPrice - salePrice) / originalPrice) * 100;
  return double.parse(discountRate.toStringAsFixed(1)); // 소수점 첫째 자리까지 반올림
}

//8번 문제
//**문제**: 다음 조건으로 총 주문 금액별 배송비를 계산하세요.
// - 50,000원 이상: 무료배송
// - 30,000원 이상: 2,500원
// - 30,000원 미만: 3,500원
int calculateShippingFee(int totalPrice, int quantity) {
  if (totalPrice * quantity >= 50000) {
    return 0; // 무료배송
  } else if (totalPrice * quantity >= 30000) {
    return 2500; // 2,500원 배송비
  } else {
    return 3500; // 3,500원 배송비
  }
}
