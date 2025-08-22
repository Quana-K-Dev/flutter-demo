import 'package:auto_route/auto_route.dart';
import 'package:demo_layout/src/modules/dashboard/presentation/app/app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WellcomeRoute.page, ),
    AutoRoute(
      path: '/dashboard',
      page: DashboardRoute.page,
      initial: true,
      children: [
        AutoRoute(path: 'home', page: HomeRoute.page),
        AutoRoute(path: 'events', page: EventsRoute.page),

        AutoRoute(
          path: 'messages',
          page: MessagesRoute.page,
          initial: true,
          children: [
            AutoRoute(path: '', page: MessagesListRoute.page, initial: true),
            AutoRoute(path: 'message_detail', page: MessageDetailRoute.page),
          ],
        ),

        AutoRoute(
          path: 'account',
          page: AccountRoute.page,
          children: [
            AutoRoute(path: '', page: AccountHomeRoute.page, initial: true),
            AutoRoute(path: 'terms', page: TermsRoute.page),
            AutoRoute(path: 'account_detail', page: AccountDetailRoute.page),
          ],
        ),

      ],
    ),
  ];
}
