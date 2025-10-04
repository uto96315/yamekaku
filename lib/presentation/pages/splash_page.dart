import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yamekaku/data/%20auth_repository.dart';
import '../../../data/user_repository.dart';
import 'dart:async';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});
  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      // 匿名でログイン（既にログイン済みなら何も起きない）
      await ref.read(authRepositoryProvider).signInAnonymously();
      final user = ref.read(authRepositoryProvider).currentUser;
      if (user != null) {
        await ref
            .read(userRepositoryProvider)
            .ensureUserDoc(
              user.uid,
              provider: user.isAnonymous ? 'anonymous' : 'email',
            );
      }
      
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) context.go('/home');
    } catch (_) {
      if (mounted) context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

}
