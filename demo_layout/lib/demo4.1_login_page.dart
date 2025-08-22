import 'package:flutter/material.dart';

import 'demo4_login_page.dart';
import 'demo4.2_login_change_notifier_page.dart';
void main() => runApp(const Demo41LoginPage());

class Demo41LoginPage extends StatelessWidget {
  const Demo41LoginPage({super.key});

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
  // cần có TextEditingController vì để lấy dữ liệu trong text field
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _aliasController = TextEditingController();
  String _submittedFullname = "";
  String _submittedAlias = "";
  int _counter = 0;

  void _handleSubmit() {
    setState(() {
      
      _submittedFullname = _fullnameController.text;
      _submittedAlias = _aliasController.text;
      _counter++;
    });
    // một thông báo nhỏ dưới màn hình
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Hello, $_submittedFullname - $_submittedAlias")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page 4.1")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
              controller: _aliasController,
              decoration: const InputDecoration(
                hintText: "Alias",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text("Submit"),
            ),

            const SizedBox(height: 20),

            Text("Fullname: $_submittedFullname x($_counter)"),
            Text("Alias: $_submittedAlias x($_counter)"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Demo4LoginPage(),
                  ),
                );
              },
              child: const Text("Trang LoginPage gốc"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Demo42LoginPage(),
                  ),
                );
              },
              child: const Text("Trang 42 LoginPage ChangeNotifier"),
            ),
          ],
        ),
      ),
    );
  }
}
