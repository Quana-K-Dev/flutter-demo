import 'package:flutter/material.dart';
import 'main.dart';

void main() {
  runApp(const Demo2StackPage());
}

class Demo2StackPage extends StatelessWidget {
  const Demo2StackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StackExample(),
    );
  }
}

class StackExample extends StatelessWidget {
  const StackExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stack + Row Demo"), centerTitle: true),
      body: Column(
        children: [
          // ======= Nút MENU full chiều ngang =======
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("MENU", style: TextStyle(fontSize: 18)),
            ),
          ),

          // ======= Stack ở giữa màn hình =======
          Expanded(
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Ô đỏ
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                    child: const Center(
                      child: Text("Red", style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  // Ô tím
                  Positioned(
                    left: 30,
                    top: 30,
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.purple,
                      child: const Center(
                        child: Text(
                          "Purple",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  // Ô vàng
                  Positioned(
                    left: 60,
                    top: 60,
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.yellow,
                      child: const Center(child: Text("Yellow")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
