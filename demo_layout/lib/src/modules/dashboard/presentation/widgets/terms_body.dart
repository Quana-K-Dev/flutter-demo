import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TermsBody extends ConsumerWidget {
  const TermsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text("TermsBody"),);
  }
}