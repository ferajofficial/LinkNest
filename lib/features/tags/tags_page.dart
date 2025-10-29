import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// class TagsPage extends StatefulWidget {
//   const TagsPage({super.key});

//   @override
//   State<TagsPage> createState() => _TagsPageState();
// }

// class _TagsPageState extends State<TagsPage> {
//   final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
//   late Stream<DatabaseEvent> _linksStream;
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   bool _isMultiSelectMode = false;
//   final Set<String> _selectedTags = {};
//   String? _userId;

//   @override
//   void initState() {
//     super.initState();
//     _userId = FirebaseAuth.instance.currentUser?.uid;
//     if (_userId != null) {
//       _linksStream = _dbRef.child('users/$_userId/links').onValue;
//     }
//     _searchController.addListener(() {
//       setState(() {
//         _searchQuery = _searchController.text.toLowerCase();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   // Generate tag colors based on tag name
//   Color _getTagColor(String tag) {
//     final colors = [
//       Color(0xFF667eea),
//       Color(0xFFf093fb),
//       Color(0xFF4facfe),
//       Color(0xFF43e97b),
//       Color(0xFFfa709a),
//       Color(0xFF30cfd0),
//       Color(0xFFa8edea),
//       Color(0xFFff9a9e),
//       Color(0xFFfbc2eb),
//       Color(0xFF84fab0),
//     ];
//     final index = tag.hashCode.abs() % colors.length;
//     return colors[index];
//   }

//   // Extract all unique tags from links with their counts
//   Map<String, int> _extractTags(Map<dynamic, dynamic>? linksData) {
//     Map<String, int> tagCounts = {};
//     if (linksData == null) return tagCounts;

//     for (var link in linksData.values) {
//       if (link['tags'] != null && link['tags'] is List) {
//         List<dynamic> tags = link['tags'];
//         for (var tag in tags) {
//           String tagStr = tag.toString();
//           tagCounts[tagStr] = (tagCounts[tagStr] ?? 0) + 1;
//         }
//       }
//     }

//     return tagCounts;
//   }

//   // Filter tags based on search query
//   Map<String, int> _filterTags(Map<String, int> tags) {
//     if (_searchQuery.isEmpty) return tags;

//     return Map.fromEntries(
//       tags.entries.where((entry) => entry.key.toLowerCase().contains(_searchQuery)),
//     );
//   }

//   // Get top 5 most used tags
//   List<MapEntry<String, int>> _getTrendingTags(Map<String, int> tags) {
//     var sortedTags = tags.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
//     return sortedTags.take(5).toList();
//   }

//   void _toggleMultiSelect() {
//     setState(() {
//       _isMultiSelectMode = !_isMultiSelectMode;
//       if (!_isMultiSelectMode) {
//         _selectedTags.clear();
//       }
//     });
//   }

//   void _toggleTagSelection(String tag) {
//     setState(() {
//       if (_selectedTags.contains(tag)) {
//         _selectedTags.remove(tag);
//       } else {
//         _selectedTags.add(tag);
//       }
//     });
//   }

