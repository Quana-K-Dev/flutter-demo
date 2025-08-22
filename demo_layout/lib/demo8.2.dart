import 'package:flutter/material.dart';

void main() => runApp(const DemoNavAllApp());

class Routes {
  static const home     = '/';
  static const screen1  = '/screen1';
  static const screen2  = '/screen2';
  static const detail   = '/detail';   // nhận arguments bằng onGenerateRoute
  static const splash   = '/splash';   // demo pushReplacement
  static const login    = '/login';    // demo pushNamedAndRemoveUntil (logout)
  static const form     = '/form';     // demo trả data từ B về A
  static const list     = '/list';     // demo popAndPushNamed (filter -> list)
  static const filter   = '/filter';   // demo popAndPushNamed
  static const step1    = '/step1';    // demo popUntil
  static const step2    = '/step2';
  static const step3    = '/step3';    // tạo route động bằng onGenerateRoute
  static const confirm  = '/confirm';  // demo WillPopScope + maybePop
}

class DemoNavAllApp extends StatelessWidget {
  const DemoNavAllApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// Có thể dùng initialRoute thay vì home
      initialRoute: Routes.home,

      /// 1) routes tĩnh: tiện, ngắn gọn
      routes: {
        Routes.home:   (_) => const HomeMenuPage(),
        Routes.screen1: (_) => const Screen1(title: 'Screen1 (direct push demo)'),
        Routes.screen2: (_) => const Screen2(),
        Routes.splash:  (_) => const SplashPage(),
        Routes.login:   (_) => const LoginPage(),
        Routes.form:    (_) => const FormPage(),
        Routes.list:    (_) => const ListPage(),
        Routes.filter:  (_) => const FilterPage(),
        Routes.step1:   (_) => const Step1Page(),
        Routes.step2:   (_) => const Step2Page(),
        Routes.confirm: (_) => const ConfirmExitPage(),
      },

      /// 2) onGenerateRoute: linh hoạt (nhận arguments/constructor tuỳ ý)
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.detail:
            // nhận arguments (có thể là String/Map/Object tuỳ bạn)
            final args = settings.arguments as DetailArgs?;
            return MaterialPageRoute(
              builder: (_) => DetailPage(args: args ?? const DetailArgs(id: 0, note: 'No args')),
              settings: settings,
            );

          case Routes.step3:
            final stepLabel = settings.arguments as String? ?? 'Step 3';
            return MaterialPageRoute(
              builder: (_) => Step3Page(label: stepLabel),
              settings: settings,
            );

          default:
            // Fallback cho route lạ
            return MaterialPageRoute(builder: (_) => const HomeMenuPage());
        }
      },
    );
  }
}

/// =====================
///      HOME MENU
/// =====================
class HomeMenuPage extends StatelessWidget {
  const HomeMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = <_MenuItem>[
      _MenuItem(
        title: '1) push (direct) & pop return',
        subtitle: 'Navigator.push(context, MaterialPageRoute(...))',
        onTap: () async {
          // PUSH (direct) + chờ dữ liệu trả về từ Screen1
          final result = await Navigator.push<String?>(
            context,
            MaterialPageRoute(
              builder: (ctx) => const Screen1(title: 'Pushed directly (Screen1)'),
              settings: const RouteSettings(name: Routes.screen1),
            ),
          );
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Result from Screen1: ${result ?? "(null)"}')),
            );
          }
        },
      ),
      _MenuItem(
        title: '2) pushNamed (static route)',
        subtitle: 'Navigator.pushNamed(context, Routes.screen2)',
        onTap: () => Navigator.pushNamed(context, Routes.screen2),
      ),
      _MenuItem(
        title: '3) pushNamed + arguments (dynamic)',
        subtitle: 'onGenerateRoute -> /detail',
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.detail,
            arguments: const DetailArgs(id: 42, note: 'Sent from HomeMenu'),
          );
        },
      ),
      _MenuItem(
        title: '4) Trả dữ liệu từ B về A',
        subtitle: 'await Navigator.push(...) -> pop(context, result)',
        onTap: () async {
          final result = await Navigator.pushNamed<String?>(context, Routes.form);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Form result: ${result ?? "(cancel)"}')),
            );
          }
        },
      ),
      _MenuItem(
        title: '5) pushReplacement (Splash -> Home)',
        subtitle: 'Trong Splash bấm “Tiếp tục” sẽ pushReplacement về Home',
        onTap: () => Navigator.pushNamed(context, Routes.splash),
      ),
      _MenuItem(
        title: '6) pushNamedAndRemoveUntil (Logout)',
        subtitle: 'Đi tới Login & xoá sạch stack',
        onTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        ),
      ),
      _MenuItem(
        title: '7) popAndPushNamed (Filter -> List)',
        subtitle: 'Áp filter rồi pop & push List',
        onTap: () => Navigator.pushNamed(context, Routes.list),
      ),
      _MenuItem(
        title: '8) popUntil (Quay về Step1)',
        subtitle: 'Step1 -> Step2 -> Step3 rồi popUntil Step1',
        onTap: () => Navigator.pushNamed(context, Routes.step1),
      ),
      _MenuItem(
        title: '9) WillPopScope + maybePop',
        subtitle: 'Chặn nút back, xác nhận thoát',
        onTap: () => Navigator.pushNamed(context, Routes.confirm),
      ),
      _MenuItem(
        title: '10) ModalRoute info (name/arguments)',
        subtitle: 'Xem name hiện tại với ModalRoute.of(context)',
        onTap: () {
          final name = ModalRoute.of(context)?.settings.name ?? '(unknown)';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Current route name: $name')),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Navigator — Full Demo')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (_, i) {
          final m = tiles[i];
          return ListTile(
            title: Text(m.title),
            subtitle: Text(m.subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: m.onTap,
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemCount: tiles.length,
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  _MenuItem({required this.title, required this.subtitle, required this.onTap});
}

/// =====================
///   1) push / pop
/// =====================
class Screen1 extends StatelessWidget {
  const Screen1({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name ?? '(no name)';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('This is Screen1\nRoute: $routeName', textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context, 'Hello from Screen1'),
            icon: const Icon(Icons.reply),
            label: const Text('pop(context, result)'),
          ),
        ]),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen2 (pushNamed)')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Back'),
        ),
      ),
    );
  }
}

