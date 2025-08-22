import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

void main() => runApp(const Demo5LoginPage());

class Demo5LoginPage extends StatelessWidget {
  const Demo5LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginWidget(),
    );
  }
}

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({super.key});

  @override
  ConsumerState<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _aliasController = TextEditingController();

  void _handleSubmit() {
    ref.read(fullnameProvider.notifier).state = _fullnameController.text;
    ref.read(aliasProvider.notifier).state = _aliasController.text;
    ref.read(countProvider.notifier).state++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page 5.0")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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

            Consumer(
              builder: (context, ref, child) {
                final fullname = ref.watch(fullnameProvider);
                final alias = ref.watch(aliasProvider);
                final count = ref.watch(countProvider);
                return Column(
                  children: [
                    Text("Fullname: $fullname x($count)"),
                    Text("Alias: $alias x($count)"),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
              child: const Text("MENU"),
            ),
          ],
        ),
      ),
    );
  }
}

final fullnameProvider = AutoDisposeStateProvider<String>((ref) {
  return '...';
});
final aliasProvider = AutoDisposeStateProvider<String>((ref) {
  return '...';
});
final countProvider = AutoDisposeStateProvider<int>((ref) {
  return 0;
});
