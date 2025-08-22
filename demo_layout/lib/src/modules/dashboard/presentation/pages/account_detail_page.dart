import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/account_detail_body.dart';


@RoutePage()
class AccountDetailPage extends ConsumerWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AccountDetailBody();
  }
}