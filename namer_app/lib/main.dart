// Import thư viện tạo từ ghép ngẫu nhiên (ví dụ: "sky_butter")
import 'package:english_words/english_words.dart';

// Import Flutter framework
import 'package:flutter/material.dart';

// Import provider để quản lý trạng thái (state)
import 'package:provider/provider.dart';

// Hàm main là điểm bắt đầu của ứng dụng Flutter
void main() {
  runApp(MyApp());
}

// Widget gốc của ứng dụng
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Cung cấp một instance của MyAppState cho toàn bộ app
      create: (context) => MyAppState(),

      // MaterialApp là gốc giao diện (theme, routing...)
      child: MaterialApp(
        title: 'Namer App',

        // Cấu hình theme với màu chủ đạo từ seedColor
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),

        // Widget chính hiển thị đầu tiên
        home: MyHomePage(),
      ),
    );
  }
}

// Lớp quản lý trạng thái ứng dụng
class MyAppState extends ChangeNotifier {
  // Biến current lưu 1 WordPair ngẫu nhiên
  var current = WordPair.random();
}

// Widget hiển thị trang chủ
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lấy dữ liệu từ Provider (MyAppState)
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text('A random idea:'),                          // Dòng giới thiệu
          Text(appState.current.asLowerCase),              // Hiển thị từ ghép ngẫu nhiên
        
          ElevatedButton(
            onPressed: () {
              print('button pressed!');
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