//   void _viewFilteredLinks() {
//     // TODO: Navigate to filtered links view
//     print('View links with tags: $_selectedTags');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Showing links with ${_selectedTags.length} selected tags'),
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Color(0xFF667eea),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         margin: EdgeInsets.only(
//           bottom: 80,
//           left: 16,
//           right: 16,
//         ),
//       ),
//     );
//   }

//   Future<void> _deleteTag(String tag) async {
//     try {
//       // Get all links
//       final linksSnapshot = await _dbRef.child('users/$_userId/links').once();

//       if (linksSnapshot.snapshot.value != null) {
//         final linksData = linksSnapshot.snapshot.value as Map<dynamic, dynamic>;

//         // Remove tag from all links
//         for (var entry in linksData.entries) {
//           if (entry.value['tags'] != null && entry.value['tags'] is List) {
//             List<dynamic> tags = List.from(entry.value['tags']);
//             if (tags.contains(tag)) {
//               tags.remove(tag);
//               await _dbRef.child('users/$_userId/links/${entry.key}').update({'tags': tags});
//             }
//           }
//         }
//       }

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Tag "$tag" deleted'),
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.red.shade400,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             margin: EdgeInsets.only(
//               bottom: 80,
//               left: 16,
//               right: 16,
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error deleting tag: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to delete tag'),
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.red.shade400,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             margin: EdgeInsets.only(
//               bottom: 80,
//               left: 16,
//               right: 16,
//             ),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_userId == null) {
//       return Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFF1a1a2e),
//                 Color(0xFF16213e),
//                 Color(0xFF0f3460),
//               ],
//             ),
//           ),
//           child: Center(
//             child: Text(
//               'Please login to view tags',
//               style: TextStyle(color: Colors.white70, fontSize: 16),
//             ),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF1a1a2e),
//               Color(0xFF16213e),
//               Color(0xFF0f3460),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               Padding(
//                 padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.1),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.12),
//                           width: 1,
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         Icons.local_offer_rounded,
//                         color: Colors.white54,
//                         size: 20,
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Tags',
//                             style: TextStyle(
//                               fontSize: 24,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           Text(
//                             'Filter and organize by tags',
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.white38,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Multi-select toggle
//                     GestureDetector(
//                       onTap: _toggleMultiSelect,
//                       child: Container(
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: _isMultiSelectMode
//                               ? Color(0xFF667eea).withOpacity(0.3)
//                               : Colors.white.withOpacity(0.1),
//                           border: Border.all(
//                             color: _isMultiSelectMode
//                                 ? Color(0xFF667eea).withOpacity(0.5)
//                                 : Colors.white.withOpacity(0.12),
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Icon(
//                           _isMultiSelectMode ? Icons.check_box : Icons.check_box_outline_blank,
//                           color: Colors.white54,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Search Bar
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.08),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.1),
//                     ),
//                   ),
//                   child: TextField(
//                     controller: _searchController,
//                     style: TextStyle(color: Colors.white, fontSize: 15),
//                     decoration: InputDecoration(
//                       hintText: 'Search tags...',
//                       hintStyle: TextStyle(color: Colors.white38),
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: Colors.white.withOpacity(0.5),
//                       ),
//                       suffixIcon: _searchQuery.isNotEmpty
//                           ? IconButton(
//                               icon: Icon(
//                                 Icons.clear,
//                                 color: Colors.white.withOpacity(0.5),
//                               ),
//                               onPressed: () {
//                                 _searchController.clear();
//                               },
//                             )
//                           : null,
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               SizedBox(height: 20),

//               // Tags Content
//               Expanded(
//                 child: StreamBuilder(
//                   stream: _linksStream,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(
//                         child: CircularProgressIndicator(
//                           color: Color(0xFF667eea),
//                         ),
//                       );
//                     }

//                     if (snapshot.hasError) {
//                       return Center(
//                         child: Text(
//                           'Something went wrong',
//                           style: TextStyle(color: Colors.white70),
//                         ),
//                       );
//                     }

//                     final linksData = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;

//                     final allTags = _extractTags(linksData);
//                     final filteredTags = _filterTags(allTags);
//                     final trendingTags = _getTrendingTags(allTags);

//                     if (allTags.isEmpty) {
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.label_off,
//                               size: 80,
//                               color: Colors.white24,
//                             ),
//                             SizedBox(height: 16),
//                             Text(
//                               'No tags yet',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white70,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'Add tags to your links\nto organize them better',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white38,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }

//                     if (filteredTags.isEmpty && _searchQuery.isNotEmpty) {
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.search_off,
//                               size: 64,
//                               color: Colors.white38,
//                             ),
//                             SizedBox(height: 16),
//                             Text(
//                               'No tags found',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white70,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }

//                     return SingleChildScrollView(
//                       padding: EdgeInsets.only(bottom: 100), // Extra padding for FAB
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Trending Tags Section (only show if not searching)
//                           if (_searchQuery.isEmpty && trendingTags.isNotEmpty)
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 16),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.trending_up,
//                                         color: Colors.white70,
//                                         size: 18,
//                                       ),
//                                       SizedBox(width: 8),
//                                       Text(
//                                         'Most Used',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.white70,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 12),
//                                   Wrap(
//                                     spacing: 8,
//                                     runSpacing: 8,
//                                     children: trendingTags.map((entry) {
//                                       return _buildTagChip(
//                                         entry.key,
//                                         entry.value,
//                                         isLarge: true,
//                                       );
//                                     }).toList(),
//                                   ),
//                                   SizedBox(height: 24),
//                                 ],
//                               ),
//                             ),

//                           // All Tags Section
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.label,
//                                       color: Colors.white70,
//                                       size: 18,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       _searchQuery.isEmpty
//                                           ? 'All Tags (${filteredTags.length})'
//                                           : 'Search Results (${filteredTags.length})',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.white70,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 12),
//                                 Wrap(
//                                   spacing: 8,
//                                   runSpacing: 8,
//                                   children: filteredTags.entries.map((entry) {
//                                     return _buildTagChip(
//                                       entry.key,
//                                       entry.value,
//                                       isLarge: false,
//                                     );
//                                   }).toList(),
//                                 ),
//                                 SizedBox(height: 20),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       // Show floating button when tags are selected
//       floatingActionButton: _isMultiSelectMode && _selectedTags.isNotEmpty
//           ? Padding(
//               padding: EdgeInsets.only(bottom: 70), // Padding to avoid bottom nav
//               child: FloatingActionButton.extended(
//                 onPressed: _viewFilteredLinks,
//                 backgroundColor: Color(0xFF667eea),
//                 elevation: 8,
//                 icon: Icon(Icons.filter_list, color: Colors.white),
//                 label: Text(
//                   'View ${_selectedTags.length} ${_selectedTags.length == 1 ? 'Tag' : 'Tags'}',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             )
//           : null,
//     );
//   }

@RoutePage()
class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  late Stream<DatabaseEvent> _linksStream;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isMultiSelectMode = false;
  final Set<String> _selectedTags = {};
  String? _userId;

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser?.uid;
    if (_userId != null) {
      _linksStream = _dbRef.child('users/$_userId/links').onValue;
    }
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Generate tag colors based on tag name
  Color _getTagColor(String tag) {
    final colors = [
      Color(0xFF667eea),
      Color(0xFFf093fb),
      Color(0xFF4facfe),
      Color(0xFF43e97b),
      Color(0xFFfa709a),
      Color(0xFF30cfd0),
      Color(0xFFa8edea),
      Color(0xFFff9a9e),
      Color(0xFFfbc2eb),
      Color(0xFF84fab0),
    ];
    final index = tag.hashCode.abs() % colors.length;
    return colors[index];
  }

  // Extract all unique tags from links with their counts
  Map<String, int> _extractTags(Map<dynamic, dynamic>? linksData) {
    Map<String, int> tagCounts = {};
    if (linksData == null) return tagCounts;

    for (var link in linksData.values) {
      if (link['tags'] != null && link['tags'] is List) {
        List<dynamic> tags = link['tags'];
        for (var tag in tags) {
          String tagStr = tag.toString();
          tagCounts[tagStr] = (tagCounts[tagStr] ?? 0) + 1;
        }
      }
    }

    return tagCounts;
  }

  // Filter tags based on search query
  Map<String, int> _filterTags(Map<String, int> tags) {
    if (_searchQuery.isEmpty) return tags;

    return Map.fromEntries(
      tags.entries.where((entry) => entry.key.toLowerCase().contains(_searchQuery)),
    );
  }

  // Get links that have tags matching the search query
  List<Map<String, dynamic>> _getLinksWithMatchingTags(Map<dynamic, dynamic>? linksData) {
    if (linksData == null || _searchQuery.isEmpty) return [];

    List<Map<String, dynamic>> matchingLinks = [];

    for (var entry in linksData.entries) {
      final linkData = entry.value as Map<dynamic, dynamic>;
      if (linkData['tags'] != null && linkData['tags'] is List) {
        List<dynamic> tags = linkData['tags'];

        // Check if any tag contains the search query
        bool hasMatchingTag =
            tags.any((tag) => tag.toString().toLowerCase().contains(_searchQuery));

        if (hasMatchingTag) {
          matchingLinks.add({
            'key': entry.key,
            // 'title': linkData['title'] ?? 'Untitled',
            'url': linkData['url'] ?? '',
            'tags': tags,
            'timestamp': linkData['timestamp'] ?? 0,
          });
        }
      }
    }

    // Sort by timestamp (newest first)
    matchingLinks.sort((a, b) => (b['timestamp'] as String).compareTo(a['timestamp'] as String));

    return matchingLinks;
  }

  // Get top 5 most used tags
  List<MapEntry<String, int>> _getTrendingTags(Map<String, int> tags) {
    var sortedTags = tags.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return sortedTags.take(5).toList();
  }

  void _toggleMultiSelect() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) {
        _selectedTags.clear();
      }
    });
  }

  void _toggleTagSelection(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  void _viewFilteredLinks() {
    // TODO: Navigate to filtered links view
    print('View links with tags: $_selectedTags');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Showing links with ${_selectedTags.length} selected tags'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF667eea),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
          bottom: 80,
          left: 16,
          right: 16,
        ),
      ),
    );
  }

  Future<void> _openLink(String url) async {
    try {
      // Clean and validate URL
      String cleanUrl = url.trim();

      // Add https:// if no scheme is present
      if (!cleanUrl.startsWith('http://') && !cleanUrl.startsWith('https://')) {
        cleanUrl = 'https://$cleanUrl';
      }

      final uri = Uri.parse(cleanUrl);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $cleanUrl';
      }
    } catch (e) {
      print('Error opening link: $e'); // For debugging
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to open link: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(
              bottom: 80,
              left: 16,
              right: 16,
            ),
          ),
        );
      }
    }
  }

  Future<void> _deleteTag(String tag) async {
    try {
      // Get all links
      final linksSnapshot = await _dbRef.child('users/$_userId/links').once();

      if (linksSnapshot.snapshot.value != null) {
        final linksData = linksSnapshot.snapshot.value as Map<dynamic, dynamic>;

        // Remove tag from all links
        for (var entry in linksData.entries) {
          if (entry.value['tags'] != null && entry.value['tags'] is List) {
            List<dynamic> tags = List.from(entry.value['tags']);
            if (tags.contains(tag)) {
              tags.remove(tag);
              await _dbRef.child('users/$_userId/links/${entry.key}').update({'tags': tags});
            }
          }
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tag "$tag" deleted'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(
              bottom: 80,
              left: 16,
              right: 16,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error deleting tag: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete tag'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(
              bottom: 80,
              left: 16,
              right: 16,
            ),
          ),
        );
      }
    }
  }

  Widget _buildTagChip(String tag, int count, {bool isLarge = false}) {
    final isSelected = _selectedTags.contains(tag);

    return GestureDetector(
      onTap: () {
        if (_isMultiSelectMode) {
          _toggleTagSelection(tag);
        }
      },
      onLongPress: () {
        if (!_isMultiSelectMode) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Color(0xFF1e1e2e),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Delete Tag',
                style: TextStyle(color: Colors.white),
              ),
              content: Text(
                'Are you sure you want to delete "$tag"? This will remove it from all links.',
                style: TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _deleteTag(tag);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red.shade400),
                  ),
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isLarge ? 16 : 12,
          vertical: isLarge ? 12 : 8,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    _getTagColor(tag),
                    _getTagColor(tag).withOpacity(0.7),
                  ],
                )
              : null,
          color: isSelected ? null : _getTagColor(tag).withOpacity(0.2),
          borderRadius: BorderRadius.circular(isLarge ? 12 : 8),
          border: Border.all(
            color: isSelected ? _getTagColor(tag) : _getTagColor(tag).withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isMultiSelectMode)
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  size: isLarge ? 18 : 16,
                  color: Colors.white,
                ),
              ),
            Text(
              tag,
              style: TextStyle(
                color: Colors.white,
                fontSize: isLarge ? 15 : 13,
                fontWeight: isLarge ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            SizedBox(width: 6),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isLarge ? 12 : 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkCard(Map<String, dynamic> link) {
    return GestureDetector(
      onTap: () => _openLink(link['url']),
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Color(0xFF1e1e2e),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Delete Link',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Are you sure you want to delete "${link['title']}"?',
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _deleteLink(link['key'], link['title']);
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red.shade400),
                ),
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.link_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        textAlign: TextAlign.left,
                        link['url'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Tags
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: (link['tags'] as List).map((tag) {
                      final tagStr = tag.toString();
                      final isHighlighted = tagStr.toLowerCase().contains(_searchQuery);

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: isHighlighted
                              ? Border.all(
                                  color: _getTagColor(tagStr).withOpacity(0.8),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Text(
                          '# $tagStr',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                            fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteLink(String linkKey, String title) async {
    try {
      await _dbRef.child('users/$_userId/links/$linkKey').remove();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Link "$title" deleted'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(
              bottom: 80,
              left: 16,
              right: 16,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error deleting link: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete link'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(
              bottom: 80,
              left: 16,
              right: 16,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_userId == null) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1a1a2e),
                Color(0xFF16213e),
                Color(0xFF0f3460),
              ],
            ),
          ),
          child: Center(
            child: Text(
              'Please login to view tags',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.12),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.local_offer_rounded,
                        color: Colors.white54,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tags',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Filter and organize by tags',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white38,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Multi-select toggle
                    GestureDetector(
                      onTap: _toggleMultiSelect,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _isMultiSelectMode
                              ? Color(0xFF667eea).withOpacity(0.3)
                              : Colors.white.withOpacity(0.1),
                          border: Border.all(
                            color: _isMultiSelectMode
                                ? Color(0xFF667eea).withOpacity(0.5)
                                : Colors.white.withOpacity(0.12),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _isMultiSelectMode ? Icons.check_box : Icons.check_box_outline_blank,
                          color: Colors.white54,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: 'Search tags...',
                      hintStyle: TextStyle(color: Colors.white38),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              onPressed: () {
                                _searchController.clear();
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Tags Content
              Expanded(
                child: StreamBuilder(
                  stream: _linksStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF667eea),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Something went wrong',
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }

                    final linksData = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;

                    // If searching, show matching links
                    if (_searchQuery.isNotEmpty) {
                      final matchingLinks = _getLinksWithMatchingTags(linksData);

                      if (matchingLinks.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.white38,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No links found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Try searching with different tags',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white38,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 100),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.link,
                                    color: Colors.white70,
                                    size: 18,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Found ${matchingLinks.length} ${matchingLinks.length == 1 ? 'link' : 'links'}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              ...matchingLinks.map((link) => _buildLinkCard(link)),
                            ],
                          ),
                        ),
                      );
                    }

                    // Otherwise show tags view
                    final allTags = _extractTags(linksData);
                    final filteredTags = _filterTags(allTags);
                    final trendingTags = _getTrendingTags(allTags);

                    if (allTags.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.label_off,
                              size: 80,
                              color: Colors.white24,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No tags yet',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Add tags to your links\nto organize them better',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white38,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Trending Tags Section
                          if (trendingTags.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.trending_up,
                                        color: Colors.white70,
                                        size: 18,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Most Used',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: trendingTags.map((entry) {
                                      return _buildTagChip(
                                        entry.key,
                                        entry.value,
                                        isLarge: true,
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: 24),
                                ],
                              ),
                            ),

                          // All Tags Section
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.label,
                                      color: Colors.white70,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'All Tags (${filteredTags.length})',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: filteredTags.entries.map((entry) {
                                    return _buildTagChip(
                                      entry.key,
                                      entry.value,
                                      isLarge: false,
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // Show floating button when tags are selected
      floatingActionButton: _isMultiSelectMode && _selectedTags.isNotEmpty
          ? Padding(
              padding: EdgeInsets.only(bottom: 70),
              child: FloatingActionButton.extended(
                onPressed: _viewFilteredLinks,
                backgroundColor: Color(0xFF667eea),
                elevation: 8,
                icon: Icon(Icons.filter_list, color: Colors.white),
                label: Text(
                  'View ${_selectedTags.length} ${_selectedTags.length == 1 ? 'Tag' : 'Tags'}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  // Widget _buildTagChip(String tag, int count, {required bool isLarge}) {
  //   final color = _getTagColor(tag);
  //   final isSelected = _selectedTags.contains(tag);

  //   return GestureDetector(
  //     onTap: () {
  //       if (_isMultiSelectMode) {
  //         _toggleTagSelection(tag);
  //       } else {
  //         // TODO: Navigate to links with this tag
  //         print('View links with tag: $tag');
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Opening links with #$tag'),
  //             behavior: SnackBarBehavior.floating,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             margin: EdgeInsets.only(
  //               bottom: 80,
  //               left: 16,
  //               right: 16,
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //     onLongPress: () {
  //       // Show delete option
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           backgroundColor: Color(0xFF1a1a2e),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20),
  //             side: BorderSide(
  //               color: Colors.white.withOpacity(0.1),
  //             ),
  //           ),
  //           title: Text(
  //             'Delete Tag?',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           content: Text(
  //             'This will remove "$tag" from all links. This action cannot be undone.',
  //             style: TextStyle(color: Colors.white70),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: Text(
  //                 'Cancel',
  //                 style: TextStyle(color: Colors.white54),
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () async {
  //                 Navigator.pop(context);
  //                 await _deleteTag(tag);
  //               },
  //               child: Text(
  //                 'Delete',
  //                 style: TextStyle(color: Colors.redAccent),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //     child: AnimatedContainer(
  //       duration: Duration(milliseconds: 600),
  //       padding: EdgeInsets.symmetric(
  //         horizontal: isLarge ? 16 : 12,
  //         vertical: isLarge ? 12 : 10,
  //       ),
  //       decoration: BoxDecoration(
  //         color: isSelected ? color.withOpacity(0.3) : color.withOpacity(0.15),
  //         borderRadius: BorderRadius.circular(isLarge ? 16 : 12),
  //         border: Border.all(
  //           color: isSelected ? color.withOpacity(0.6) : color.withOpacity(0.3),
  //           width: isSelected ? 2 : 1,
  //         ),
  //         boxShadow: isLarge
  //             ? [
  //                 BoxShadow(
  //                   color: color.withOpacity(0.2),
  //                   blurRadius: 12,
  //                   offset: Offset(0, 4),
  //                 ),
  //               ]
  //             : null,
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           if (_isMultiSelectMode && isSelected)
  //             Padding(
  //               padding: const EdgeInsets.only(right: 6),
  //               child: Icon(
  //                 Icons.check_circle,
  //                 color: color,
  //                 size: isLarge ? 18 : 16,
  //               ),
  //             ),
  //           Text(
  //             '#$tag',
  //             style: TextStyle(
  //               fontSize: isLarge ? 15 : 14,
  //               color: Colors.white,
  //               fontWeight: isLarge ? FontWeight.w600 : FontWeight.w500,
  //             ),
  //           ),
  //           SizedBox(width: 6),
  //           Container(
  //             padding: EdgeInsets.symmetric(
  //               horizontal: 6,
  //               vertical: 2,
  //             ),
  //             decoration: BoxDecoration(
  //               color: color.withOpacity(0.3),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: Text(
  //               '$count',
  //               style: TextStyle(
  //                 fontSize: isLarge ? 12 : 11,
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}



/*
Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Icon(
                                                    Icons.open_in_new,
                                                    color: Colors.white.withOpacity(0.7),
                                                    size: 18,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                GestureDetector(
                                                  onTap: () async {
                                                    try {
                                                      await _dbRef.child(key).remove().timeout(
                                                            Duration(seconds: 5),
                                                          );
                                                    } catch (e) {
                                                      print('Error deleting link: $e');
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.redAccent.withOpacity(0.26),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Icon(
                                                      Icons.delete_outline_rounded,
                                                      color: Colors.red,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
 */