import 'package:flutter/material.dart';

import 'demo4_login_page.dart';
import 'demo4.2_login_notify_listeners.dart';

void main() => runApp(const Demo42LoginPage());

class Demo42LoginPage extends StatelessWidget {
  const Demo42LoginPage({super.key});

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
  
  // String _submittedFullname = "";
  // String _submittedAlias = "";
  // int _counter = 0;

  final LoginNotifier _loginNotifier = LoginNotifier();

  void _handleSubmit() {
    // setState(() {

    //   _submittedFullname = _fullnameController.text;
    //   _submittedAlias = _aliasController.text;
    //   _counter++;
    // });

    // một thông báo nhỏ dưới màn hình
    // ScaffoldMessenger.of(context).showSnackBar( KHÔNG NỀN SỬ DỤNG NÀY VÌ KHI BẤM VÀO TRONG SẼ THẤY NÓ ĐANG SỬ 
    //   SnackBar(
    //     content: Text(
    //       "Hello, ${_fullnameController.text} - ${_aliasController.text}",
    //     ),
    //   ),
    // );

    _loginNotifier.submit(
      _fullnameController.text,
      _aliasController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page 4.2")),

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

            // Text("Fullname: $_submittedFullname x($_counter)"),
            // Text("Alias: $_submittedAlias x($_counter)"),


            ListenableBuilder(
              listenable: _loginNotifier,
              builder: (context, child) {
                return Column(
                  children: [
                    Text(
                        "Fullname: ${_loginNotifier.fullname} x(${_loginNotifier.counter})"),
                    Text(
                        "Alias: ${_loginNotifier.alias} x(${_loginNotifier.counter})"),
                  ],
                );
              },
            ),
            ListenableBuilder(listenable: countNotifier, builder: (context, child) {
              return Text('Value changed: ${countNotifier.value}');
            },),

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
          ],
        ),
      ),
    );
  }
}
