import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

void main() => runApp(const Demo6());

class Demo6 extends StatelessWidget {
  const Demo6({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Demo6Widget(),
    );
  }
}

class Demo6Widget extends ConsumerStatefulWidget {
  const Demo6Widget({super.key});

  @override
  ConsumerState<Demo6Widget> createState() => _Demo6WidgetState();
}

class Student {
  final String firstName;
  final String lastName;
  final String phoneNo;

  Student(this.firstName, this.lastName, this.phoneNo);
}

final studentProvider = AutoDisposeStateProvider<Student>((ref) {
  return Student("---", "---", "(+84)---");
});

class _Demo6WidgetState extends ConsumerState<Demo6Widget> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phonenoController = TextEditingController();

  void _handleSubmit() {
    ref.read(studentProvider.notifier).state = Student(
      _firstnameController.text,
      _lastnameController.text,
      _phonenoController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page 6.0")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstnameController,
              decoration: InputDecoration(
                hintText: "Fitst Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _lastnameController,
              decoration: const InputDecoration(
                hintText: "Last Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _phonenoController,
              decoration: const InputDecoration(
                hintText: "Phone",
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
              builder: (context, ref, _) {
                final firstname = ref.watch(
                  studentProvider.select((s) => s.firstName),
                );
                return Text('First Name: $firstname');
              },
            ),

            Consumer(
              builder: (context, ref, _) {
                final lastname = ref.watch(
                  studentProvider.select((s) => s.lastName),
                );
                return Text('Last Name:  $lastname');
              },
            ),

            Consumer(
              builder: (context, ref, _) {
                final student = ref.watch(studentProvider);
                return Text('Phone: ${student.phoneNo}');
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
