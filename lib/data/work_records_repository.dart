import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider<FirebaseFirestore>(
  (_) => FirebaseFirestore.instance,
);

final workRecordsRepositoryProvider = Provider<WorkRecordsRepository>(
  (ref) => WorkRecordsRepository(ref.read(firestoreProvider)),
);

class WorkRecordsRepository {
  WorkRecordsRepository(this._db);
  final FirebaseFirestore _db;

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _db.collection('users').doc(uid);

  /// /users/{uid}/workRecords/{YYYY-MM-DD}
  DocumentReference<Map<String, dynamic>> _todayRef(String uid, DateTime now) {
    final id =
        '${now.year.toString().padLeft(4, '0')}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}';
    return _userDoc(uid).collection('workRecords').doc(id);
  }

  Future<Map<String, dynamic>?> fetchToday(String uid, DateTime now) async {
    final snap = await _todayRef(uid, now).get();
    return snap.data();
  }

  /// 必要になったら期間集計に置き換え。ここでは最小で「今月の未払い見積り」を取る前提のフィールド名に。
  Future<int> fetchUnpaidThisMonth(String uid, DateTime now) async {
    // 例: /users/{uid}/months/{YYYY-MM} ドキュメントに集計済みフィールド unpaidYen がある想定（無ければ0）
    final monthId =
        '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}';
    final ref = _userDoc(uid).collection('months').doc(monthId);
    final snap = await ref.get();
    return (snap.data()?['unpaidYen'] ?? 0) as int;
  }
}