/// ===============================
///  3) pushNamed + arguments demo
/// ===============================
class DetailArgs {
  final int id;
  final String note;
  const DetailArgs({required this.id, required this.note});
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.args});
  final DetailArgs args;

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name ?? '(no name)';
    return Scaffold(
      appBar: AppBar(title: const Text('Detail (onGenerateRoute)')),
      body: Center(
        child: Text('id = ${args.id}\nnote = ${args.note}\nroute = $routeName',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// ======================================
///  4) Trả data từ B về A bằng pop(result)
/// ======================================
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
    return Scaffold(
      appBar: AppBar(title: const Text('FormPage (return data)')),
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
                  onPressed: () => Navigator.pop(context, _controller.text),
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

/// =======================================
///  5) pushReplacement (Splash -> Home)
/// =======================================
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushReplacementNamed(context, Routes.home),
          child: const Text('Tiếp tục (pushReplacement -> Home)'),
        ),
      ),
    );
  }
}

/// =======================================
///  6) pushNamedAndRemoveUntil (Logout)
/// =======================================
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login (stack đã bị xoá sạch)')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, Routes.home),
          child: const Text('Đăng nhập xong -> Home'),
        ),
      ),
    );
  }
}

/// =======================================
///  7) popAndPushNamed (Filter -> List)
/// =======================================
class ListPage extends StatelessWidget {
  const ListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)?.settings.name ?? '(no name)';
    return Scaffold(
      appBar: AppBar(title: const Text('ListPage')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Route: $name', textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.filter),
            child: const Text('Mở FilterPage'),
          ),
        ]),
      ),
    );
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FilterPage')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // pop filter hiện tại rồi push sang list mới
            Navigator.popAndPushNamed(context, Routes.list);
          },
          child: const Text('Apply -> popAndPushNamed(ListPage)'),
        ),
      ),
    );
  }
}

/// =======================================
///  8) popUntil (Quay lại Step1)
/// =======================================
class Step1Page extends StatelessWidget {
  const Step1Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step1')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, Routes.step2),
          child: const Text('Go -> Step2'),
        ),
      ),
    );
  }
}

class Step2Page extends StatelessWidget {
  const Step2Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step2')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(
            context,
            Routes.step3,
            arguments: 'Step 3 (dynamic route)',
          ),
          child: const Text('Go -> Step3 (dynamic)'),
        ),
      ),
    );
  }
}

class Step3Page extends StatelessWidget {
  const Step3Page({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final current = ModalRoute.of(context)?.settings.name ?? '(no name)';
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Route: $current'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // pop về đúng route name Step1
              Navigator.popUntil(context, ModalRoute.withName(Routes.step1));
            },
            child: const Text('popUntil -> Step1'),
          ),
        ]),
      ),
    );
  }
}

/// ===================================================
///  9) WillPopScope + maybePop + canPop + ModalRoute
/// ===================================================
class ConfirmExitPage extends StatelessWidget {
  const ConfirmExitPage({super.key});

  Future<bool> _onBackPressed(BuildContext context) async {
    // maybePop: nếu có thể pop thì pop, nếu không thì trả false
    if (Navigator.canPop(context)) {
      // cho phép hiển thị dialog xác nhận
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
        // pop chính trang này
        Navigator.maybePop(context);
      }
      return false; // chặn back mặc định (đã xử lý thủ công)
    }
    return true; // không thể pop, cho hệ thống xử lý (thoát app nếu là root)
  }

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)?.settings.name ?? '(no name)';
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(title: const Text('Confirm Exit (WillPopScope)')),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('Route: $name'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _onBackPressed(context),
              child: const Text('Nhấn Back (giống hệ thống)'),
            ),
          ]),
        ),
      ),
    );
  }
}
