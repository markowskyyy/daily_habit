import 'package:daily_habit/presentation/pages/home_page/home_screen.dart';
import 'package:daily_habit/presentation/pages/calendart_page/calendar_screen.dart';
import 'package:daily_habit/presentation/pages/stats_page/stats_screen.dart';
import 'package:daily_habit/presentation/ui_kit/essential/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKey,
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calendar',
              name: 'calendar',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CalendarScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              name: 'stats',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: StatsScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
    // GoRoute(
    //   path: '/create-habit',
    //   name: 'createHabit',
    //   pageBuilder: (context, state) => MaterialPage(
    //     child: const CreateHabitScreen(),
    //   ),
    // ),
  ],
);

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

// Расширение для удобной навигации
extension GoRouterExtension on GoRouter {
  void goToHome(BuildContext context) {
    goNamed('home');
  }

  void goToCalendar(BuildContext context) {
    goNamed('calendar');
  }

  void goToStats(BuildContext context) {
    goNamed('stats');
  }

  void goToCreateHabit(BuildContext context) {
    pushNamed('createHabit');
  }
}