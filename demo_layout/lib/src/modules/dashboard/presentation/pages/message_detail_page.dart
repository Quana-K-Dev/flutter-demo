import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/message_detail_body.dart';


@RoutePage()
class MessageDetailPage extends ConsumerWidget {
  const MessageDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MessagesDetailBody();
  }
}