import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

void main() => runApp(const Demo7BottomNavigationBar());

class Demo7BottomNavigationBar extends StatelessWidget {
  const Demo7BottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Demo7BottomNavigationBarWidget(),
    );
  }
}

class Demo7BottomNavigationBarWidget extends StatefulWidget {
  const Demo7BottomNavigationBarWidget({super.key});

  @override
  State<Demo7BottomNavigationBarWidget> createState() => _Demo7WidgetState();
}

class _Demo7WidgetState extends State<Demo7BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  // Trang demo: const để tránh rebuild không cần thiết
  static const List<Widget> _pages = <Widget>[
    Center(child: Icon(Icons.call,   size: 150)),
    Center(child: Icon(Icons.camera, size: 150)),
    Center(child: Icon(Icons.chat,   size: 150)),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomNavigationBar Demo')),

      // IndexedStack giữ các trang còn “sống” => state bên trong không mất
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        // Một số tuỳ biến bạn có thể bật khi cần:
        // backgroundColor: Colors.blueAccent, // đổi nền
        // elevation: 0,                       // bỏ bóng Material
        mouseCursor: SystemMouseCursors.grab,  // chỉ có tác dụng Web/Desktop
        // iconSize: 40,

        // selectedFontSize: 20,
        // selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 40),
        // selectedItemColor: Colors.amberAccent,
        // selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),

        // unselectedIconTheme: IconThemeData(color: Colors.deepOrangeAccent),
        // unselectedItemColor: Colors.deepOrangeAccent,

        // showSelectedLabels: false,
        // showUnselectedLabels: false,

        // Kiểu shifting (nhấn mạnh item đang chọn – Material 2):
        // type: BottomNavigationBarType.shifting,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.call),   label: 'Calls'),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Camera'),
          BottomNavigationBarItem(icon: Icon(Icons.chat),   label: 'Chats'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      
      ),
    );
  }
}
