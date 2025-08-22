import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const Demo71BottomNavigationBar());

class Demo71BottomNavigationBar extends StatelessWidget {
  const Demo71BottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Demo71BottomNavigationBarWidget(),
    );
  }
}

class Demo71BottomNavigationBarWidget extends StatefulWidget {
  const Demo71BottomNavigationBarWidget({super.key});

  @override
  State<Demo71BottomNavigationBarWidget> createState() => _Demo71WidgetState();
}

class _Demo71WidgetState extends State<Demo71BottomNavigationBarWidget>
        // Dùng TickerProviderStateMixin để animate ẩn/hiện BottomNavigationBar
        with
        TickerProviderStateMixin {
  int _selectedIndex = 0;

  // Controller để ẩn/hiện thanh bottom bằng SizeTransition (0 -> ẩn, 1 -> hiện)
  late final AnimationController _navBarVisibilityCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
    value: 1,
  );

  // Callback truyền xuống trang con (ví dụ: ChatsPage) để báo ẩn/hiện
  void _handleHideBottomNavBar(bool hide) {
    // hide=true => thu nhỏ (0), hide=false => mở rộng (1)
    _navBarVisibilityCtrl.animateTo(hide ? 0 : 1);
  }

  // Danh sách trang (KHÔNG để const vì có trang cần callback)
  late final List<Widget> _pages = <Widget>[
    const CallsPage(), // Tab có TabBar bên trong
    const CameraPage(), // Trang đơn giản
    ChatsPage(
      onHideBottomNavBar: _handleHideBottomNavBar,
    ), // Trang có list dài & hide bottom khi cuộn
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

      // 2) (PHƯƠNG ÁN THAY THẾ - COMMENT): Stack + Offstage
      //    Ưu: Giữ state nhưng tab ẩn KHÔNG layout/paint -> nhẹ hơn IndexedStack.
      //    Nhược: vẫn giữ widget trong bộ nhớ.
      /*
      body: Stack(
        children: [
          Offstage(offstage: _selectedIndex != 0, child: const CallsPage()),
          Offstage(offstage: _selectedIndex != 1, child: const CameraPage()),
          Offstage(offstage: _selectedIndex != 2, child: ChatsPage(onHideBottomNavBar: _handleHideBottomNavBar)),
        ],
      ),
      */

      // 3) (PHƯƠNG ÁN THAY THẾ - COMMENT): PageView (lazy build) + AutomaticKeepAliveClientMixin
      //    Ưu: chỉ dựng trang khi cần, có thể giữ state tuỳ chọn.
      //    Nhược: nếu không dùng keepAlive thì rời tab có thể mất state UI.
      /*
      body: PageView(
        controller: _pageController, // khai báo PageController và đồng bộ _selectedIndex trong onPageChanged
        onPageChanged: (i) => setState(() => _selectedIndex = i),
        children: const [CallsPage(), CameraPage(), ChatsPage(onHideBottomNavBar: null)],
      ),
      */
      bottomNavigationBar: SizeTransition(
        sizeFactor: _navBarVisibilityCtrl, // 1 -> hiện, 0 -> ẩn
        axisAlignment: -1.0,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
            BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Camera'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          ],

          // backgroundColor: Colors.blueAccent,          // đổi màu nền
          // elevation: 0,                                // đổi độ nổi (mặc định 8)
          // iconSize: 28,                                // kích thước icon đồng loạt
          // mouseCursor: SystemMouseCursors.grab,        // con trỏ khi chạy web
          // showSelectedLabels: false,                   // ẩn label mục đang chọn
          // showUnselectedLabels: false,                 // ẩn label mục chưa chọn
          // selectedItemColor: Colors.amberAccent,       // màu item được chọn
          // unselectedItemColor: Colors.deepOrangeAccent,// màu item chưa chọn
          // selectedFontSize: 13,                        // font label khi chọn
          // selectedIconTheme: IconThemeData(size: 30),  // theme icon khi chọn
          // type: BottomNavigationBarType.shifting,      // nhấn mạnh item chọn (lưu ý: phù hợp khi mỗi item có bgColor riêng)
        ),
      ),
    );
  }
}

// CallsPage
class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, 
      child: Scaffold(
        appBar: AppBar(
          // TabBar đặt ở flexibleSpace để dính vào AppBar
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TabBar(
                isScrollable: true,
                // indicatorSize: TabBarIndicatorSize.label, // gạch chân bám theo label
                labelPadding: EdgeInsets.symmetric(horizontal: 16), // giãn khoảng cách

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
          children: [_IncomingPage(), _OutgoingPage(), _MissedPage(), _MissssssedPage(), _Missssssed2Page()],
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

class _MissssssedPage extends StatelessWidget {
  const _MissssssedPage();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.call_missed, size: 96));
  }
}

class _Missssssed2Page extends StatelessWidget {
  const _Missssssed2Page();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.call_missed, size: 96));
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
          case ScrollDirection
              .forward: // kéo xuống (hướng ngược) -> HIỆN thanh bottom
            onHideBottomNavBar(false);
            break;
          case ScrollDirection
              .reverse: // kéo lên (hướng thuận) -> ẨN thanh bottom
            onHideBottomNavBar(true);
            break;
          case ScrollDirection.idle: // Đứng yên
            break;
        }
      }
      return false; // không chặn sự kiện
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
