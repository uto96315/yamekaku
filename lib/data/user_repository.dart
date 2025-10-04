import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider<FirebaseFirestore>(
  (_) => FirebaseFirestore.instance,
);

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.read(firestoreProvider));
});

class UserRepository {
  UserRepository(this._db);
  final FirebaseFirestore _db;

  Future<void> ensureUserDoc(String uid, {String? provider}) async {
    final ref = _db.collection('users').doc(uid);
    final snap = await ref.get();
    if (!snap.exists) {
      await ref.set({
        'uid': uid,
        'authProvider': provider ?? 'anonymous',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await ref.update({'updatedAt': FieldValue.serverTimestamp()});
    }
  }
}
