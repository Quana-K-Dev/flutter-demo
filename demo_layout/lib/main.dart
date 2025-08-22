import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demo_layout/src/modules/dashboard/presentation/app/app_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'demo1_home_page.dart';
import 'demo2_stack_page.dart';
import 'demo3_counter_page.dart';
import 'demo4_login_page.dart';
import 'demo5_riverpod_2.0.dart';
import 'demo6.dart';
import 'demo7_bottom_navigation_bar.dart';
import 'demo7.1.dart';
import 'demo8.dart';

import 'demo8.2.dart';
import 'demo8.3.dart';
import 'src/modules/dashboard/presentation/app/app_route.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Colors.blue,
      //     brightness: Brightness.dark,
      //   ),
      // ),

      routerConfig: AppRouter().config(),
    );
  }
}

@RoutePage()
class WellcomePage extends StatelessWidget {
  const WellcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trang chính")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Nhấn nút bên dưới để chuyển trang",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  context.router.push(DashboardRoute());
                },
                child: const Text("DDD - 18/08"),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Demo1HomePage()),
                  );
                },
                child: const Text("Trang HomePage 07/08/25"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Demo2StackPage()),
                  );
                },
                child: const Text("Trang StackPage 08/08/25"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Demo3CounterPage()),
                  );
                },
                child: const Text("Trang CounterPage 11/08/25"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Demo4LoginPage()),
                  );
                },
                child: const Text("Trang LoginPage 11/08/25"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Demo5LoginPage()),
                  );
                },
                child: const Text("Trang Riverpod 12/08/25"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Demo6()),
                  );
                },
                child: const Text("Trang Riverpod 14/08/25"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Demo7BottomNavigationBar(),
                    ),
                  );
                },
                child: const Text("Trang Bottom navigation bar 14/08/25"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Demo71BottomNavigationBar(),
                    ),
                  );
                },
                child: const Text("Trang Bottom Nav Bar 7.1 14/08/25"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Demo8Route()),
                  );
                },
                child: const Text("Trang Demo 8 18/08/25"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DemoNavAllApp()),
                  );
                },
                child: const Text("Trang Demo 8.2 18/08/25"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Demo83RouteTab()),
                  );
                },
                child: const Text("Trang Demo 8.3 18/08/25"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
