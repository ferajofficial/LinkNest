import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_nest/data/repositories/links_repo.dart';

/// Provider for LinksRepository (per user)
final linksRepositoryProvider = Provider<LinksRepository?>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return null; // not logged in
  return LinksRepository(user.uid);
});