import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const Demo83RouteTab());

class Routes {
  static const detail  = '/detail';   // pushNamed + arguments
  static const form    = '/form';     // push -> pop(result) trả data
  static const login   = '/login';    // pushNamedAndRemoveUntil (logout)
  static const confirm = '/confirm';  // WillPopScope + maybePop
}

class Demo83RouteTab extends StatelessWidget {
  const Demo83RouteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        Routes.login:   (_) => const LoginPage(),
        Routes.form:    (_) => const FormPage(),     
        Routes.confirm: (_) => const ConfirmExitPage(), 
      },

      /// argument
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.detail:
            final args = settings.arguments as DetailArgs?;
            return MaterialPageRoute(
              builder: (_) => DetailPage(
                args: args ?? const DetailArgs(title: 'No args', note: '(empty)'),
              ),
              settings: settings,
            );
          default:
            return null; // dùng routes tĩnh hoặc fallback mặc định
        }
      },

      /// Home là shell có BottomNavigationBar + IndexedStack
      home: const Demo81RouteTabWidget(),
    );
  }
}

class Demo81RouteTabWidget extends StatefulWidget {
  const Demo81RouteTabWidget({super.key});

  @override
  State<Demo81RouteTabWidget> createState() => _Demo81WidgetState();
}

class _Demo81WidgetState extends State<Demo81RouteTabWidget>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  // Ẩn/hiện BottomNavigationBar khi cuộn (demo ChatsPage)
  late final AnimationController _navBarVisibilityCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
    value: 1,
  );

  void _handleHideBottomNavBar(bool hide) {
    _navBarVisibilityCtrl.animateTo(hide ? 0 : 1);
  }

  // Các trang trong IndexedStack
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
      appBar: AppBar(
        title: const Text('BottomNavigationBar + Navigator demo'),
        actions: [
          // DEMO: mở trang Confirm (WillPopScope + maybePop)
          IconButton(
            tooltip: 'Confirm back',
            onPressed: () => Navigator.pushNamed(context, Routes.confirm),
            icon: const Icon(Icons.privacy_tip),
          ),
          // DEMO: Logout -> pushNamedAndRemoveUntil xoá sạch stack
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      // IndexedStack giữ state của từng tab
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

/* ================== RIVERPOD PROVIDER DÙNG CHUNG ================== */
// Ghi ở _MissssssedPage, đọc ở _Missssssed2Page, CameraPage, v.v.
final missedNoteProvider = StateProvider.autoDispose<String>((ref) => '');

/* ================== CALLS TAB (kèm TabBar) ================== */
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
            _MissssssedPage(),   // có TextField + Submit (ghi vào provider)
            _Missssssed2Page(),  // đọc provider + demo mở Form lấy data
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
    final text = _textController.text.trim();
    ref.read(missedNoteProvider.notifier).state = text;

    // DEMO: đẩy sang trang chi tiết bằng pushNamed + arguments (nếu muốn)
    // Navigator.pushNamed(
    //   context,
    //   Routes.detail,
    //   arguments: DetailArgs(title: 'Missssssed Detail', note: text),
    // );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '(no name)';
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Route: $currentRoute'),
          const SizedBox(height: 8),
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
            label: const Text('Submit (ghi vào provider)'),
          ),
          const SizedBox(height: 24),
          Consumer(
            builder: (context, ref, _) {
              final text = ref.watch(missedNoteProvider);
              return Text("Giá trị hiện tại trong provider: $text");
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
          Text(
            value.isEmpty ? 'Chưa có dữ liệu nhận' : 'Đã nhận: $value',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // DEMO: mở FormPage để lấy dữ liệu trả về (pop(result))
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.pushNamed<String?>(context, Routes.form);
              if (result != null && result.isNotEmpty && context.mounted) {
                ref.read(missedNoteProvider.notifier).state = result;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Form trả về: $result')),
                );
              }
            },
            child: const Text('Mở Form (pushNamed) & nhận result'),
          ),
        ],
      ),
    );
  }
}

/* ================== CAMERA TAB ================== */
class CameraPage extends ConsumerWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final note = ref.watch(missedNoteProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.camera_alt, size: 96),
          const SizedBox(height: 12),
          Text(
            note.isEmpty ? 'Note trống' : 'Note hiện tại: $note',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),

          // DEMO: pushNamed + arguments sang trang Detail
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.detail,
                arguments: DetailArgs(
                  title: 'Camera Detail',
                  note: note.isEmpty ? '(no note)' : note,
                ),
              );
            },
            child: const Text('Mở Detail (pushNamed + args)'),
          ),
        ],
      ),
    );
  }
}

/* ================== CHATS TAB (ẩn/hiện bottom khi cuộn) ================== */
class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key, required this.onHideBottomNavBar});

  final void Function(bool hide) onHideBottomNavBar;

  @override
  Widget build(BuildContext context) {
    final items = List.generate(60, (i) => 'Message #$i');

    bool _handleScroll(ScrollNotification n) {
      if (n.depth == 0 && n is UserScrollNotification) {
        switch (n.direction) {
          case ScrollDirection.forward: // kéo xuống -> hiện
            onHideBottomNavBar(false);
            break;
          case ScrollDirection.reverse: // kéo lên -> ẩn
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
          onTap: () {
            // DEMO: mở trang xác nhận (WillPopScope) từ Chats
            Navigator.pushNamed(context, Routes.confirm);
          },
        ),
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemCount: items.length,
      ),
    );
  }
}

/* ================== CÁC MÀN ROUTE BỔ TRỢ ================== */

/// Detail page nhận arguments qua pushNamed
class DetailArgs {
  final String title;
  final String note;
  const DetailArgs({required this.title, required this.note});
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.args});
  final DetailArgs args;

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name ?? '(no name)';
    return Scaffold(
      appBar: AppBar(title: Text(args.title)),
      body: Center(
        child: Text('Route: $routeName\nNote: ${args.note}', textAlign: TextAlign.center),
      ),
    );
  }
}

/// Form page: nhập và pop(context, result) để trả dữ liệu về trang gọi
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _controller = TextEditingController();

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context)?.settings.name ?? '(no name)';
    return Scaffold(
      appBar: AppBar(title: Text('FormPage ($route)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Nhập gì đó để trả về',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: const Text('Huỷ'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _controller.text.trim()),
                  child: const Text('Gửi về (pop result)'),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

/// Login page: được mở bằng pushNamedAndRemoveUntil (xoá stack)
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)?.settings.name ?? '(no name)';
    return Scaffold(
      appBar: AppBar(title: Text('Login ($name)')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Sau khi “đăng nhập”, quay về shell (home) — ở đây dùng pop + pushNamed tuỳ flow thực tế
            Navigator.pop(context); // đóng Login
          },
          child: const Text('Đăng nhập xong (đóng trang)'),
        ),
      ),
    );
  }
}

/// WillPopScope: chặn nút back, confirm thoát
class ConfirmExitPage extends StatelessWidget {
  const ConfirmExitPage({super.key});

  Future<bool> _onBackPressed(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Thoát trang?'),
        content: const Text('Bạn có chắc muốn quay lại không?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Ở lại')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Quay lại')),
        ],
      ),
    );
    if (ok == true) {
      // Cho phép pop
      return true;
    }
    // Chặn back
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)?.settings.name ?? '(no name)';
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(title: Text('Confirm ($name)')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final can = await _onBackPressed(context);
              if (can && context.mounted) Navigator.maybePop(context);
            },
            child: const Text('Thử Back (giống hệ thống)'),
          ),
        ),
      ),
    );
  }
}
