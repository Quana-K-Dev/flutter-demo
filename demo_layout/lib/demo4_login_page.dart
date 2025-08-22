import 'package:flutter/material.dart';

import 'demo4.1_login_page.dart';
import 'main.dart';

void main() => runApp(const Demo4LoginPage());

class Demo4LoginPage extends StatelessWidget {
  const Demo4LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginWidget(),
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _aliastController = TextEditingController();
  String _submittedFullname = "";
  String _submittedAlias = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page 4.0")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
              child: const Text("MENU"),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _fullnameController,
              decoration: InputDecoration(
                hintText: "Full name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _aliastController,
              decoration: const InputDecoration(
                hintText: "Alias",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  // CÓ THỂ CẮT RA THÀNH FUNTION RIÊNG NHƯ DEMO 3
                  _submittedFullname = _fullnameController.text;
                  _submittedAlias = _aliastController.text;
                });
                // một thông báo nhỏ dưới màn hình
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Hello, $_submittedFullname - $_submittedAlias",
                    ),
                  ),
                );
              },
              child: const Text("Submit"),
            ),

            Text("Fullname: $_submittedFullname"),
            Text("Alias: $_submittedAlias"),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Demo41LoginPage(),
                  ),
                );
              },
              child: const Text("Trang 4.1 LoginPage FormatCode"),
            ),
          ],
        ),
      ),
    );
  }
}
