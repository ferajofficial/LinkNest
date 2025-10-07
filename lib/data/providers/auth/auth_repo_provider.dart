import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_nest/core/local_storage/app_storage_pod.dart';
import 'package:link_nest/data/repositories/auth_repo.dart';

/// Auth Repository provider
// final authRepositoryProvider = Provider<AuthRepository>((ref) {
//   return AuthRepository(ref.watch(firebaseAuthProvider));
// });

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(appStorageProvider));
});
