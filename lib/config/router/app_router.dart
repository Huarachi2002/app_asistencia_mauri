import 'package:app_asistencia_docente/Page/HomePage.dart';
import 'package:app_asistencia_docente/Page/LoginPage.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    )
  ]
);