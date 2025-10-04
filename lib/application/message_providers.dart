import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yamekaku/presentation/tip_engine.dart';
import '../data/work_records_repository.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (_) => FirebaseAuth.instance,
);

/// ユーザー名（なければ空）
final displayNameProvider = Provider<String>((ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  return user?.displayName ?? '';
});

/// 今日のメッセージ（非同期で計算して文字列を返す）
final dailyMessageProvider = FutureProvider<String>((ref) async {
  final auth = ref.read(firebaseAuthProvider);
  final user = auth.currentUser;

  // 匿名ユーザーなら「初回用の挨拶」を返す
  if (user == null || user.isAnonymous) {
    final hello = _helloByTime(DateTime.now());
    final name = user?.displayName ?? 'ゲスト';
    return '$hello $nameさん。\nこれからよろしくお願いします。\nまずは上のアイコンをタップしてメニューを表示してみよう。';
  }

  // ↓ 通常の既存ロジック
  final uid = user.uid;
  final repo = ref.read(workRecordsRepositoryProvider);

  final now = DateTime.now();
  final today = await repo.fetchToday(uid, now);
  final clockIn = (today?['clockIn'] as Timestamp?)?.toDate();
  final clockOut = (today?['clockOut'] as Timestamp?)?.toDate();
  final breakMin = (today?['breakMinutes'] as int?) ?? 0;

  double todayHours = 0;
  if (clockIn != null && clockOut != null) {
    final diff = clockOut.difference(clockIn).inMinutes - breakMin;
    todayHours = (diff / 60).clamp(0, 24).toDouble();
  }

  final weekOvertime = todayHours > 8 ? (todayHours - 8) : 0;
  final unpaid = await repo.fetchUnpaidThisMonth(uid, now);
  final sleptShort = (today?['sleptShort'] as bool?) ?? false;

  final summary = WorkSummary(
    todayHours: todayHours,
    weekOvertime: weekOvertime.toDouble(),
    unpaidYenThisMonth: unpaid,
    sleptShort: sleptShort,
  );

  final name = ref.read(displayNameProvider);
  return buildDailyMessage(displayName: name, s: summary);
});

/// 時間帯に応じて挨拶を返す
String _helloByTime(DateTime now) {
  final hour = now.hour;
  if (hour < 5) return 'こんばんは';
  if (hour < 11) return 'おはようございます';
  if (hour < 17) return 'こんにちは';
  return 'お疲れ様です';
}
