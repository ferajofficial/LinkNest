import 'package:auto_route/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  late Stream<DatabaseEvent> _linksStream;
  late Stream<DatabaseEvent> _collectionsStream;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser?.uid;
    if (_userId != null) {
      _linksStream = _dbRef.child('users/$_userId/links').onValue;
      _collectionsStream = _dbRef.child('users/$_userId/collections').onValue;
    }
  }

  // Predefined gradient colors for collections
  final List<List<Color>> _collectionGradients = [
    [Color(0xFF667eea), Color(0xFF764ba2)],
    [Color(0xFFf093fb), Color(0xFFf5576c)],
    [Color(0xFF4facfe), Color(0xFF00f2fe)],
    [Color(0xFF43e97b), Color(0xFF38f9d7)],
    [Color(0xFFfa709a), Color(0xFFfee140)],
    [Color(0xFF30cfd0), Color(0xFF330867)],
    [Color(0xFFa8edea), Color(0xFFfed6e3)],
    [Color(0xFFff9a9e), Color(0xFFfecfef)],
  ];

  void _showCreateCollectionModal() {
    final TextEditingController nameController = TextEditingController();
    int selectedColorIndex = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1a1a2e),
                  Color(0xFF16213e),
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Create Collection',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close, color: Colors.white54),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Collection Name Input
                    Text(
                      'Collection Name',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: TextField(
                        controller: nameController,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'e.g., Work Resources, Recipes',
                          hintStyle: TextStyle(color: Colors.white38),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Color Picker
                    Text(
                      'Choose Color',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _collectionGradients.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                selectedColorIndex = index;
                              });
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: _collectionGradients[index],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: selectedColorIndex == index
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 3,
                                ),
                                boxShadow: selectedColorIndex == index
                                    ? [
                                        BoxShadow(
                                          color: _collectionGradients[index][0].withOpacity(0.5),
                                          blurRadius: 12,
                                          offset: Offset(0, 4),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: selectedColorIndex == index
                                  ? Icon(Icons.check, color: Colors.white)
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),

                    // Create Button
                    Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: _collectionGradients[selectedColorIndex],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: _collectionGradients[selectedColorIndex][0].withOpacity(0.4),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () async {
                            if (nameController.text.trim().isNotEmpty) {
                              try {
                                await _dbRef.child('users/$_userId/collections').push().set({
                                  'name': nameController.text.trim(),
                                  'colorIndex': selectedColorIndex,
                                  'createdAt': DateTime.now().toIso8601String(),
                                });
                                Navigator.pop(context);
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Collection created successfully!'),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.green.shade400,
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
                                print('Error creating collection: $e');
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Failed to create collection'),
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
                          },
                          child: Center(
                            child: Text(
                              'Create Collection',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCollectionOptions(String collectionId, String collectionName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
            ],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.edit, color: Colors.white70),
                  title: Text(
                    'Edit Collection',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Implement edit functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Edit functionality coming soon'),
                        behavior: SnackBarBehavior.floating,
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
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete_outline, color: Colors.redAccent),
                  title: Text(
                    'Delete Collection',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    // Show confirmation dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Color(0xFF1a1a2e),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        title: Text(
                          'Delete Collection?',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Text(
                          'Links in this collection will be moved to Uncategorized.',
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
                              try {
                                // Remove collection from all links first
                                final linksSnapshot =
                                    await _dbRef.child('users/$_userId/links').once();

                                if (linksSnapshot.snapshot.value != null) {
                                  final linksData =
                                      linksSnapshot.snapshot.value as Map<dynamic, dynamic>;

                                  for (var entry in linksData.entries) {
                                    if (entry.value['collection'] == collectionName) {
                                      await _dbRef
                                          .child('users/$_userId/links/${entry.key}')
                                          .update({'collection': ''});
                                    }
                                  }
                                }

                                // Delete the collection
                                await _dbRef
                                    .child('users/$_userId/collections/$collectionId')
                                    .remove();

                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Collection deleted'),
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
                                print('Error deleting collection: $e');
                              }
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _getLinksCountForCollection(Map<dynamic, dynamic>? linksData, String collectionName) {
    if (linksData == null) return 0;

    if (collectionName == 'Uncategorized') {
      return linksData.values
          .where((link) => link['collection'] == null || link['collection'] == '')
          .length;
    }

    return linksData.values.where((link) => link['collection'] == collectionName).length;
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
              'Please login to view collections',
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
                        Icons.folder_rounded,
                        color: Colors.white54,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Collections',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Organize your links',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white38,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Collections Grid
              Expanded(
                child: StreamBuilder(
                  stream: _collectionsStream,
                  builder: (context, collectionsSnapshot) {
                    return StreamBuilder(
                      stream: _linksStream,
                      builder: (context, linksSnapshot) {
                        if (collectionsSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF667eea),
                            ),
                          );
                        }

                        final collectionsData =
                            collectionsSnapshot.data?.snapshot.value as Map<dynamic, dynamic>?;
                        final linksData =
                            linksSnapshot.data?.snapshot.value as Map<dynamic, dynamic>?;

                        // Calculate uncategorized count
                        final uncategorizedCount = linksData?.values
                                .where((link) =>
                                    link['collection'] == null || link['collection'] == '')
                                .length ??
                            0;

                        final hasCollections =
                            collectionsData != null && collectionsData.isNotEmpty;
                        final hasLinks = linksData != null && linksData.isNotEmpty;

                        // Show empty state only if no collections AND no links
                        if (!hasCollections && !hasLinks) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 80,
                                  color: Colors.white24,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No collections yet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Create your first collection\nto organize your links',
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

                        final collections = hasCollections ? collectionsData.entries.toList() : [];

                        // Always show grid if there are collections OR uncategorized links
                        return GridView.builder(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                            bottom: 100, // Extra padding for FAB
                          ),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: collections.length + 1, // +1 for Uncategorized
                          itemBuilder: (context, index) {
                            // First item is always Uncategorized
                            if (index == 0) {
                              return _buildCollectionCard(
                                'Uncategorized',
                                uncategorizedCount,
                                0,
                                null,
                              );
                            }

                            final collection = collections[index - 1];
                            final collectionId = collection.key;
                            final name = collection.value['name'] ?? 'Untitled';
                            final colorIndex = collection.value['colorIndex'] ?? 0;
                            final linkCount = _getLinksCountForCollection(
                              linksData,
                              name,
                            );

                            return _buildCollectionCard(
                              name,
                              linkCount,
                              colorIndex,
                              collectionId,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: GlowingFab(onPressed: _showCreateCollectionModal),

      // GLOWING BUTTON
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.sizeOf(context).height * 0.14,
        ),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF667eea),
                Color(0xFF764ba2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF667eea).withOpacity(0.6),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: const Color(0xFF764ba2).withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 4,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            onPressed: _showCreateCollectionModal,
            backgroundColor: Colors.transparent, // Let gradient show
            elevation: 0, // Remove default shadow
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Create One',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionCard(
    String name,
    int linkCount,
    int colorIndex,
    String? collectionId,
  ) {
    final gradient = _collectionGradients[colorIndex % _collectionGradients.length];

    return GestureDetector(
      onTap: () {
        // TODO: Navigate to collection detail page
        print('Tapped on collection: $name');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening $name collection'),
            behavior: SnackBarBehavior.floating,
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
      },
      onLongPress: () {
        // Only show options for regular collections, not Uncategorized
        if (collectionId != null && name != 'Uncategorized') {
          _showCollectionOptions(collectionId, name);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.15),
                Colors.white.withOpacity(0.05),
              ],
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  name == 'Uncategorized' ? Icons.inventory_2_outlined : Icons.folder,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              // Collection Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$linkCount ${linkCount == 1 ? 'link' : 'links'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// NORMAL BUTTON 
  // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(
      //       bottom: MediaQuery.sizeOf(context).height * 0.14), // Padding to avoid bottom nav
      //   child: FloatingActionButton.extended(
      //     onPressed: _showCreateCollectionModal,
      //     backgroundColor: Color(0xFF667eea),
      //     elevation: 8,
      //     icon: Icon(Icons.add, color: Colors.white),
      //     label: Text(
      //       'New Collection',
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontWeight: FontWeight.w600,
      //       ),
      //     ),
      //   ),
      // ),
      
