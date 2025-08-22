import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/terms_body.dart';


@RoutePage()
class TermsPage extends ConsumerWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TermsBody();
  }
}