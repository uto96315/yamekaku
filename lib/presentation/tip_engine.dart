class WorkSummary {
  final double todayHours; // 今日の実働
  final double weekOvertime; // 週の残業(推定)
  final int unpaidYenThisMonth; // 今月の未払い推定
  final bool sleptShort; // 今日は睡眠短め? (将来データ連携予定)

  WorkSummary({
    required this.todayHours,
    required this.weekOvertime,
    required this.unpaidYenThisMonth,
    required this.sleptShort,
  });
}

String buildDailyMessage({
  required String displayName,
  required WorkSummary s,
}) {
  try {
    final name = displayName.isEmpty ? 'NoName' : displayName;

    if (s.sleptShort) {
      return '$nameさん、お疲れさま！ 今日は少し寝不足気味。お風呂で温まって早めに休もう。';
    }
    if (s.todayHours >= 10) {
      return '$nameさん、長時間勤務おつかれさま。今日は無理せず、帰宅後はリラックスを。';
    }
    if (s.weekOvertime >= 20) {
      return '$nameさん、この1週間は残業が多め。週末はしっかり休んで体力を回復しよう。';
    }
    if (s.unpaidYenThisMonth >= 200000) {
      return '$nameさん、今月の未払い推定が20万円を超えました。証拠の記録を続けて、請求の準備を進めよう。';
    }
    return '$nameさん、よく頑張っています！ 今日は自分に小さなご褒美を。';
  } catch (e) {
    rethrow;
  }
}
