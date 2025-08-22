import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:demo_layout/src/modules/dashboard/presentation/app/app_route.gr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MessagesListBody extends ConsumerWidget {
  const MessagesListBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const colorBrIconBrand = Color(0xFFC1D8FC);
    const borderColor = Color(0xFFE5E7EB);

    // Phần avatar
    const colorBrIconSimple = LinearGradient(
      colors: [Color(0xFF0C2C5B), Color(0xFF2866C4)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    // buttom
    const colorTxtSimple = Color(0xFFF1F2F3);
    const colorBrBtnDecline = Color(0xFFFBCDD4);
    const colorTxtDecline = Color(0xFFE53044);

    const double widthIcon = 40;
    const double heightIcon = 40;
    const double widthButton = 100;
    const double heightButton = 36;

    // Phần text
    const font1 = FontWeight.bold;
    const font2 = FontWeight.w600;
    const font3 = FontWeight.w500;
    const font4 = FontWeight.w400;

    const double fontSizeBasic = 14;
    const double fontSizeSmall = 12;

    const colorTxtPrimary = Color(0xFF122357);
    const colorTxtSecondary = Color(0xFF626576);

    // Cách1
    Widget buildInvitationRow(String avatar) {
      bool _isNetworkUrl(String s) {
        final u = Uri.tryParse(s);
        return u != null &&
            (u.scheme == 'http' || u.scheme == 'https') &&
            u.host.isNotEmpty;
      }

      bool _looksLikeImage(String s) => RegExp(
        r'\.(png|jpe?g|gif|webp|bmp|svg)$',
        caseSensitive: false,
      ).hasMatch(s);

      bool _isAssetPath(String s) =>
          s.startsWith('assets/') || s.startsWith('images/');
      bool _isFilePath(String s) =>
          s.startsWith('/') ||
          s.contains(r':\') ||
          s.startsWith('file://'); // unix / win / file://

      String getInitials(String s) {
        final parts = s
            .trim()
            .split(RegExp(r'\s+'))
            .where((e) => e.isNotEmpty)
            .toList();
        if (parts.isEmpty) return '';
        final first = parts[0][0].toUpperCase();
        final second = parts.length > 1 ? parts[1][0].toUpperCase() : '';
        return '$first$second';
      }

      switch (avatar) {
        case "TM":
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor, width: 0.5),
                bottom: BorderSide(color: borderColor, width: 0.5),
              ),
            ),

            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  width: widthIcon,
                  height: heightIcon,

                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: colorBrIconSimple,
                  ),

                  child: Center(
                    child: Text(
                      avatar, // avatar
                      style: TextStyle(
                        color: colorTxtSimple,
                        fontWeight: font1,
                        fontSize: fontSizeBasic,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: fontSizeBasic),

                          children: [
                            TextSpan(
                              text: 'Abby',
                              style: const TextStyle(
                                color: colorTxtPrimary,
                                fontWeight: font1,
                              ),
                            ),

                            const TextSpan(
                              text: ' wants to join ',
                              style: TextStyle(
                                color: colorTxtSecondary,
                                fontWeight: font3,
                              ),
                            ),

                            TextSpan(
                              text: 'ABC team',
                              style: const TextStyle(
                                color: colorTxtPrimary,
                                fontWeight: font1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Container(
                            width: widthButton,
                            height: heightButton,
                            alignment: Alignment.center,

                            decoration: BoxDecoration(
                              color: colorTxtPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Accept',
                              style: TextStyle(
                                color: colorTxtSimple,
                                fontWeight: font4,
                                fontSize: fontSizeSmall,
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Container(
                            width: widthButton,
                            height: heightButton,
                            alignment: Alignment.center,

                            decoration: BoxDecoration(
                              color: colorBrBtnDecline,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Decline',
                              style: TextStyle(
                                color: colorTxtDecline,
                                fontWeight: font4,
                                fontSize: fontSizeSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Text(
                  'Now',
                  style: const TextStyle(
                    color: colorTxtSecondary,
                    fontSize: 12,
                    fontWeight: font4,
                  ),
                ),
              ],
            ),
          );
        default:
          return const SizedBox();
      }
    }

    Widget buildSimpleNotification(
      String text,
      String time,
      Color bgColor,
      Widget icon,
    ) {
      return Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: borderColor, width: 1)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
              child: icon,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: fontSizeBasic,
                  height: 1.4,
                  color: colorTxtPrimary,
                  fontWeight: font3,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              time,
              style: const TextStyle(
                color: colorTxtSecondary,
                fontSize: 12,
                fontWeight: font4,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildEventChangeNotification() {
      return Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: borderColor, width: 1)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[100],
                  ),
                  child: const Icon(
                    Icons.calendar_month,
                    color: colorBrIconBrand,
                    size: 20,
                  ),
                ),
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: borderColor),
                    ),
                    child: const Icon(
                      Icons.schedule,
                      color: colorBrIconBrand,
                      size: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, height: 1.4),
                  children: [
                    TextSpan(
                      text: 'Robert',
                      style: const TextStyle(
                        color: colorTxtPrimary,
                        fontWeight: font1,
                      ),
                    ),
                    const TextSpan(
                      text: ' changed time event ',
                      style: TextStyle(
                        color: colorTxtSecondary,
                        fontWeight: font3,
                      ),
                    ),
                    TextSpan(
                      text: 'ABC team',
                      style: const TextStyle(
                        color: colorTxtPrimary,
                        fontWeight: font1,
                      ),
                    ),
                    const TextSpan(
                      text: ' at Monday, 7:00AM . 2025.12.12',
                      style: TextStyle(
                        color: colorTxtSecondary,
                        fontWeight: font3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '9h ago',
              style: const TextStyle(
                color: colorTxtSecondary,
                fontSize: 12,
                fontWeight: font4,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildCancelEventNotification() {
      return Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: borderColor, width: 1)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[100],
                  ),
                  child: const Icon(
                    Icons.calendar_month,
                    color: colorBrIconBrand,
                    size: 20,
                  ),
                ),
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorTxtDecline,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, height: 1.4),
                  children: [
                    TextSpan(
                      text: 'Robert',
                      style: const TextStyle(
                        color: colorTxtPrimary,
                        fontWeight: font1,
                      ),
                    ),
                    const TextSpan(
                      text: ' cancel event ',
                      style: TextStyle(
                        color: colorTxtSecondary,
                        fontWeight: font3,
                      ),
                    ),
                    TextSpan(
                      text: 'ABC team',
                      style: const TextStyle(
                        color: colorTxtPrimary,
                        fontWeight: font1,
                      ),
                    ),
                    const TextSpan(
                      text: ' at Monday, 7:00AM . 2025.12.12',
                      style: TextStyle(
                        color: colorTxtSecondary,
                        fontWeight: font3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '10 ago',
              style: const TextStyle(
                color: colorTxtSecondary,
                fontSize: 12,
                fontWeight: font4,
              ),
            ),
          ],
        ),
      );
    }

    // Cách 2
    Widget buildInvitationRow2(String avatar) {
      bool _isNetworkUrl(String s) {
        final u = Uri.tryParse(s);
        return u != null &&
            (u.scheme == 'http' || u.scheme == 'https') &&
            u.host.isNotEmpty;
      }

      bool _looksLikeImage(String s) => RegExp(
        r'\.(png|jpe?g|gif|webp|bmp|svg)$',
        caseSensitive: false,
      ).hasMatch(s);

      bool _isAssetPath(String s) =>
          s.startsWith('assets/') || s.startsWith('images/');
      bool _isFilePath(String s) =>
          s.startsWith('/') ||
          s.contains(r':\') ||
          s.startsWith('file://'); // unix / win / file://

      String getInitials(String s) {
        final parts = s
            .trim()
            .split(RegExp(r'\s+'))
            .where((e) => e.isNotEmpty)
            .toList();
        if (parts.isEmpty) return '';
        final first = parts[0][0].toUpperCase();
        final second = parts.length > 1 ? parts[1][0].toUpperCase() : '';
        return '$first$second';
      }

      Widget _avatarCircleWithText(String textAvtIcon) {
        return Container(
          width: widthIcon,
          height: heightIcon,

          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: colorBrIconSimple,
          ),

          alignment: Alignment.center,
          child: Text(
            textAvtIcon,
            style: const TextStyle(
              color: colorTxtSimple,
              fontWeight: font1,
              fontSize: fontSizeBasic,
            ),
          ),
        );
      }

      Widget _avatarCircleWithImage(ImageProvider provider) {
        return Container(
          width: widthIcon,
          height: heightIcon,

          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: colorBrIconBrand,
          ),
          alignment: Alignment.center,

          clipBehavior: Clip.antiAlias,
          child: Image(
            image: provider,

            width: 25.83,
            height: 25.83,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,

            errorBuilder: (_, __, ___) => _avatarCircleWithText('?'),
          ),
        );
      }

      Widget _avatarCircleWithIcon(IconData icon, {Color? color}) {
        return Container(
          width: widthIcon,
          height: heightIcon,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: colorBrBtnDecline,
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 24, color: color ?? colorTxtDecline),
        );
      }

      // Widget _rowShell(Widget leading) {
      //   return Container(
      //     decoration: const BoxDecoration(
      //       border: Border(
      //         top: BorderSide(color: borderColor, width: 0.5),
      //         bottom: BorderSide(color: borderColor, width: 0.5),
      //       ),
      //     ),
      //     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         leading,
      //         const SizedBox(width: 14),
      //         Expanded(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               RichText(
      //                 text: const TextSpan(
      //                   style: TextStyle(fontSize: fontSizeBasic),
      //                   children: [
      //                     TextSpan(
      //                       text: 'Abby',
      //                       style: TextStyle(
      //                         color: colorTxtPrimary,
      //                         fontWeight: font1,
      //                       ),
      //                     ),
      //                     TextSpan(
      //                       text: ' wants to join ',
      //                       style: TextStyle(
      //                         color: colorTxtSecondary,
      //                         fontWeight: font3,
      //                       ),
      //                     ),
      //                     TextSpan(
      //                       text: 'ABC team',
      //                       style: TextStyle(
      //                         color: colorTxtPrimary,
      //                         fontWeight: font1,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               const SizedBox(height: 6),
      //               // Row(
      //               //   children: [
      //               //     Container(
      //               //       width: widthButton,
      //               //       height: heightButton,
      //               //       alignment: Alignment.center,
      //               //       decoration: BoxDecoration(
      //               //         color: colorTxtPrimary,
      //               //         borderRadius: BorderRadius.circular(20),
      //               //       ),
      //               //       child: const Text(
      //               //         'Accept',
      //               //         style: TextStyle(
      //               //           color: colorTxtSimple,
      //               //           fontWeight: font4,
      //               //           fontSize: fontSizeSmall,
      //               //         ),
      //               //       ),
      //               //     ),
      //               //     const SizedBox(width: 8),
      //               //     Container(
      //               //       width: widthButton,
      //               //       height: heightButton,
      //               //       alignment: Alignment.center,
      //               //       decoration: BoxDecoration(
      //               //         color: colorBrBtnDecline,
      //               //         borderRadius: BorderRadius.circular(20),
      //               //       ),
      //               //       child: const Text(
      //               //         'Decline',
      //               //         style: TextStyle(
      //               //           color: colorTxtDecline,
      //               //           fontWeight: font4,
      //               //           fontSize: fontSizeSmall,
      //               //         ),
      //               //       ),
      //               //     ),
      //               //   ],
      //               // ),
      //             ],
      //           ),
      //         ),
      //         const Text(
      //           'Now',
      //           style: TextStyle(
      //             color: colorTxtSecondary,
      //             fontSize: 12,
      //             fontWeight: font4,
      //           ),
      //         ),
      //       ],
      //     ),
      //   );
      // }
      
      Widget _actionButtons(String primaryText) {
        return Row(
          children: [
            Container(
              width: widthButton,
              height: heightButton,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorTxtPrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                primaryText,
                style: const TextStyle(
                  color: colorTxtSimple,
                  fontWeight: font4,
                  fontSize: fontSizeSmall,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: widthButton,
              height: heightButton,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorBrBtnDecline,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Decline',
                style: TextStyle(
                  color: colorTxtDecline,
                  fontWeight: font4,
                  fontSize: fontSizeSmall,
                ),
              ),
            ),
          ],
        );
      }

      Widget _rowShell(Widget leading, {String? primaryActionLabel}) {
        final showActions =
            primaryActionLabel == "I'll join" || primaryActionLabel == "Accept";

        return Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: borderColor, width: 0.5),
              bottom: BorderSide(color: borderColor, width: 0.5),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leading,
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Nếu không có nút → căn giữa theo trục dọc
                  mainAxisAlignment: showActions
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: fontSizeBasic),
                        children: [
                          TextSpan(
                            text: 'Abby',
                            style: TextStyle(
                              color: colorTxtPrimary,
                              fontWeight: font1,
                            ),
                          ),
                          TextSpan(
                            text: ' wants to join ',
                            style: TextStyle(
                              color: colorTxtSecondary,
                              fontWeight: font3,
                            ),
                          ),
                          TextSpan(
                            text: 'ABC team',
                            style: TextStyle(
                              color: colorTxtPrimary,
                              fontWeight: font1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showActions) ...[
                      const SizedBox(height: 6),
                      _actionButtons(primaryActionLabel!), // truyền label vào
                    ],
                  ],
                ),
              ),
              const Text(
                'Now',
                style: TextStyle(
                  color: colorTxtSecondary,
                  fontSize: 12,
                  fontWeight: font4,
                ),
              ),
            ],
          ),
        );
      }

      

      switch (avatar) {
        // URL ảnh http/https
        case final s when _isNetworkUrl(s) && _looksLikeImage(s):
          return _rowShell(_avatarCircleWithImage(NetworkImage(s)));

        // Asset: assets/... hoặc images/...
        case final s when _isAssetPath(s):
          return _rowShell(_avatarCircleWithImage(AssetImage(s)));

        // File cục bộ
        case final s when !kIsWeb && _isFilePath(s) && _looksLikeImage(s):
          return _rowShell(_avatarCircleWithImage(FileImage(File(s))));

        // Icon (nhận chuỗi đặc biệt "Icons.videocam")
        case final s when s.startsWith("Icons."):
          final iconName = s.substring(6); // lấy phần sau "Icons."
          switch (iconName) {
            case "videocam":
              return _rowShell(
                _avatarCircleWithIcon(Icons.videocam, color: colorTxtDecline),
              );
            default:
              return _rowShell(_avatarCircleWithText("?"));
          }

        // Mặc định: lấy initials
        default:
          final initials = getInitials(avatar);
          return _rowShell(
            _avatarCircleWithText(initials.isEmpty ? '?' : initials),
          );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Column(
        children: [
          buildInvitationRow2("TM"),
          buildInvitationRow2("assets/images/icon-avt-notification.png"),
          buildInvitationRow2("assets/images/icon-avt-cale-notification.png"),
          buildInvitationRow2("Icons.videocam"),

          buildInvitationRow("TM"),
          buildSimpleNotification(
            'You have joined ABC team',
            '10m',
            Colors.green[100]!,
            Icon(Icons.check_circle, color: colorBrBtnDecline, size: 20),
          ),
          buildEventChangeNotification(),
          buildCancelEventNotification(),
          buildSimpleNotification(
            'Name event is Live',
            'Week ago',
            Colors.red[100]!,
            Icon(Icons.videocam, color: colorTxtDecline, size: 20),
          ),
          buildSimpleNotification(
            'Biran confirmed to attend ABC event',
            '2 weeks ago',
            colorBrIconBrand,
            Center(
              child: Text(
                'TM',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
