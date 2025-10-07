import 'package:firebase_database/firebase_database.dart';

/// Repository class to manage Links
class LinksRepository {
  final DatabaseReference _dbRef;

  LinksRepository(String uid)
      : _dbRef = FirebaseDatabase.instance.ref("users/$uid/links");

  /// Stream of user links
  Stream<Map<dynamic, dynamic>?> getLinks() {
    return _dbRef.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      return data;
    });
  }

  /// Add new link
  Future<void> addLink(String url) async {
    await _dbRef.push().set({
      "url": url,
      "timestamp": DateTime.now().toIso8601String(),
    });
  }
}