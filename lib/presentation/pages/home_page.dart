import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/auth_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ダッシュボード'),
        actions: [
          IconButton(
            onPressed: () => ref.read(authControllerProvider).signOut(),
            icon: const Icon(Icons.logout),
            tooltip: 'ログアウト',
          ),
        ],
      ),
      body: Center(child: Text('Hello, ${user?.email ?? "User"}')),
    );
  }
}
