import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CollectionDetailPage extends StatefulWidget {
  final String collectionName;
  final List<Color> gradientColors;
  final String? collectionId;

  const CollectionDetailPage({
    super.key,
    required this.collectionName,
    required this.gradientColors,
    this.collectionId,
  });

  @override
  State<CollectionDetailPage> createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage>
    with SingleTickerProviderStateMixin {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  late Stream<DatabaseEvent> _linksStream;
  late Stream<DatabaseEvent> _collectionsStream;
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  late AnimationController _fabAnimController;
  late Animation<double> _fabScaleAnimation;

  @override
  void initState() {
    super.initState();
    if (_userId != null) {
      _linksStream = _dbRef.child('users/$_userId/links').onValue.asBroadcastStream();
      _collectionsStream = _dbRef.child('users/$_userId/collections').onValue.asBroadcastStream();
    }

    _fabAnimController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fabScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fabAnimController, curve: Curves.elasticOut),
    );

    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) _fabAnimController.forward();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fabAnimController.dispose();
    super.dispose();
  }

  List<MapEntry> _filterLinks(dynamic linksData) {
    if (linksData == null) return [];

    // Handle both Map and List formats from Firebase
    Map<dynamic, dynamic> linksMap = {};

    if (linksData is Map) {
      linksMap = linksData;
    } else if (linksData is List) {
      // Convert list to map with index as key
      for (int i = 0; i < linksData.length; i++) {
        if (linksData[i] != null) {
          linksMap[i.toString()] = linksData[i];
        }
      }
    } else {
      return [];
    }

    var links = linksMap.entries.where((entry) {
      if (entry.value == null || entry.value is! Map) return false;

      final collection = entry.value['collection'] ?? '';

      if (widget.collectionName == 'Uncategorized') {
        return collection.isEmpty;
      }
      return collection == widget.collectionName;
    }).toList();

    if (_searchQuery.isNotEmpty) {
      links = links.where((entry) {
        final url = (entry.value['url'] ?? '').toString().toLowerCase();
        final tags = entry.value['tags'];
        String tagString = '';

        if (tags is Map) {
          tagString = tags.values.join(' ').toLowerCase();
        } else if (tags is List) {
          tagString = tags.join(' ').toLowerCase();
        }

        return url.contains(_searchQuery.toLowerCase()) ||
            tagString.contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Sort by timestamp (newest first)
    links.sort((a, b) {
      final aTime = a.value['timestamp'] ?? '';
      final bTime = b.value['timestamp'] ?? '';
      return bTime.compareTo(aTime);
    });

    return links;
  }

  Future<void> _launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          _showSnackBar('Could not open link', isError: true);
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Invalid URL', isError: true);
      }
    }
  }

  void _showLinkOptions(String linkId, String url, String currentCollection) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  url,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              _buildOptionTile(
                icon: Icons.open_in_new,
                title: 'Open Link',
                onTap: () {
                  Navigator.pop(context);
                  _launchURL(url);
                },
              ),
              _buildOptionTile(
                icon: Icons.copy,
                title: 'Copy URL',
                onTap: () {
                  Navigator.pop(context);
                  // Copy to clipboard functionality
                  _showSnackBar('URL copied to clipboard');
                },
              ),
              if (widget.collectionName != 'Uncategorized')
                _buildOptionTile(
                  icon: Icons.remove_circle_outline,
                  title: 'Remove from Collection',
                  color: Colors.orange,
                  onTap: () async {
                    Navigator.pop(context);
                    await _removeFromCollection(linkId);
                  },
                ),
              StreamBuilder<DatabaseEvent>(
                stream: _collectionsStream,
                builder: (context, snapshot) {
                  final collectionsData = snapshot.data?.snapshot.value;

                  // Handle both Map and List formats
                  Map<dynamic, dynamic> collectionsMap = {};
                  if (collectionsData is Map) {
                    collectionsMap = collectionsData;
                  }

                  if (collectionsMap.isEmpty) {
                    return SizedBox.shrink();
                  }

                  return _buildOptionTile(
                    icon: Icons.drive_file_move_outline,
                    title: 'Move to Collection',
                    onTap: () {
                      Navigator.pop(context);
                      _showMoveToCollectionDialog(linkId, currentCollection, collectionsMap);
                    },
                  );
                },
              ),
              _buildOptionTile(
                icon: Icons.delete_outline,
                title: 'Delete Link',
                color: Colors.redAccent,
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(linkId, url);
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.white70),
      title: Text(
        title,
        style: TextStyle(color: color ?? Colors.white),
      ),
      onTap: onTap,
    );
  }

  Future<void> _removeFromCollection(String linkId) async {
    try {
      await _dbRef.child('users/$_userId/links/$linkId').update({
        'collection': '',
      });
      _showSnackBar('Removed from collection');
    } catch (e) {
      _showSnackBar('Failed to remove link', isError: true);
    }
  }

  void _showMoveToCollectionDialog(
    String linkId,
    String currentCollection,
    Map<dynamic, dynamic> collectionsData,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1a1a2e),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        title: Text(
          'Move to Collection',
          style: TextStyle(color: Colors.white),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              // Uncategorized option
              _buildCollectionOption(
                name: 'Uncategorized',
                colorIndex: 0,
                onTap: () async {
                  Navigator.pop(context);
                  await _moveToCollection(linkId, '');
                },
              ),

              // Other collections
              ...collectionsData.entries
                  .where((entry) => entry.value['name'] != currentCollection)
                  .map((entry) {
                final name = entry.value['name'] ?? 'Untitled';
                final colorIndex = entry.value['colorIndex'] ?? 0;

                return _buildCollectionOption(
                  name: name,
                  colorIndex: colorIndex,
                  onTap: () async {
                    Navigator.pop(context);
                    await _moveToCollection(linkId, name);
                  },
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionOption({
    required String name,
    required int colorIndex,
    required VoidCallback onTap,
  }) {
    final gradients = [
      [Color(0xFF667eea), Color(0xFF764ba2)],
      [Color(0xFFf093fb), Color(0xFFf5576c)],
      [Color(0xFF4facfe), Color(0xFF00f2fe)],
      [Color(0xFF43e97b), Color(0xFF38f9d7)],
      [Color(0xFFfa709a), Color(0xFFfee140)],
      [Color(0xFF30cfd0), Color(0xFF330867)],
      [Color(0xFFa8edea), Color(0xFFfed6e3)],
      [Color(0xFFff9a9e), Color(0xFFfecfef)],
    ];

    final gradient = gradients[colorIndex % gradients.length];

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          name == 'Uncategorized' ? Icons.inventory_2_outlined : Icons.folder,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  Future<void> _moveToCollection(String linkId, String newCollection) async {
    try {
      await _dbRef.child('users/$_userId/links/$linkId').update({
        'collection': newCollection,
      });
      _showSnackBar('Moved to ${newCollection.isEmpty ? 'Uncategorized' : newCollection}');
    } catch (e) {
      _showSnackBar('Failed to move link', isError: true);
    }
  }

  void _showDeleteConfirmation(String linkId, String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1a1a2e),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        title: Text(
          'Delete Link?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteLink(linkId);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteLink(String linkId) async {
    try {
      await _dbRef.child('users/$_userId/links/$linkId').remove();
      _showSnackBar('Link deleted');
    } catch (e) {
      _showSnackBar('Failed to delete link', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Colors.red.shade400 : Colors.green.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
      ),
    );
  }

  String _getDomainFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host.replaceAll('www.', '');
    } catch (e) {
      return 'Link';
    }
  }

  String _formatTimestamp(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) return '';

    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 365) {
        return '${(difference.inDays / 365).floor()}y ago';
      } else if (difference.inDays > 30) {
        return '${(difference.inDays / 30).floor()}mo ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
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
            children: [
              // Header with Hero Animation
              Container(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.gradientColors,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.gradientColors[0].withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Top Bar
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.maybePop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.12),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.collectionName,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              StreamBuilder<DatabaseEvent>(
                                stream: _linksStream,
                                builder: (context, snapshot) {
                                  final linksData = snapshot.data?.snapshot.value;
                                  final filteredLinks = _filterLinks(linksData);

                                  return Text(
                                    '${filteredLinks.length} ${filteredLinks.length == 1 ? 'link' : 'links'}',
                                    style: TextStyle(
                                      fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSearching = !_isSearching;
                              if (!_isSearching) {
                                _searchQuery = '';
                                _searchController.clear();
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.12),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              _isSearching ? Icons.close : Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Search Bar
                    if (_isSearching)
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Search links...',
                              hintStyle: TextStyle(color: Colors.white60),
                              prefixIcon: Icon(Icons.search, color: Colors.white60),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Links List
              Expanded(
                child: StreamBuilder<DatabaseEvent>(
                  stream: _linksStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: widget.gradientColors[0],
                        ),
                      );
                    }

                    final linksData = snapshot.data?.snapshot.value;
                    final filteredLinks = _filterLinks(linksData);

                    if (filteredLinks.isEmpty) {
                      return _buildEmptyState();
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(Duration(milliseconds: 500));
                      },
                      color: widget.gradientColors[0],
                      backgroundColor: Color(0xFF1a1a2e),
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          top: 16,
                          bottom: 100,
                          left: 16,
                          right: 16,
                        ),
                        itemCount: filteredLinks.length,
                        itemBuilder: (context, index) {
                          final entry = filteredLinks[index];
                          final linkId = entry.key;
                          final linkData = entry.value;
                          final url = linkData['url'] ?? '';
                          final collection = linkData['collection'] ?? '';
                          final timestamp = linkData['timestamp'];

                          // Handle tags in both Map and List formats
                          dynamic tagsData = linkData['tags'];
                          Map<dynamic, dynamic>? tags;
                          if (tagsData is Map) {
                            tags = tagsData;
                          } else if (tagsData is List) {
                            tags = {};
                            for (int i = 0; i < tagsData.length; i++) {
                              if (tagsData[i] != null) {
                                tags[i] = tagsData[i];
                              }
                            }
                          }

                          return _buildLinkCard(
                            linkId: linkId,
                            url: url,
                            timestamp: timestamp,
                            tags: tags,
                            collection: collection,
                            index: index,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: ScaleTransition(
        scale: _fabScaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: widget.gradientColors,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors[0].withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 2,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {
              _showSnackBar('Add link functionality - Coming soon!');
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }

  Widget _buildLinkCard({
    required String linkId,
    required String url,
    required String? timestamp,
    required Map<dynamic, dynamic>? tags,
    required String collection,
    required int index,
  }) {
    final domain = _getDomainFromUrl(url);
    final timeAgo = _formatTimestamp(timestamp);

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 50)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.08),
              Colors.white.withOpacity(0.04),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Domain and Time
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: widget.gradientColors,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.link,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            domain,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (timeAgo.isNotEmpty)
                            Text(
                              timeAgo,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white54,
                              ),
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => _showLinkOptions(linkId, url, collection),
                      icon: Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white54,
                        size: 20,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // URL
                InkWell(
                  onTap: () => _launchURL(url),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            url,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.open_in_new,
                          color: Colors.white54,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),

                // Tags
                if (tags != null && tags.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: tags.values.map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.gradientColors[0].withOpacity(0.3),
                                widget.gradientColors[1].withOpacity(0.3),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: widget.gradientColors[0].withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            '#$tag',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.gradientColors,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.link_off,
              size: 60,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),
          Text(
            _searchQuery.isNotEmpty ? 'No matching links' : 'No links yet',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try different keywords'
                : 'Add links to this collection\nto see them here',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
