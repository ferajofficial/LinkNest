import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_nest/data/providers/saved_links/links_repo_provider.dart';

/// Stream provider for user links
final linksProvider = StreamProvider<Map<dynamic, dynamic>?>((ref) {
  final repo = ref.watch(linksRepositoryProvider);
  if (repo == null) return const Stream.empty();
  return repo.getLinks();
});
