import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yamekaku/core/app_colors.dart';
import 'package:yamekaku/presentation/widgets/custom_scaffold.dart';
import 'package:yamekaku/presentation/widgets/message_card.dart';
import '../../../application/auth_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    return CustomScaffold(
      hasHeader: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [_userData(), _userIcon(user?.photoURL), MessageCard()],
      ),
    );
  }

  Widget _userData() {
    return Container();
  }

  Widget _userIcon(String? iconUrl) {
    return SizedBox(
      width: 140,
      height: 140,
      child: CircleAvatar(
        backgroundColor: AppColors.iconBg,
        backgroundImage: iconUrl != null
            ? NetworkImage(iconUrl)
            : null, // 画像があるなら表示
        child: iconUrl == null
            ? const Icon(Icons.person, size: 80, color: AppColors.icon)
            : null, // URL がない時だけアイコンを出す
      ),
    );
  }
}
