import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/massage_list_body.dart';


@RoutePage()
class MessagesListPage extends ConsumerWidget {
  const MessagesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MessagesListBody();
  }
}