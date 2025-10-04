import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yamekaku/application/message_providers.dart';

class MessageCard extends ConsumerWidget {
  const MessageCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(dailyMessageProvider);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Center(
        child: message.when(
          loading: () => const Text('読み込み中…'),
          error: (e, _) => const Text('エラーが発生しました。'),
          data: (text) => Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
        ),
      ),
    );
  }
}
