import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/auth_controller.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authStateProvider);
    return state.when(
      data: (user) => _Redirect(to: user == null ? '/login' : '/home'),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('error: $e'))),
    );
  }
}

class _Redirect extends StatelessWidget {
  const _Redirect({required this.to});
  final String to;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final current = GoRouter.of(
        context,
      ).routerDelegate.currentConfiguration.uri.toString();
      if (current != to) {
        context.go(to);
      }
    });
    return const SizedBox.shrink();
  }
}

