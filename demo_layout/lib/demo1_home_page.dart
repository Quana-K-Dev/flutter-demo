import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'main.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const Demo1HomePage());
}

class Demo1HomePage extends StatelessWidget {
  const Demo1HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layouts & Widgets Demo',
      home: const LayoutDemoPage(),
    );
  }
}

class LayoutDemoPage extends StatelessWidget {
  const LayoutDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layouts & Widgets Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // GIÀN ĐIỀU RA stretch
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

            // 1. Row & Column cơ bản
            const RowColumnDemo(), // GỌI CLASS KIA
            const Divider(height: 32),

            // 2. Container
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Container Demo: padding, margin, border, background',
              ),
            ),

            // 3. SizedBox
            const SizedBox(height: 12),
            SizedBox(
              width: 200,
              height: 50,
              child: Container(
                color: Colors.green,
                child: const Center(child: Text('SizedBox 200×50')),
              ),
            ),

            // 4. Stack
            const SizedBox(height: 12),
            SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(color: Colors.orange),
                  const Text(
                    'Stack',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),

            // 5. GridView
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                  6,
                  (i) => Container(
                    margin: const EdgeInsets.all(4),
                    color: Colors.purple[(i + 1) * 100],
                  ),
                ),
              ),
            ),

            // 6. ListView
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  25,
                  (i) => Container(
                    width: 80,
                    margin: const EdgeInsets.all(4),
                    color: Colors.blue[(i + 1) * 100],
                    child: Center(child: Text('Item ${i + 1}')),
                  ),
                ),
              ),
            ),

            // 7. Card + ListTile
            const SizedBox(height: 12),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.album),
                title: const Text('ListTile Demo'),
                subtitle: const Text('with Card and shadow'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),

            // 8. Constraints (ConstrainedBox)
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 100,
                maxWidth: 200,
                minHeight: 50,
                maxHeight: 100,
              ),
              child: Container(
                color: Colors.red,
                child: const Center(child: Text('ConstrainedBox')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Demo chính: Row & Column với các alignment, Expanded, SizedBox
class RowColumnDemo extends StatelessWidget {
  const RowColumnDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '1. Row & Column Basic',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            // Cột bên trái: lồng 2 hàng
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // Hàng 1: 3 icon cách đều
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.star, size: 40, color: Colors.orange),
                      Icon(Icons.favorite, size: 40, color: Colors.red),
                      Icon(Icons.thumb_up, size: 40, color: Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Hàng 2: các alignment khác nhau
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Between'), Text('Between')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [Text('Start'), Text('Start')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [Text('End'), Text('End')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [Text('Around'), Text('Around')],
                  ),

                  const SizedBox(height: 16),
                  // Hàng ảnh với Expanded & flex
                  Row(
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://photo.znews.vn/w660/Uploaded/mdf_eioxrd/2021_07_06/2.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          'assets/images/pic2.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          'assets/images/pic3.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  // mainAxisSize.min
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.star, color: Colors.green),
                      Icon(Icons.star, color: Colors.green),
                      Icon(Icons.star, color: Colors.green),
                      Icon(Icons.star_border, color: Colors.black),
                      Icon(Icons.star_border, color: Colors.black),
                      Text('Wana'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // Phần bên phải: logo
            Expanded(flex: 1, child: Center(child: FlutterLogo(size: 100))),
          ],
        ),
      ],
    );
  }
}
