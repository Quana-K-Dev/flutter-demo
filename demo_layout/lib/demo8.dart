import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const Demo8Route());

class Demo8Route extends StatelessWidget {
  const Demo8Route({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Demo8RouteWidget(),
    );
  }
}

class Demo8RouteWidget extends StatefulWidget {
  const Demo8RouteWidget({super.key});

  @override
  State<Demo8RouteWidget> createState() => _Demo8WidgetState();
}

class _Demo8WidgetState extends State<Demo8RouteWidget>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late final AnimationController _navBarVisibilityCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
    value: 1,
  );

  void _handleHideBottomNavBar(bool hide) {
    _navBarVisibilityCtrl.animateTo(hide ? 0 : 1);
  }

  late final List<Widget> _pages = <Widget>[
    const CallsPage(),
    const CameraPage(),
    ChatsPage(onHideBottomNavBar: _handleHideBottomNavBar),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  void dispose() {
    _navBarVisibilityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomNavigationBar Demo')),

      body: IndexedStack(index: _selectedIndex, children: _pages),

      bottomNavigationBar: SizeTransition(
        sizeFactor: _navBarVisibilityCtrl,
        axisAlignment: -1.0,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
            BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Camera'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          ],
        ),
      ),
    );
  }
}

final missedNoteProvider = StateProvider.autoDispose<String>(
  (ref) => '',
); 
// CallsPage
class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TabBar(
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 16),

                tabs: [
                  Tab(text: 'Incoming'),
                  Tab(text: 'Outgoing'),
                  Tab(text: 'Missed'),
                  Tab(text: 'Missssssed'),
                  Tab(text: 'Missssss2ed'),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _IncomingPage(),
            _OutgoingPage(),
            _MissedPage(),
            _MissssssedPage(),
            _Missssssed2Page(),
          ],
        ),
      ),
    );
  }
}

class _IncomingPage extends StatelessWidget {
  const _IncomingPage();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.call_received, size: 96));
  }
}

class _OutgoingPage extends StatelessWidget {
  const _OutgoingPage();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.call_made, size: 96));
  }
}

class _MissedPage extends StatelessWidget {
  const _MissedPage();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.call_missed, size: 96));
  }
}

class _MissssssedPage extends ConsumerStatefulWidget {
  const _MissssssedPage();

  @override
  ConsumerState<_MissssssedPage> createState() => _MissssssedPageState();
}

class _MissssssedPageState extends ConsumerState<_MissssssedPage> {
  final _textController = TextEditingController();

  void _submit() {
    final text = _textController.text;
    ref.read(missedNoteProvider.notifier).state = text;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Nhập nội dung để gửi sang tab Missssss2ed',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.send),
            label: const Text('Submit'),
          ),

          const SizedBox(height: 24),

          Consumer(
            builder: (context, ref, child) {
              final text = ref.watch(missedNoteProvider);
              return Text("Văn bản vừa được gửi đi là: $text");
            },
          ),
        ],
      ),
    );
  }
}

class _Missssssed2Page extends ConsumerWidget {
  const _Missssssed2Page();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(missedNoteProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Icon(Icons.call_missed, size: 96),
          const SizedBox(height: 16),
          Consumer(
            builder: (context, ref, child) => Text(
              value.isEmpty ? 'Chưa có dữ liệu nhận' : 'Đã nhận: $value',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
             )
          )
        ],
      ),
    );
  }
}

// CameraPage
class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.camera_alt, size: 120));
  }
}

// ChatsPage
class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key, required this.onHideBottomNavBar});

  final void Function(bool hide) onHideBottomNavBar;

  @override
  Widget build(BuildContext context) {
    final items = List.generate(60, (i) => 'Message #$i');

    bool _handleScroll(ScrollNotification n) {
      if (n.depth == 0 && n is UserScrollNotification) {
        switch (n.direction) {
          case ScrollDirection.forward:
            onHideBottomNavBar(false);
            break;
          case ScrollDirection.reverse:
            onHideBottomNavBar(true);
            break;
          case ScrollDirection.idle:
            break;
        }
      }
      return false;
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScroll,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (_, i) => ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(items[i]),
          subtitle: const Text('Tap to open chat...'),
        ),
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemCount: items.length,
      ),
    );
  }
}
