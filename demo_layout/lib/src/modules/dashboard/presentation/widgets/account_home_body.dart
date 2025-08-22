import 'package:auto_route/auto_route.dart';
import 'package:demo_layout/src/modules/dashboard/presentation/app/app_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AccountHomeBody extends ConsumerWidget {
  const AccountHomeBody({super.key});

@override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            ElevatedButton(
              onPressed: () => AutoRouter.of(context).navigate(const AccountDetailRoute()),
              child: const Text('Xem chi tiết (navigate)'),
            ),

            const SizedBox(height: 12),
           
            ElevatedButton(
              onPressed: () => context.router.push(const TermsRoute()),
              child: const Text('Điều khoản (push)'),
            ),
          ],
        ),
      ),
    );
  }
}