import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../presentation/pages/auth_gate.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/splash_page.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (c, s) => const SplashPage()),
    GoRoute(
      path: '/',
      builder: (c, s) => const AuthGate(),
      routes: [
        GoRoute(path: 'login', builder: (c, s) => const LoginPage()),
        GoRoute(path: 'home', builder: (c, s) => const HomePage()),
      ],
    ),
  ],
);
