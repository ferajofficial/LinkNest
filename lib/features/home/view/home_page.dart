import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_nest/bootstrap.dart';
import 'package:link_nest/const/resource.dart';
import 'package:link_nest/core/router/router.gr.dart';
import 'package:link_nest/data/providers/auth/auth_repo_provider.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(deferredLoading: true)
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

// class _HomePageState extends ConsumerState<HomePage> {
//   final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("links");
//   final TextEditingController _controller = TextEditingController();
//   String? pastedUrl;

//   // Single stream that both StreamBuilders will share
//   late final Stream<DatabaseEvent> _linksStream;

//   // New variables for search functionality
//   final TextEditingController _searchController = TextEditingController();
//   bool _isSearchActive = false;
//   Timer? _debounceTimer;
//   String _searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     // Create a single broadcast stream that can be listened to multiple times
//     _linksStream = _dbRef.onValue.asBroadcastStream();
//     // Add search listener
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _debounceTimer?.cancel();
//     _controller.dispose();
//     _controller.dispose();
//     super.dispose();
//   }

// //TODO: logout bug should be fixed .
//   bool isLoading = false;
//   void _logout() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       final repo = ref.read(authRepositoryProvider);
//       await repo.signOut();
//       talker.debug('LOGGING OUT');

//       if (mounted) {
//         await Future.delayed(const Duration(seconds: 2));
//         context.router.replaceAll([SigninRoute()]);
//       }
//       setState(() {
//         isLoading = false;
//       });
//     } catch (e) {
//       talker.debug('DEBUG CATCH :::::: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Debounced search handler
//   void _onSearchChanged() {
//     if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

//     _debounceTimer = Timer(const Duration(milliseconds: 500), () {
//       if (mounted) {
//         setState(() {
//           _searchQuery = _searchController.text.toLowerCase().trim();

//           // Close search bar if query is empty
//           if (_searchQuery.isEmpty) {
//             _isSearchActive = false;
//           }
//         });
//       }
//     });
//   }

//   // Filter links based on search query
//   List<MapEntry<dynamic, dynamic>> _filterLinks(List<MapEntry<dynamic, dynamic>> items) {
//     if (_searchQuery.isEmpty) {
//       return items;
//     }

//     return items.where((item) {
//       final url = (item.value["url"] ?? "").toString().toLowerCase();
//       final domain = _extractDomain(item.value["url"] ?? "").toLowerCase();
//       final timestamp = item.value["timestamp"] ?? "";

//       // Format date for searching
//       String dateStr = "";
//       try {
//         if (timestamp.isNotEmpty) {
//           final date = DateTime.parse(timestamp);
//           dateStr = "${date.day}/${date.month}/${date.year}".toLowerCase();
//         }
//       } catch (e) {
//         // If date parsing fails, continue without date search
//       }

//       // Search in domain, url, and date
//       return domain.contains(_searchQuery) ||
//           url.contains(_searchQuery) ||
//           dateStr.contains(_searchQuery);
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Modern gradient background
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
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             !isLoading
//                 ? SafeArea(
//                     child: Column(
//                       children: [
//                         //Header
//                         Container(
//                           padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                           ),
//                           child: Row(
//                             children: [
//                               // Avatar with gradient border
//                               Container(
//                                 width: 56,
//                                 height: 56,
//                                 padding: EdgeInsets.all(3),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   gradient: LinearGradient(
//                                     colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Color(0xFF667eea).withOpacity(0.4),
//                                       blurRadius: 12,
//                                       offset: Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       image: DecorationImage(
//                                         fit: BoxFit.cover,
//                                         image: AssetImage('assets/illustrations/profile.jpg'),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 16),
//                               // Logout button
//                               Spacer(),
//                               Container(
//                                 height: 40,
//                                 width: 40,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.1),
//                                   border: Border.all(
//                                     color: Colors.white.withOpacity(0.12),
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: IconButton(
//                                   onPressed: () {
//                                     _logout();
//                                   },
//                                   icon: Icon(
//                                     Icons.logout_rounded,
//                                     color: Colors.white.withOpacity(0.7),
//                                     size: 18,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         // Main Content
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Container(
//                             padding: EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.04),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                 color: Colors.white.withOpacity(0.1),
//                                 width: 1,
//                               ),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.all(8),
//                                       decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                           colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//                                         ),
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Icon(
//                                         Icons.add_circle_outline,
//                                         color: Colors.white,
//                                         size: 20,
//                                       ),
//                                     ),
//                                     SizedBox(width: 12),
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Add New Link',
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                         Text(
//                                           'Paste your link below',
//                                           style: TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.white38,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 16),
//                                 // Enhanced TextField
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.08),
//                                     borderRadius: BorderRadius.circular(16),
//                                     border: Border.all(
//                                       color: Colors.white.withOpacity(0.1),
//                                       width: 1,
//                                     ),
//                                   ),
//                                   child: TextField(
//                                     controller: _controller,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 15,
//                                     ),
//                                     decoration: InputDecoration(
//                                       hintText: 'https://www.example.com',
//                                       hintStyle: TextStyle(
//                                         color: Colors.white.withOpacity(0.4),
//                                       ),
//                                       prefixIcon: Icon(
//                                         Icons.link,
//                                         color: Colors.white.withOpacity(0.5),
//                                       ),
//                                       border: InputBorder.none,
//                                       contentPadding: EdgeInsets.symmetric(
//                                         vertical: 18,
//                                         horizontal: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 16),
//                                 // Enhanced Save Button with gradient
//                                 Container(
//                                   height: 52,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//                                     ),
//                                     borderRadius: BorderRadius.circular(16),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Color(0xFF667eea).withOpacity(0.4),
//                                         blurRadius: 20,
//                                         offset: Offset(0, 8),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Material(
//                                     color: Colors.transparent,
//                                     child: InkWell(
//                                       borderRadius: BorderRadius.circular(16),
//                                       onTap: () async {
//                                         if (_controller.text.trim().isNotEmpty) {
//                                           try {
//                                             await _dbRef.push().set({
//                                               "url": _controller.text.trim(),
//                                               "timestamp": DateTime.now().toIso8601String(),
//                                               "collection":
//                                                   "", // Empty by default, will be set later
//                                               "tags": [], // Empty array by default
//                                             }).timeout(
//                                               Duration(seconds: 10),
//                                               onTimeout: () {
//                                                 throw Exception('Save operation timed out');
//                                               },
//                                             );

//                                             if (mounted) {
//                                               setState(() {
//                                                 pastedUrl = _controller.text.trim();
//                                               });
//                                               _controller.clear();
//                                             }
//                                           } catch (e) {
//                                             print('Error saving link: $e');
//                                             if (mounted) {
//                                               ScaffoldMessenger.of(context).showSnackBar(
//                                                 SnackBar(
//                                                   content: Text(
//                                                       'Failed to save link. Please try again.'),
//                                                   behavior: SnackBarBehavior.floating,
//                                                   backgroundColor: Colors.red.shade400,
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius: BorderRadius.circular(10),
//                                                   ),
//                                                 ),
//                                               );
//                                             }
//                                           }
//                                         }
//                                       },
//                                       child: Center(
//                                         child: Text(
//                                           'Save Link',
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 28),

//                         // Links Section Header with Animated Search
//                         StreamBuilder(
//                           stream: _linksStream,
//                           builder: (context, snapshot) {
//                             int linkCount = 0;
//                             if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
//                               final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
//                               linkCount = data.length;
//                             }

//                             return Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 16),
//                               child: Row(
//                                 children: [
//                                   // Bookmark Icon (only show when search is not active)
//                                   if (!_isSearchActive)
//                                     Container(
//                                       padding: EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(0.1),
//                                         border: Border.all(
//                                           color: Colors.white.withOpacity(0.12),
//                                           width: 1,
//                                         ),
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: Icon(
//                                         Icons.bookmark_border_rounded,
//                                         color: Colors.white54,
//                                         size: 18,
//                                       ),
//                                     ),
//                                   if (!_isSearchActive) const SizedBox(width: 8),

//                                   // Expandable content
//                                   Expanded(
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         // Title section or Search bar
//                                         Expanded(
//                                           child: AnimatedSwitcher(
//                                             duration: Duration(milliseconds: 500),
//                                             transitionBuilder:
//                                                 (Widget child, Animation<double> animation) {
//                                               return SlideTransition(
//                                                 position: Tween<Offset>(
//                                                   begin: Offset(1.0, 0.0),
//                                                   end: Offset.zero,
//                                                 ).animate(CurvedAnimation(
//                                                   parent: animation,
//                                                   curve: Curves.easeInOut,
//                                                 )),
//                                                 child: FadeTransition(
//                                                   opacity: animation,
//                                                   child: child,
//                                                 ),
//                                               );
//                                             },
//                                             child: _isSearchActive
//                                                 ? Padding(
//                                                     padding: const EdgeInsets.all(10.0),
//                                                     child: Container(
//                                                       height: 40,
//                                                       padding: EdgeInsets.zero,
//                                                       key: ValueKey('search-bar'),
//                                                       decoration: BoxDecoration(
//                                                         color: Colors.white.withOpacity(0.08),
//                                                         borderRadius: BorderRadius.circular(8),
//                                                         border: Border.all(
//                                                           color: Colors.white.withOpacity(0.1),
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                       child: TextField(
//                                                         controller: _searchController,
//                                                         autofocus: true,
//                                                         style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontSize: 14,
//                                                         ),
//                                                         decoration: InputDecoration(
//                                                           hintText:
//                                                               'Search by name, link, tags or date...',
//                                                           hintStyle: TextStyle(
//                                                             color: Colors.white.withOpacity(0.4),
//                                                             fontSize: 13,
//                                                           ),
//                                                           prefixIcon: Icon(
//                                                             Icons.search,
//                                                             color: Colors.white.withOpacity(0.5),
//                                                             size: 20,
//                                                           ),
//                                                           suffixIcon: _searchQuery.isNotEmpty
//                                                               ? IconButton(
//                                                                   icon: Icon(
//                                                                     Icons.clear,
//                                                                     color: Colors.white
//                                                                         .withOpacity(0.5),
//                                                                     size: 20,
//                                                                   ),
//                                                                   onPressed: () {
//                                                                     _searchController.clear();
//                                                                     setState(() {
//                                                                       _searchQuery = '';
//                                                                       _isSearchActive = false;
//                                                                     });
//                                                                   },
//                                                                 )
//                                                               : null,
//                                                           border: InputBorder.none,
//                                                           contentPadding: EdgeInsets.symmetric(
//                                                             vertical: 12,
//                                                             horizontal: 12,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )
//                                                 : Row(
//                                                     key: ValueKey('title-section'),
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment.start,
//                                                         children: [
//                                                           Text(
//                                                             'Recently Saved',
//                                                             style: const TextStyle(
//                                                               fontSize: 18,
//                                                               color: Colors.white,
//                                                               fontWeight: FontWeight.w600,
//                                                             ),
//                                                           ),
//                                                           Text(
//                                                             '$linkCount links',
//                                                             style: const TextStyle(
//                                                               fontSize: 14,
//                                                               color: Colors.white60,
//                                                               fontWeight: FontWeight.w600,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                           ),
//                                         ),

//                                         // Search Icon Button
//                                         GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//                                               _isSearchActive = !_isSearchActive;
//                                               if (!_isSearchActive) {
//                                                 _searchController.clear();
//                                                 _searchQuery = '';
//                                               }
//                                             });
//                                           },
//                                           child: Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                               color: _isSearchActive
//                                                   ? Color(0xFF667eea).withOpacity(0.3)
//                                                   : Colors.white.withOpacity(0.1),
//                                               border: Border.all(
//                                                 color: _isSearchActive
//                                                     ? Color(0xFF667eea).withOpacity(0.5)
//                                                     : Colors.white.withOpacity(0.12),
//                                                 width: 1,
//                                               ),
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                             child: Icon(
//                                               _isSearchActive ? Icons.close : Icons.search_rounded,
//                                               color: Colors.white54,
//                                               size: 18,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),

//                         SizedBox(height: 16),

//                         // Enhanced Links List with Search Filter
//                         StreamBuilder(
//                           stream: _linksStream,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasError) {
//                               return Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [

//                                    SizedBox(
//                                     height: MediaQuery.sizeOf(context).height * 0.14,
//                                   ),
//                                   Text(
//                                     'Oops!\nSomething went wrong.\nPlease Try Again',
//                                     style: TextStyle(color: Colors.white70),
//                                   ),
//                                 ],
//                               );
//                             }

//                             if (snapshot.connectionState == ConnectionState.waiting) {
//                               return Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     height: MediaQuery.sizeOf(context).height * 0.14,
//                                   ),
//                                   CircularProgressIndicator(
//                                     color: Color(0xFF667eea),
//                                   ),
//                                 ],
//                               );
//                             }

//                             final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

//                             if (data == null) {
//                               return _noDataHandler();
//                             }

//                             final items = data.entries.toList();

//                             // Sort by timestamp (most recent first)
//                             items.sort((a, b) {
//                               final aTime = a.value["timestamp"] ?? "";
//                               final bTime = b.value["timestamp"] ?? "";
//                               return bTime.compareTo(aTime);
//                             });

//                             // Filter links based on search query (searches ALL links)
//                             final filteredItems = _filterLinks(items);

//                             // If searching, show all filtered results
//                             // If not searching, show only 4 most recent
//                             final displayItems =
//                                 _searchQuery.isNotEmpty ? filteredItems : items.take(4).toList();

//                             // Show "no results" message if search is active but no matches
//                             if (_searchQuery.isNotEmpty && filteredItems.isEmpty) {
//                               return _noSearchFounds(context);
//                             }

//                             return Expanded(
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: AlwaysScrollableScrollPhysics(),
//                                 itemCount: displayItems.length,
//                                 itemBuilder: (context, index) {
//                                   final link = displayItems[index].value["url"];
//                                   final key = displayItems[index].key;

//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                                     child: Container(
//                                       margin: EdgeInsets.symmetric(vertical: 6),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(0.08),
//                                         borderRadius: BorderRadius.circular(16),
//                                         border: Border.all(
//                                           color: Colors.white.withOpacity(0.1),
//                                         ),
//                                       ),
//                                       child: Material(
//                                         color: Colors.transparent,
//                                         child: InkWell(
//                                           borderRadius: BorderRadius.circular(16),
//                                           onTap: () {
//                                             // Add your tap logic here
//                                           },
//                                           child: Padding(
//                                             padding: EdgeInsets.all(16),
//                                             child: Row(
//                                               children: [
//                                                 // Icon Container
//                                                 Container(
//                                                   width: 48,
//                                                   height: 48,
//                                                   decoration: BoxDecoration(
//                                                     gradient: LinearGradient(
//                                                       begin: Alignment.topLeft,
//                                                       colors: [
//                                                         Colors.blueAccent,
//                                                         Colors.deepPurpleAccent
//                                                       ],
//                                                     ),
//                                                     borderRadius: BorderRadius.circular(12),
//                                                   ),
//                                                   child: Icon(
//                                                     Icons.link,
//                                                     color: Colors.white,
//                                                     size: 24,
//                                                   ),
//                                                 ),
//                                                 SizedBox(width: 14),
//                                                 // Link Text
//                                                 Expanded(
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Text(
//                                                         _extractDomain(link ?? ""),
//                                                         style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontSize: 15,
//                                                           fontWeight: FontWeight.w600,
//                                                         ),
//                                                       ),
//                                                       SizedBox(height: 4),
//                                                       Text(
//                                                         link ?? "",
//                                                         style: TextStyle(
//                                                           color: Colors.white.withOpacity(0.5),
//                                                           fontSize: 13,
//                                                         ),
//                                                         maxLines: 1,
//                                                         overflow: TextOverflow.ellipsis,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 // Action Button
//                                                 Container(
//                                                   padding: EdgeInsets.all(8),
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.white.withOpacity(0.1),
//                                                     borderRadius: BorderRadius.circular(8),
//                                                   ),
//                                                   child: Icon(
//                                                     Icons.open_in_new,
//                                                     color: Colors.white.withOpacity(0.7),
//                                                     size: 18,
//                                                   ),
//                                                 ),
//                                                 SizedBox(width: 8),
//                                                 GestureDetector(
//                                                   onTap: () async {
//                                                     try {
//                                                       await _dbRef.child(key).remove().timeout(
//                                                             Duration(seconds: 5),
//                                                           );
//                                                     } catch (e) {
//                                                       print('Error deleting link: $e');
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     padding: EdgeInsets.all(8),
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.redAccent.withOpacity(0.26),
//                                                       borderRadius: BorderRadius.circular(8),
//                                                     ),
//                                                     child: Icon(
//                                                       Icons.delete_outline_rounded,
//                                                       color: Colors.red,
//                                                       size: 18,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   )
//                 : Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Loading...',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white70,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         CircularProgressIndicator(
//                           color: Color(0xFF667eea),
//                         )
//                       ],
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   Expanded _noSearchFounds(BuildContext context) {
//     return Expanded(
//                               child: Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                      SizedBox(
//                                   height: MediaQuery.sizeOf(context).height * 0.14,
//                                 ),
//                                     Icon(
//                                       Icons.search_off,
//                                       color: Colors.white38,
//                                       size: 64,
//                                     ),
//                                     SizedBox(height: 16),
//                                     Text(
//                                       'No results found',
//                                       style: TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Text(
//                                       'Try searching with different keywords',
//                                       style: TextStyle(
//                                         color: Colors.white38,
//                                         fontSize: 13,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//   }
// }

// Container _noDataHandler() {
//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 60),
//     child: Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white.withOpacity(0.05),
//           ),
//           child: SvgPicture.asset(
//             R.ASSETS_ICONS_EMPTY_NEST_SVG,
//             color: Colors.white.withOpacity(0.3),
//             height: 60,
//           ),
//         ),
//         24.heightBox,
//         Text(
//           'Oops!',
//           style: TextStyle(
//             fontSize: 18,
//             color: Colors.white.withOpacity(0.8),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         8.heightBox,
//         Text(
//           'Your nest is empty',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.white.withOpacity(0.6),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         8.heightBox,
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 40),
//           child: Text(
//             'Start saving your favorite links to see them here.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.white.withOpacity(0.5),
//               fontWeight: FontWeight.w400,
//               height: 1.5,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// // Helper method to extract domain from URL
// String _extractDomain(String url) {
//   try {
//     Uri uri = Uri.parse(url);
//     String domain = uri.host;
//     if (domain.startsWith('www.')) {
//       domain = domain.substring(4);
//     }
//     // Capitalize first letter
//     return domain.split('.')[0].substring(0, 1).toUpperCase() + domain.split('.')[0].substring(1);
//   } catch (e) {
//     return 'Link';
//   }
// }

class _HomePageState extends ConsumerState<HomePage> {
  // Updated to use new database structure
  String? _userId;
  late DatabaseReference _dbRef;
  late DatabaseReference _collectionsRef;
  final TextEditingController _controller = TextEditingController();
  String? pastedUrl;

  // Single stream that both StreamBuilders will share
  late Stream<DatabaseEvent> _linksStream;
  late Stream<DatabaseEvent> _collectionsStream;

  // New variables for search functionality
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;
  Timer? _debounceTimer;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser?.uid;

    if (_userId != null) {
      _dbRef = FirebaseDatabase.instance.ref("users/$_userId/links");
      _collectionsRef = FirebaseDatabase.instance.ref("users/$_userId/collections");
      // Create a single broadcast stream that can be listened to multiple times
      _linksStream = _dbRef.onValue.asBroadcastStream();
      _collectionsStream = _collectionsRef.onValue.asBroadcastStream();
    }

    // Add search listener
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  bool isLoading = false;
  void _logout() async {
    try {
      setState(() {
        isLoading = true;
      });
      final repo = ref.read(authRepositoryProvider);
      await repo.signOut();
      talker.debug('LOGGING OUT');

      if (mounted) {
        await Future.delayed(const Duration(seconds: 2));
        context.router.replaceAll([SigninRoute()]);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      talker.debug('DEBUG CATCH :::::: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Debounced search handler
  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _searchQuery = _searchController.text.toLowerCase().trim();

          // Close search bar if query is empty
          if (_searchQuery.isEmpty) {
            _isSearchActive = false;
          }
        });
      }
    });
  }

  // Updated filter to include collection and tags
  List<MapEntry<dynamic, dynamic>> _filterLinks(List<MapEntry<dynamic, dynamic>> items) {
    if (_searchQuery.isEmpty) {
      return items;
    }

    return items.where((item) {
      final url = (item.value["url"] ?? "").toString().toLowerCase();
      final domain = _extractDomain(item.value["url"] ?? "").toLowerCase();
      final timestamp = item.value["timestamp"] ?? "";
      final collection = (item.value["collection"] ?? "").toString().toLowerCase();

      // Get tags as string
      String tagsStr = "";
      if (item.value["tags"] != null && item.value["tags"] is List) {
        List<dynamic> tags = item.value["tags"];
        tagsStr = tags.join(" ").toLowerCase();
      }

      // Format date for searching
      String dateStr = "";
      try {
        if (timestamp.isNotEmpty) {
          final date = DateTime.parse(timestamp);
          dateStr = "${date.day}/${date.month}/${date.year}".toLowerCase();
        }
      } catch (e) {
        // If date parsing fails, continue without date search
      }

      // Search in domain, url, date, collection, and tags
      return domain.contains(_searchQuery) ||
          url.contains(_searchQuery) ||
          dateStr.contains(_searchQuery) ||
          collection.contains(_searchQuery) ||
          tagsStr.contains(_searchQuery);
    }).toList();
  }

  // Show organize bottom sheet after saving link
  void _showOrganizeSheet(String linkId, String url) {
    String? selectedCollection;
    List<String> selectedTags = [];
    final TextEditingController tagController = TextEditingController();

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
                      children: [
                        Icon(Icons.celebration, color: Color(0xFF667eea), size: 24),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Link Saved! 🎉',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Organize it now',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
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
                    SizedBox(height: 24),

                    // Collection Dropdown
                    Text(
                      'Collection',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    StreamBuilder(
                      stream: _collectionsStream,
                      builder: (context, snapshot) {
                        List<Map<String, dynamic>> collections = [];

                        if (snapshot.hasData && snapshot.data?.snapshot.value != null) {
                          final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                          collections = data.entries
                              .map((e) => {
                                    'id': e.key,
                                    'name': e.value['name'] ?? 'Untitled',
                                  })
                              .toList();
                        }

                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedCollection,
                              isExpanded: true,
                              hint: Text(
                                'Select a collection',
                                style: TextStyle(color: Colors.white38),
                              ),
                              dropdownColor: Color(0xFF1a1a2e),
                              style: TextStyle(color: Colors.white),
                              icon: Icon(Icons.arrow_drop_down, color: Colors.white54),
                              items: [
                                DropdownMenuItem(
                                  value: null,
                                  child: Text('Uncategorized'),
                                ),
                                ...collections.map((collection) {
                                  return DropdownMenuItem<String>(
                                    value: collection['name'],
                                    child: Text(collection['name']),
                                  );
                                }),
                              ],
                              onChanged: (value) {
                                setModalState(() {
                                  selectedCollection = value;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    // Tags Input
                    Text(
                      'Tags',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Display selected tags
                    if (selectedTags.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: selectedTags.map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color(0xFF667eea).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFF667eea).withOpacity(0.4),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '#$tag',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: () {
                                      setModalState(() {
                                        selectedTags.remove(tag);
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                    // Tag input field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: TextField(
                        controller: tagController,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'Add tags (press enter)',
                          hintStyle: TextStyle(color: Colors.white38),
                          prefixIcon: Icon(Icons.label, color: Colors.white.withOpacity(0.5)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty && !selectedTags.contains(value.trim())) {
                            setModalState(() {
                              selectedTags.add(value.trim());
                              tagController.clear();
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                            ),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF667eea).withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () async {
                                  try {
                                    await _dbRef.child(linkId).update({
                                      'collection': selectedCollection ?? '',
                                      'tags': selectedTags,
                                    });
                                    Navigator.pop(context);
                                    if (mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Link organized successfully!'),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.green.shade400,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    print('Error organizing link: $e');
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    'Save',
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
                        ),
                      ],
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
              'Please login to continue',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      // Modern gradient background
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            !isLoading
                ? SafeArea(
                    child: Column(
                      children: [
                        //Header
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              // Avatar with gradient border
                              Container(
                                width: 56,
                                height: 56,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF667eea).withOpacity(0.4),
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/illustrations/profile.jpg'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              // Logout button
                              Spacer(),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.12),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _logout();
                                  },
                                  icon: Icon(
                                    Icons.logout_rounded,
                                    color: Colors.white.withOpacity(0.7),
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Main Content
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Add New Link',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Paste your link below',
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
                                SizedBox(height: 16),
                                // Enhanced TextField
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _controller,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'https://www.example.com',
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.4),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.link,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 18,
                                        horizontal: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                // Enhanced Save Button with gradient
                                Container(
                                  height: 52,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF667eea).withOpacity(0.4),
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
                                        if (_controller.text.trim().isNotEmpty) {
                                          try {
                                            // Save link first
                                            final newLinkRef = _dbRef.push();
                                            await newLinkRef.set({
                                              "url": _controller.text.trim(),
                                              "timestamp": DateTime.now().toIso8601String(),
                                              "collection": "",
                                              "tags": [],
                                            }).timeout(
                                              Duration(seconds: 10),
                                              onTimeout: () {
                                                throw Exception('Save operation timed out');
                                              },
                                            );

                                            if (mounted) {
                                              final savedUrl = _controller.text.trim();
                                              final linkId = newLinkRef.key!;

                                              setState(() {
                                                pastedUrl = savedUrl;
                                              });
                                              _controller.clear();

                                              // Show organize bottom sheet
                                              _showOrganizeSheet(linkId, savedUrl);
                                            }
                                          } catch (e) {
                                            print('Error saving link: $e');
                                            if (mounted) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Failed to save link. Please try again.'),
                                                  behavior: SnackBarBehavior.floating,
                                                  backgroundColor: Colors.red.shade400,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        }
                                      },
                                      child: Center(
                                        child: Text(
                                          'Save Link',
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

                        SizedBox(height: 28),

                        // Links Section Header with Animated Search
                        StreamBuilder(
                          stream: _linksStream,
                          builder: (context, snapshot) {
                            int linkCount = 0;
                            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                              final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                              linkCount = data.length;
                            }

                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  // Bookmark Icon (only show when search is not active)
                                  if (!_isSearchActive)
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
                                        Icons.bookmark_border_rounded,
                                        color: Colors.white54,
                                        size: 18,
                                      ),
                                    ),
                                  if (!_isSearchActive) const SizedBox(width: 8),

                                  // Expandable content
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // Title section or Search bar
                                        Expanded(
                                          child: AnimatedSwitcher(
                                            duration: Duration(milliseconds: 500),
                                            transitionBuilder:
                                                (Widget child, Animation<double> animation) {
                                              return SlideTransition(
                                                position: Tween<Offset>(
                                                  begin: Offset(1.0, 0.0),
                                                  end: Offset.zero,
                                                ).animate(CurvedAnimation(
                                                  parent: animation,
                                                  curve: Curves.easeInOut,
                                                )),
                                                child: FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                ),
                                              );
                                            },
                                            child: _isSearchActive
                                                ? Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Container(
                                                      height: 40,
                                                      padding: EdgeInsets.zero,
                                                      key: ValueKey('search-bar'),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.08),
                                                        borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(
                                                          color: Colors.white.withOpacity(0.1),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: TextField(
                                                        controller: _searchController,
                                                        autofocus: true,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              'Search by name, link, tags or date...',
                                                          hintStyle: TextStyle(
                                                            color: Colors.white.withOpacity(0.4),
                                                            fontSize: 13,
                                                          ),
                                                          prefixIcon: Icon(
                                                            Icons.search,
                                                            color: Colors.white.withOpacity(0.5),
                                                            size: 20,
                                                          ),
                                                          suffixIcon: _searchQuery.isNotEmpty
                                                              ? IconButton(
                                                                  icon: Icon(
                                                                    Icons.clear,
                                                                    color: Colors.white
                                                                        .withOpacity(0.5),
                                                                    size: 20,
                                                                  ),
                                                                  onPressed: () {
                                                                    _searchController.clear();
                                                                    setState(() {
                                                                      _searchQuery = '';
                                                                      _isSearchActive = false;
                                                                    });
                                                                  },
                                                                )
                                                              : null,
                                                          border: InputBorder.none,
                                                          contentPadding: EdgeInsets.symmetric(
                                                            vertical: 12,
                                                            horizontal: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Row(
                                                    key: ValueKey('title-section'),
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Recently Saved',
                                                            style: const TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            '$linkCount links',
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white60,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),

                                        // Search Icon Button
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isSearchActive = !_isSearchActive;
                                              if (!_isSearchActive) {
                                                _searchController.clear();
                                                _searchQuery = '';
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: _isSearchActive
                                                  ? Color(0xFF667eea).withOpacity(0.3)
                                                  : Colors.white.withOpacity(0.1),
                                              border: Border.all(
                                                color: _isSearchActive
                                                    ? Color(0xFF667eea).withOpacity(0.5)
                                                    : Colors.white.withOpacity(0.12),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              _isSearchActive ? Icons.close : Icons.search_rounded,
                                              color: Colors.white54,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 16),

                        // Enhanced Links List with Search Filter
                        StreamBuilder(
                          stream: _linksStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height * 0.14,
                                  ),
                                  Text(
                                    'Oops!\nSomething went wrong.\nPlease Try Again',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              );
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height * 0.14,
                                  ),
                                  CircularProgressIndicator(
                                    color: Color(0xFF667eea),
                                  ),
                                ],
                              );
                            }

                            final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

                            if (data == null) {
                              return _noDataHandler();
                            }

                            final items = data.entries.toList();

                            // Sort by timestamp (most recent first)
                            items.sort((a, b) {
                              final aTime = a.value["timestamp"] ?? "";
                              final bTime = b.value["timestamp"] ?? "";
                              return bTime.compareTo(aTime);
                            });

                            // Filter links based on search query (searches ALL links)
                            final filteredItems = _filterLinks(items);

                            // If searching, show all filtered results
                            // If not searching, show only 4 most recent
                            final displayItems =
                                _searchQuery.isNotEmpty ? filteredItems : items.take(4).toList();

                            // Show "no results" message if search is active but no matches
                            if (_searchQuery.isNotEmpty && filteredItems.isEmpty) {
                              return _noSearchFounds(context);
                            }

                            return Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: displayItems.length,
                                itemBuilder: (context, index) {
                                  final link = displayItems[index].value["url"];
                                  final key = displayItems[index].key;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.1),
                                        ),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(16),
                                          onTap: () {
                                            // Add your tap logic here
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Row(
                                              children: [
                                                // Icon Container
                                                Container(
                                                  width: 48,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      colors: [
                                                        Colors.blueAccent,
                                                        Colors.deepPurpleAccent
                                                      ],
                                                    ),
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Icon(
                                                    Icons.link,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ),
                                                ),
                                                SizedBox(width: 14),
                                                // Link Text
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        _extractDomain(link ?? ""),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        link ?? "",
                                                        style: TextStyle(
                                                          color: Colors.white.withOpacity(0.5),
                                                          fontSize: 13,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Action Button
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        CircularProgressIndicator(
                          color: Color(0xFF667eea),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Expanded _noSearchFounds(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.14,
            ),
            Icon(
              Icons.search_off,
              color: Colors.white38,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container _noDataHandler() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 60),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.05),
          ),
          child: SvgPicture.asset(
            R.ASSETS_ICONS_EMPTY_NEST_SVG,
            color: Colors.white.withOpacity(0.3),
            height: 60,
          ),
        ),
        24.heightBox,
        Text(
          'Oops!',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w600,
          ),
        ),
        8.heightBox,
        Text(
          'Your nest is empty',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        8.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Start saving your favorite links to see them here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper method to extract domain from URL
String _extractDomain(String url) {
  try {
    Uri uri = Uri.parse(url);
    String domain = uri.host;
    if (domain.startsWith('www.')) {
      domain = domain.substring(4);
    }
    // Capitalize first letter
    return domain.split('.')[0].substring(0, 1).toUpperCase() + domain.split('.')[0].substring(1);
  } catch (e) {
    return 'Link';
  }
}
  // ORIGIANL CODE
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // Modern gradient background
  //     body: Container(
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //           colors: [
  //             Color(0xFF1a1a2e),
  //             Color(0xFF16213e),
  //             Color(0xFF0f3460),
  //           ],
  //         ),
  //       ),
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           !isLoading
  //               ? SafeArea(
  //                   child: Column(
  //                     children: [
  //                       //Header
  //                       Container(
  //                         padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
  //                         decoration: BoxDecoration(
  //                           color: Colors.transparent,
  //                         ),
  //                         child: Row(
  //                           children: [
  //                             // Avatar with gradient border
  //                             Container(
  //                               width: 56,
  //                               height: 56,
  //                               padding: EdgeInsets.all(3),
  //                               decoration: BoxDecoration(
  //                                 shape: BoxShape.circle,
  //                                 gradient: LinearGradient(
  //                                   colors: [Color(0xFF667eea), Color(0xFF764ba2)],
  //                                 ),
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                     color: Color(0xFF667eea).withOpacity(0.4),
  //                                     blurRadius: 12,
  //                                     offset: Offset(0, 4),
  //                                   ),
  //                                 ],
  //                               ),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.all(2.0),
  //                                 child: Container(
  //                                   decoration: BoxDecoration(
  //                                     shape: BoxShape.circle,
  //                                     image: DecorationImage(
  //                                       fit: BoxFit.cover,
  //                                       image: AssetImage('assets/illustrations/profile.jpg'),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             16.widthBox,
  //                             // Logout button
  //                             Spacer(),
  //                             Container(
  //                               height: 40,
  //                               width: 40,
  //                               decoration: BoxDecoration(
  //                                 color: Colors.white.withOpacity(0.1),
  //                                 border: Border.all(
  //                                   color: Colors.white.withOpacity(0.12),
  //                                   width: 1,
  //                                 ),
  //                                 borderRadius: BorderRadius.circular(8),
  //                               ),
  //                               child: IconButton(
  //                                 onPressed: () {
  //                                   _logout();
  //                                 },
  //                                 icon: Icon(
  //                                   Icons.logout_rounded,
  //                                   color: Colors.white.withOpacity(0.7),
  //                                   size: 18,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),

  //                       // Main Content
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 16),
  //                         child: Container(
  //                           padding: EdgeInsets.all(12),
  //                           decoration: BoxDecoration(
  //                             color: Colors.white.withOpacity(0.04),
  //                             borderRadius: BorderRadius.circular(20),
  //                             border: Border.all(
  //                               color: Colors.white.withOpacity(0.1),
  //                               width: 1,
  //                             ),
  //                           ),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   Container(
  //                                     padding: EdgeInsets.all(8),
  //                                     decoration: BoxDecoration(
  //                                       gradient: LinearGradient(
  //                                         colors: [Color(0xFF667eea), Color(0xFF764ba2)],
  //                                       ),
  //                                       borderRadius: BorderRadius.circular(10),
  //                                     ),
  //                                     child: Icon(
  //                                       Icons.add_circle_outline,
  //                                       color: Colors.white,
  //                                       size: 20,
  //                                     ),
  //                                   ),
  //                                   12.widthBox,
  //                                   Column(
  //                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         'Add New Link',
  //                                         style: TextStyle(
  //                                           fontSize: 18,
  //                                           color: Colors.white,
  //                                           fontWeight: FontWeight.w600,
  //                                         ),
  //                                       ),
  //                                       Text(
  //                                         'Paste your link below',
  //                                         style: TextStyle(
  //                                           fontSize: 13,
  //                                           color: Colors.white38,
  //                                           fontWeight: FontWeight.w600,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                               16.heightBox,
  //                               // Enhanced TextField
  //                               Container(
  //                                 decoration: BoxDecoration(
  //                                   color: Colors.white.withOpacity(0.08),
  //                                   borderRadius: BorderRadius.circular(16),
  //                                   border: Border.all(
  //                                     color: Colors.white.withOpacity(0.1),
  //                                     width: 1,
  //                                   ),
  //                                 ),
  //                                 child: TextField(
  //                                   controller: _controller,
  //                                   style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontSize: 15,
  //                                   ),
  //                                   decoration: InputDecoration(
  //                                     hintText: 'https://www.example.com',
  //                                     hintStyle: TextStyle(
  //                                       color: Colors.white.withOpacity(0.4),
  //                                     ),
  //                                     prefixIcon: Icon(
  //                                       Icons.link,
  //                                       color: Colors.white.withOpacity(0.5),
  //                                     ),
  //                                     border: InputBorder.none,
  //                                     contentPadding: EdgeInsets.symmetric(
  //                                       vertical: 18,
  //                                       horizontal: 16,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               16.heightBox,
  //                               // Enhanced Save Button with gradient
  //                               Container(
  //                                 height: 52,
  //                                 width: double.infinity,
  //                                 decoration: BoxDecoration(
  //                                   gradient: LinearGradient(
  //                                     colors: [Color(0xFF667eea), Color(0xFF764ba2)],
  //                                   ),
  //                                   borderRadius: BorderRadius.circular(16),
  //                                   boxShadow: [
  //                                     BoxShadow(
  //                                       color: Color(0xFF667eea).withOpacity(0.4),
  //                                       blurRadius: 20,
  //                                       offset: Offset(0, 8),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 child: Material(
  //                                   color: Colors.transparent,
  //                                   child: InkWell(
  //                                     borderRadius: BorderRadius.circular(16),
  //                                     onTap: () async {
  //                                       if (_controller.text.trim().isNotEmpty) {
  //                                         try {
  //                                           await _dbRef.push().set({
  //                                             "url": _controller.text.trim(),
  //                                             "timestamp": DateTime.now().toIso8601String()
  //                                           }).timeout(
  //                                             Duration(seconds: 10),
  //                                             onTimeout: () {
  //                                               throw Exception('Save operation timed out');
  //                                             },
  //                                           );

  //                                           if (mounted) {
  //                                             setState(() {
  //                                               pastedUrl = _controller.text.trim();
  //                                             });
  //                                             _controller.clear();
  //                                           }
  //                                         } catch (e) {
  //                                           print('Error saving link: $e');
  //                                           if (mounted) {
  //                                             ScaffoldMessenger.of(context).showSnackBar(
  //                                               SnackBar(
  //                                                 content: Text(
  //                                                     'Failed to save link. Please try again.'),
  //                                                 behavior: SnackBarBehavior.floating,
  //                                                 backgroundColor: Colors.red.shade400,
  //                                                 shape: RoundedRectangleBorder(
  //                                                   borderRadius: BorderRadius.circular(10),
  //                                                 ),
  //                                               ),
  //                                             );
  //                                           }
  //                                         }
  //                                       }
  //                                     },
  //                                     child: Center(
  //                                       child: Text(
  //                                         'Save Link',
  //                                         style: TextStyle(
  //                                           fontSize: 16,
  //                                           fontWeight: FontWeight.w600,
  //                                           color: Colors.white,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),

  //                       28.heightBox,

  //                       // Links Section Header
  //                       StreamBuilder(
  //                         stream: _linksStream,
  //                         builder: (context, snapshot) {
  //                           int linkCount = 0;
  //                           if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
  //                             final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
  //                             linkCount = data.length;
  //                           }

  //                           return Container(
  //                             padding: const EdgeInsets.symmetric(horizontal: 16),
  //                             child: Row(
  //                               children: [
  //                                 Container(
  //                                   // height: 40,
  //                                   padding: EdgeInsets.all(10),
  //                                   // width: 40,
  //                                   decoration: BoxDecoration(
  //                                     color: Colors.white.withOpacity(0.1),
  //                                     border: Border.all(
  //                                       color: Colors.white.withOpacity(0.12),
  //                                       width: 1,
  //                                     ),
  //                                     borderRadius: BorderRadius.circular(8),
  //                                   ),
  //                                   child: Icon(
  //                                     Icons.bookmark_border_rounded,
  //                                     color: Colors.white54,
  //                                     size: 18,
  //                                   ),
  //                                 ),
  //                                 const SizedBox(width: 8),
  //                                 Expanded(
  //                                   child: Row(
  //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       Column(
  //                                         crossAxisAlignment: CrossAxisAlignment.start,
  //                                         children: [
  //                                           Text(
  //                                             'Recently Saved',
  //                                             style: const TextStyle(
  //                                               fontSize: 18,
  //                                               color: Colors.white,
  //                                               fontWeight: FontWeight.w600,
  //                                             ),
  //                                           ),
  //                                           Text(
  //                                             '$linkCount links',
  //                                             style: const TextStyle(
  //                                               fontSize: 14,
  //                                               color: Colors.white60,
  //                                               fontWeight: FontWeight.w600,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       Container(
  //                                         padding: EdgeInsets.all(10),
  //                                         decoration: BoxDecoration(
  //                                           color: Colors.white.withOpacity(0.1),
  //                                           border: Border.all(
  //                                             color: Colors.white.withOpacity(0.12),
  //                                             width: 1,
  //                                           ),
  //                                           borderRadius: BorderRadius.circular(8),
  //                                         ),
  //                                         child: Icon(
  //                                           Icons.search_rounded,
  //                                           color: Colors.white54,
  //                                           size: 18,
  //                                         ),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           );
  //                         },
  //                       ),

  //                       16.heightBox,

  //                       // Enhanced Links List
  //                       StreamBuilder(
  //                         stream: _linksStream,
  //                         builder: (context, snapshot) {
  //                           if (snapshot.hasError) {
  //                             return Container(
  //                               padding: EdgeInsets.all(40),
  //                               child: Center(
  //                                 child: Text(
  //                                   'Something went wrong',
  //                                   style: TextStyle(color: Colors.white70),
  //                                 ),
  //                               ),
  //                             );
  //                           }

  //                           if (snapshot.connectionState == ConnectionState.waiting) {
  //                             return Container(
  //                               padding: EdgeInsets.all(40),
  //                               child: Center(
  //                                 child: CircularProgressIndicator(
  //                                   color: Color(0xFF667eea),
  //                                 ),
  //                               ),
  //                             );
  //                           }

  //                           final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

  //                           if (data == null) {
  //                             return _noDataHandler();
  //                           }

  //                           final items = data.entries.toList();

  //                           return Expanded(
  //                             child: ListView.builder(
  //                               shrinkWrap: true,
  //                               physics: AlwaysScrollableScrollPhysics(),
  //                               itemCount: items.length,
  //                               itemBuilder: (context, index) {
  //                                 final link = items[index].value["url"];
  //                                 final key = items[index].key;

  //                                 return Padding(
  //                                   padding: const EdgeInsets.symmetric(horizontal: 16),
  //                                   child: Container(
  //                                     margin: EdgeInsets.symmetric(vertical: 6),
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.white.withOpacity(0.08),
  //                                       borderRadius: BorderRadius.circular(16),
  //                                       border: Border.all(
  //                                         color: Colors.white.withOpacity(0.1),
  //                                       ),
  //                                     ),
  //                                     child: Material(
  //                                       color: Colors.transparent,
  //                                       child: InkWell(
  //                                         borderRadius: BorderRadius.circular(16),
  //                                         onTap: () {
  //                                           // Add your tap logic here
  //                                         },
  //                                         child: Padding(
  //                                           padding: EdgeInsets.all(16),
  //                                           child: Row(
  //                                             children: [
  //                                               // Icon Container
  //                                               Container(
  //                                                 width: 48,
  //                                                 height: 48,
  //                                                 decoration: BoxDecoration(
  //                                                   gradient: LinearGradient(
  //                                                     begin: Alignment.topLeft,
  //                                                     colors: [
  //                                                       // Color(0xFF667eea),
  //                                                       // Color(0xFF764ba2)
  //                                                       Colors.blueAccent,
  //                                                       Colors.deepPurpleAccent
  //                                                     ],
  //                                                   ),
  //                                                   borderRadius: BorderRadius.circular(12),
  //                                                 ),
  //                                                 child: Icon(
  //                                                   Icons.link,
  //                                                   color: Colors.white,
  //                                                   size: 24,
  //                                                 ),
  //                                               ),
  //                                               14.widthBox,
  //                                               // Link Text
  //                                               Expanded(
  //                                                 child: Column(
  //                                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                                   children: [
  //                                                     Text(
  //                                                       _extractDomain(link ?? ""),
  //                                                       style: TextStyle(
  //                                                         color: Colors.white,
  //                                                         fontSize: 15,
  //                                                         fontWeight: FontWeight.w600,
  //                                                       ),
  //                                                     ),
  //                                                     4.heightBox,
  //                                                     Text(
  //                                                       link ?? "",
  //                                                       style: TextStyle(
  //                                                         color: Colors.white.withOpacity(0.5),
  //                                                         fontSize: 13,
  //                                                       ),
  //                                                       maxLines: 1,
  //                                                       overflow: TextOverflow.ellipsis,
  //                                                     ),
  //                                                   ],
  //                                                 ),
  //                                               ),
  //                                               // Action Button
  //                                               Container(
  //                                                 padding: EdgeInsets.all(8),
  //                                                 decoration: BoxDecoration(
  //                                                   color: Colors.white.withOpacity(0.1),
  //                                                   borderRadius: BorderRadius.circular(8),
  //                                                 ),
  //                                                 child: Icon(
  //                                                   Icons.open_in_new,
  //                                                   color: Colors.white.withOpacity(0.7),
  //                                                   size: 18,
  //                                                 ),
  //                                               ),
  //                                               8.widthBox,
  //                                               GestureDetector(
  //                                                 onTap: () async {
  //                                                   try {
  //                                                     await _dbRef.child(key).remove().timeout(
  //                                                           Duration(seconds: 5),
  //                                                         );
  //                                                   } catch (e) {
  //                                                     print('Error deleting link: $e');
  //                                                   }
  //                                                 },
  //                                                 child: Container(
  //                                                   padding: EdgeInsets.all(8),
  //                                                   decoration: BoxDecoration(
  //                                                     color: Colors.redAccent.withOpacity(0.26),
  //                                                     borderRadius: BorderRadius.circular(8),
  //                                                   ),
  //                                                   child: Icon(
  //                                                     Icons.delete_outline_rounded,
  //                                                     color: Colors.red,
  //                                                     size: 18,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               : Center(
  //                   child: LoadingWidget(
  //                     title: 'Hold on a moment',
  //                     subTitle: 'Signing you out...',
  //                   ),
  //                 ),
  //         ],
  //       ),
  //     ),
  //   );
  // ENHANCED CODE
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // Modern gradient background
  //     body: Container(
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //           colors: [
  //             Color(0xFF1a1a2e),
  //             Color(0xFF16213e),
  //             Color(0xFF0f3460),
  //           ],
  //         ),
  //       ),
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           !isLoading
  //               ? SafeArea(
  //                   child: Column(
  //                     children: [
  //                       //Header
  //                       Container(
  //                         padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
  //                         decoration: BoxDecoration(
  //                           color: Colors.transparent,
  //                         ),
  //                         child: Row(
  //                           children: [
  //                             // Avatar with gradient border
  //                             Container(
  //                               width: 56,
  //                               height: 56,
  //                               padding: EdgeInsets.all(3),
  //                               decoration: BoxDecoration(
  //                                 shape: BoxShape.circle,
  //                                 gradient: LinearGradient(
  //                                   colors: [Color(0xFF667eea), Color(0xFF764ba2)],
  //                                 ),
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                     color: Color(0xFF667eea).withOpacity(0.4),
  //                                     blurRadius: 12,
  //                                     offset: Offset(0, 4),
  //                                   ),
  //                                 ],
  //                               ),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.all(2.0),
  //                                 child: Container(
  //                                   decoration: BoxDecoration(
  //                                     shape: BoxShape.circle,
  //                                     image: DecorationImage(
  //                                       fit: BoxFit.cover,
  //                                       image: AssetImage('assets/illustrations/profile.jpg'),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             SizedBox(width: 16),
  //                             // Logout button
  //                             Spacer(),
  //                             Container(
  //                               height: 40,
  //                               width: 40,
  //                               decoration: BoxDecoration(
  //                                 color: Colors.white.withOpacity(0.1),
  //                                 border: Border.all(
  //                                   color: Colors.white.withOpacity(0.12),
  //                                   width: 1,
  //                                 ),
  //                                 borderRadius: BorderRadius.circular(8),
  //                               ),
  //                               child: IconButton(
  //                                 onPressed: () {
  //                                   _logout();
  //                                 },
  //                                 icon: Icon(
  //                                   Icons.logout_rounded,
  //                                   color: Colors.white.withOpacity(0.7),
  //                                   size: 18,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),

  //                       // Main Content
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 16),
  //                         child: Container(
  //                           padding: EdgeInsets.all(12),
  //                           decoration: BoxDecoration(
  //                             color: Colors.white.withOpacity(0.04),
  //                             borderRadius: BorderRadius.circular(20),
  //                             border: Border.all(
  //                               color: Colors.white.withOpacity(0.1),
  //                               width: 1,
  //                             ),
  //                           ),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   Container(
  //                                     padding: EdgeInsets.all(8),
  //                                     decoration: BoxDecoration(
  //                                       gradient: LinearGradient(
  //                                         colors: [Color(0xFF667eea), Color(0xFF764ba2)],
  //                                       ),
  //                                       borderRadius: BorderRadius.circular(10),
  //                                     ),
  //                                     child: Icon(
  //                                       Icons.add_circle_outline,
  //                                       color: Colors.white,
  //                                       size: 20,
  //                                     ),
  //                                   ),
  //                                   SizedBox(width: 12),
  //                                   Column(
  //                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         'Add New Link',
  //                                         style: TextStyle(
  //                                           fontSize: 18,
  //                                           color: Colors.white,
  //                                           fontWeight: FontWeight.w600,
  //                                         ),
  //                                       ),
  //                                       Text(
  //                                         'Paste your link below',
  //                                         style: TextStyle(
  //                                           fontSize: 13,
  //                                           color: Colors.white38,
  //                                           fontWeight: FontWeight.w600,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                               SizedBox(height: 16),
  //                               // Enhanced TextField
  //                               Container(
  //                                 decoration: BoxDecoration(
  //                                   color: Colors.white.withOpacity(0.08),
  //                                   borderRadius: BorderRadius.circular(16),
  //                                   border: Border.all(
  //                                     color: Colors.white.withOpacity(0.1),
  //                                     width: 1,
  //                                   ),
  //                                 ),
  //                                 child: TextField(
  //                                   controller: _controller,
  //                                   style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontSize: 15,
  //                                   ),
  //                                   decoration: InputDecoration(
  //                                     hintText: 'https://www.example.com',
  //                                     hintStyle: TextStyle(
  //                                       color: Colors.white.withOpacity(0.4),
  //                                     ),
  //                                     prefixIcon: Icon(
  //                                       Icons.link,
  //                                       color: Colors.white.withOpacity(0.5),
  //                                     ),
  //                                     border: InputBorder.none,
  //                                     contentPadding: EdgeInsets.symmetric(
  //                                       vertical: 18,
  //                                       horizontal: 16,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               SizedBox(height: 16),
  //                               // Enhanced Save Button with gradient
  //                               Container(
  //                                 height: 52,
  //                                 width: double.infinity,
  //                                 decoration: BoxDecoration(
  //                                   gradient: LinearGradient(
  //                                     colors: [Color(0xFF667eea), Color(0xFF764ba2)],
  //                                   ),
  //                                   borderRadius: BorderRadius.circular(16),
  //                                   boxShadow: [
  //                                     BoxShadow(
  //                                       color: Color(0xFF667eea).withOpacity(0.4),
  //                                       blurRadius: 20,
  //                                       offset: Offset(0, 8),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 child: Material(
  //                                   color: Colors.transparent,
  //                                   child: InkWell(
  //                                     borderRadius: BorderRadius.circular(16),
  //                                     onTap: () async {
  //                                       if (_controller.text.trim().isNotEmpty) {
  //                                         try {
  //                                           await _dbRef.push().set({
  //                                             "url": _controller.text.trim(),
  //                                             "timestamp": DateTime.now().toIso8601String()
  //                                           }).timeout(
  //                                             Duration(seconds: 10),
  //                                             onTimeout: () {
  //                                               throw Exception('Save operation timed out');
  //                                             },
  //                                           );

  //                                           if (mounted) {
  //                                             setState(() {
  //                                               pastedUrl = _controller.text.trim();
  //                                             });
  //                                             _controller.clear();
  //                                           }
  //                                         } catch (e) {
  //                                           print('Error saving link: $e');
  //                                           if (mounted) {
  //                                             ScaffoldMessenger.of(context).showSnackBar(
  //                                               SnackBar(
  //                                                 content: Text(
  //                                                     'Failed to save link. Please try again.'),
  //                                                 behavior: SnackBarBehavior.floating,
  //                                                 backgroundColor: Colors.red.shade400,
  //                                                 shape: RoundedRectangleBorder(
  //                                                   borderRadius: BorderRadius.circular(10),
  //                                                 ),
  //                                               ),
  //                                             );
  //                                           }
  //                                         }
  //                                       }
  //                                     },
  //                                     child: Center(
  //                                       child: Text(
  //                                         'Save Link',
  //                                         style: TextStyle(
  //                                           fontSize: 16,
  //                                           fontWeight: FontWeight.w600,
  //                                           color: Colors.white,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),

  //                       SizedBox(height: 28),

  //                       // Links Section Header with Animated Search
  //                       StreamBuilder(
  //                         stream: _linksStream,
  //                         builder: (context, snapshot) {
  //                           int linkCount = 0;
  //                           if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
  //                             final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
  //                             linkCount = data.length;
  //                           }

  //                           return Container(
  //                             padding: const EdgeInsets.symmetric(horizontal: 16),
  //                             child: Row(
  //                               children: [
  //                                 // Bookmark Icon (only show when search is not active)
  //                                 if (!_isSearchActive)
  //                                   Container(
  //                                     padding: EdgeInsets.all(10),
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.white.withOpacity(0.1),
  //                                       border: Border.all(
  //                                         color: Colors.white.withOpacity(0.12),
  //                                         width: 1,
  //                                       ),
  //                                       borderRadius: BorderRadius.circular(8),
  //                                     ),
  //                                     child: Icon(
  //                                       Icons.bookmark_border_rounded,
  //                                       color: Colors.white54,
  //                                       size: 18,
  //                                     ),
  //                                   ),
  //                                 if (!_isSearchActive) const SizedBox(width: 8),

  //                                 // Expandable content
  //                                 Expanded(
  //                                   child: Row(
  //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                     crossAxisAlignment: CrossAxisAlignment.center,
  //                                     children: [
  //                                       // Title section or Search bar
  //                                       Expanded(
  //                                         child: AnimatedSwitcher(
  //                                           duration: Duration(milliseconds: 500),
  //                                           transitionBuilder:
  //                                               (Widget child, Animation<double> animation) {
  //                                             return SlideTransition(
  //                                               position: Tween<Offset>(
  //                                                 begin: Offset(1.0, 0.0),
  //                                                 end: Offset.zero,
  //                                               ).animate(CurvedAnimation(
  //                                                 parent: animation,
  //                                                 curve: Curves.easeInOut,
  //                                               )),
  //                                               child: FadeTransition(
  //                                                 opacity: animation,
  //                                                 child: child,
  //                                               ),
  //                                             );
  //                                           },
  //                                           child: _isSearchActive
  //                                               ? Padding(
  //                                                   padding: const EdgeInsets.all(10.0),
  //                                                   child: Container(
  //                                                     height: 40,
  //                                                     padding: EdgeInsets.zero,
  //                                                     key: ValueKey('search-bar'),
  //                                                     decoration: BoxDecoration(
  //                                                       color: Colors.white.withOpacity(0.08),
  //                                                       borderRadius: BorderRadius.circular(8),
  //                                                       border: Border.all(
  //                                                         color: Colors.white.withOpacity(0.1),
  //                                                         width: 1,
  //                                                       ),
  //                                                     ),
  //                                                     child: TextField(
  //                                                       controller: _searchController,
  //                                                       autofocus: true,
  //                                                       style: TextStyle(
  //                                                         color: Colors.white,
  //                                                         fontSize: 14,
  //                                                       ),
  //                                                       decoration: InputDecoration(
  //                                                         hintText:
  //                                                             'Search by name, link or date...',
  //                                                         hintStyle: TextStyle(
  //                                                           color: Colors.white.withOpacity(0.4),
  //                                                           fontSize: 13,
  //                                                         ),
  //                                                         prefixIcon: Icon(
  //                                                           Icons.search,
  //                                                           color: Colors.white.withOpacity(0.5),
  //                                                           size: 20,
  //                                                         ),
  //                                                         suffixIcon: _searchQuery.isNotEmpty
  //                                                             ? IconButton(
  //                                                                 icon: Icon(
  //                                                                   Icons.clear,
  //                                                                   color: Colors.white
  //                                                                       .withOpacity(0.5),
  //                                                                   size: 20,
  //                                                                 ),
  //                                                                 onPressed: () {
  //                                                                   _searchController.clear();
  //                                                                   setState(() {
  //                                                                     _searchQuery = '';
  //                                                                     _isSearchActive = false;
  //                                                                   });
  //                                                                 },
  //                                                               )
  //                                                             : null,
  //                                                         border: InputBorder.none,
  //                                                         contentPadding: EdgeInsets.symmetric(
  //                                                           vertical: 12,
  //                                                           horizontal: 12,
  //                                                         ),
  //                                                       ),
  //                                                     ),
  //                                                   ),
  //                                                 )
  //                                               : Row(
  //                                                   key: ValueKey('title-section'),
  //                                                   mainAxisAlignment:
  //                                                       MainAxisAlignment.spaceBetween,
  //                                                   children: [
  //                                                     Column(
  //                                                       crossAxisAlignment:
  //                                                           CrossAxisAlignment.start,
  //                                                       children: [
  //                                                         Text(
  //                                                           'Recently Saved',
  //                                                           style: const TextStyle(
  //                                                             fontSize: 18,
  //                                                             color: Colors.white,
  //                                                             fontWeight: FontWeight.w600,
  //                                                           ),
  //                                                         ),
  //                                                         Text(
  //                                                           '$linkCount links',
  //                                                           style: const TextStyle(
  //                                                             fontSize: 14,
  //                                                             color: Colors.white60,
  //                                                             fontWeight: FontWeight.w600,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ],
  //                                                 ),
  //                                         ),
  //                                       ),

  //                                       // Search Icon Button
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           setState(() {
  //                                             _isSearchActive = !_isSearchActive;
  //                                             if (!_isSearchActive) {
  //                                               _searchController.clear();
  //                                               _searchQuery = '';
  //                                             }
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                           padding: EdgeInsets.all(10),
  //                                           decoration: BoxDecoration(
  //                                             color: _isSearchActive
  //                                                 ? Color(0xFF667eea).withOpacity(0.3)
  //                                                 : Colors.white.withOpacity(0.1),
  //                                             border: Border.all(
  //                                               color: _isSearchActive
  //                                                   ? Color(0xFF667eea).withOpacity(0.5)
  //                                                   : Colors.white.withOpacity(0.12),
  //                                               width: 1,
  //                                             ),
  //                                             borderRadius: BorderRadius.circular(8),
  //                                           ),
  //                                           child: Icon(
  //                                             _isSearchActive ? Icons.close : Icons.search_rounded,
  //                                             color: Colors.white54,
  //                                             size: 18,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           );
  //                         },
  //                       ),

  //                       SizedBox(height: 16),

  //                       // Enhanced Links List with Search Filter
  //                       StreamBuilder(
  //                         stream: _linksStream,
  //                         builder: (context, snapshot) {
  //                           if (snapshot.hasError) {
  //                             return Container(
  //                               padding: EdgeInsets.all(40),
  //                               child: Center(
  //                                 child: Text(
  //                                   'Something went wrong',
  //                                   style: TextStyle(color: Colors.white70),
  //                                 ),
  //                               ),
  //                             );
  //                           }

  //                           if (snapshot.connectionState == ConnectionState.waiting) {
  //                             return Container(
  //                               padding: EdgeInsets.all(40),
  //                               child: Center(
  //                                 child: CircularProgressIndicator(
  //                                   color: Color(0xFF667eea),
  //                                 ),
  //                               ),
  //                             );
  //                           }

  //                           final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

  //                           if (data == null) {
  //                             return _noDataHandler();
  //                           }

  //                           final items = data.entries.toList();
  //                           final filteredItems = _filterLinks(items);

  //                           // Show "no results" message if search is active but no matches
  //                           if (_searchQuery.isNotEmpty && filteredItems.isEmpty) {
  //                             return Expanded(
  //                               child: Center(
  //                                 child: Column(
  //                                   mainAxisAlignment: MainAxisAlignment.center,
  //                                   children: [
  //                                     Icon(
  //                                       Icons.search_off,
  //                                       color: Colors.white38,
  //                                       size: 64,
  //                                     ),
  //                                     SizedBox(height: 16),
  //                                     Text(
  //                                       'No results found',
  //                                       style: TextStyle(
  //                                         color: Colors.white70,
  //                                         fontSize: 16,
  //                                         fontWeight: FontWeight.w600,
  //                                       ),
  //                                     ),
  //                                     SizedBox(height: 8),
  //                                     Text(
  //                                       'Try searching with different keywords',
  //                                       style: TextStyle(
  //                                         color: Colors.white38,
  //                                         fontSize: 13,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             );
  //                           }

  //                           return Expanded(
  //                             child: ListView.builder(
  //                               shrinkWrap: true,
  //                               physics: AlwaysScrollableScrollPhysics(),
  //                               itemCount: filteredItems.length,
  //                               itemBuilder: (context, index) {
  //                                 final link = filteredItems[index].value["url"];
  //                                 final key = filteredItems[index].key;

  //                                 return Padding(
  //                                   padding: const EdgeInsets.symmetric(horizontal: 16),
  //                                   child: Container(
  //                                     margin: EdgeInsets.symmetric(vertical: 6),
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.white.withOpacity(0.08),
  //                                       borderRadius: BorderRadius.circular(16),
  //                                       border: Border.all(
  //                                         color: Colors.white.withOpacity(0.1),
  //                                       ),
  //                                     ),
  //                                     child: Material(
  //                                       color: Colors.transparent,
  //                                       child: InkWell(
  //                                         borderRadius: BorderRadius.circular(16),
  //                                         onTap: () {
  //                                           // Add your tap logic here
  //                                         },
  //                                         child: Padding(
  //                                           padding: EdgeInsets.all(16),
  //                                           child: Row(
  //                                             children: [
  //                                               // Icon Container
  //                                               Container(
  //                                                 width: 48,
  //                                                 height: 48,
  //                                                 decoration: BoxDecoration(
  //                                                   gradient: LinearGradient(
  //                                                     begin: Alignment.topLeft,
  //                                                     colors: [
  //                                                       Colors.blueAccent,
  //                                                       Colors.deepPurpleAccent
  //                                                     ],
  //                                                   ),
  //                                                   borderRadius: BorderRadius.circular(12),
  //                                                 ),
  //                                                 child: Icon(
  //                                                   Icons.link,
  //                                                   color: Colors.white,
  //                                                   size: 24,
  //                                                 ),
  //                                               ),
  //                                               SizedBox(width: 14),
  //                                               // Link Text
  //                                               Expanded(
  //                                                 child: Column(
  //                                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                                   children: [
  //                                                     Text(
  //                                                       _extractDomain(link ?? ""),
  //                                                       style: TextStyle(
  //                                                         color: Colors.white,
  //                                                         fontSize: 15,
  //                                                         fontWeight: FontWeight.w600,
  //                                                       ),
  //                                                     ),
  //                                                     SizedBox(height: 4),
  //                                                     Text(
  //                                                       link ?? "",
  //                                                       style: TextStyle(
  //                                                         color: Colors.white.withOpacity(0.5),
  //                                                         fontSize: 13,
  //                                                       ),
  //                                                       maxLines: 1,
  //                                                       overflow: TextOverflow.ellipsis,
  //                                                     ),
  //                                                   ],
  //                                                 ),
  //                                               ),
  //                                               // Action Button
  //                                               Container(
  //                                                 padding: EdgeInsets.all(8),
  //                                                 decoration: BoxDecoration(
  //                                                   color: Colors.white.withOpacity(0.1),
  //                                                   borderRadius: BorderRadius.circular(8),
  //                                                 ),
  //                                                 child: Icon(
  //                                                   Icons.open_in_new,
  //                                                   color: Colors.white.withOpacity(0.7),
  //                                                   size: 18,
  //                                                 ),
  //                                               ),
  //                                               SizedBox(width: 8),
  //                                               GestureDetector(
  //                                                 onTap: () async {
  //                                                   try {
  //                                                     await _dbRef.child(key).remove().timeout(
  //                                                           Duration(seconds: 5),
  //                                                         );
  //                                                   } catch (e) {
  //                                                     print('Error deleting link: $e');
  //                                                   }
  //                                                 },
  //                                                 child: Container(
  //                                                   padding: EdgeInsets.all(8),
  //                                                   decoration: BoxDecoration(
  //                                                     color: Colors.redAccent.withOpacity(0.26),
  //                                                     borderRadius: BorderRadius.circular(8),
  //                                                   ),
  //                                                   child: Icon(
  //                                                     Icons.delete_outline_rounded,
  //                                                     color: Colors.red,
  //                                                     size: 18,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               : Center(
  //                   child: Text(
  //                     'Loading...',
  //                     style: TextStyle(color: Colors.white70),
  //                   ),
  //                 ),
  //         ],
  //       ),
  //     ),
  //   );
  // }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.black,
  //     appBar: AppBar(
  //       notificationPredicate: (notification) => false,
  //       backgroundColor: Colors.black,
  //       leading: Container(
  //         padding: EdgeInsets.all(2),
  //         decoration: BoxDecoration(
  //           border: Border.all(width: 4, color: Colors.blueAccent),
  //           shape: BoxShape.circle,
  //           image: DecorationImage(
  //             fit: BoxFit.contain,
  //             image: AssetImage('assets/illustrations/profile.jpg'),
  //           ),
  //         ),
  //       ),
  //       leadingWidth: 100,
  //       actions: [
  //         IconButton(
  //             onPressed: () {
  //               _logout();
  //             },
  //             icon: Icon(
  //               Icons.logout_rounded,
  //               color: Colors.white54,
  //             ))
  //       ],
  //     ),
  //     body: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         isLoading
  //             ? Center(
  //                 child: LoadingWidget(
  //                   title: 'Hold on a moment',
  //                   subTitle: 'Signing you out...',
  //                 ),
  //               )
  //             : SafeArea(
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
  //                   child: Column(
  //                     children: [
  //                       Container(
  //                         padding: EdgeInsets.all(12),
  //                         decoration: BoxDecoration(
  //                             color: Colors.black,
  //                             // border: Border.all(width: 1, color: Colors.grey),
  //                             borderRadius: BorderRadius.circular(12)),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               'Add new link',
  //                               style: TextStyle(
  //                                 fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
  //                                 color: Colors.white,
  //                                 fontWeight: FontWeight.w700,
  //                                 // letterSpacing: 1,
  //                               ),
  //                             ),
  //                             Text(
  //                               'Paste your link below',
  //                               style: TextStyle(
  //                                 fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
  //                                 color: Colors.white54,
  //                                 fontWeight: FontWeight.w700,
  //                                 // letterSpacing: 1,
  //                               ),
  //                             ),
  //                             16.heightBox,
  //                             // Spacer(),
  //                             TextField(
  //                               controller: _controller,
  //                               style: TextStyle(
  //                                 color: Colors.white,
  //                               ),
  //                               decoration: InputDecoration(
  //                                 hintText: 'https://wwww.example.com',
  //                                 hintStyle: TextStyle(color: Colors.white54),
  //                                 prefixIcon: Icon(Icons.link, color: Colors.grey[400]),
  //                                 // filled: true,
  //                                 // fillColor: Colors.grey[50],
  //                                 border: OutlineInputBorder(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   borderSide: BorderSide(width: 1, color: Colors.white),
  //                                 ),
  //                                 contentPadding:
  //                                     EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  //                               ),
  //                             ),
  //                             // Spacer(),
  //                             20.heightBox,
  //                             GlobalButton(
  //                                 backgroundColor: Colors.white,
  //                                 elevation: 0,
  //                                 child: Text(
  //                                   'Save Link',
  //                                   style: TextStyle(
  //                                       fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
  //                                       fontWeight: FontWeight.w600,
  //                                       letterSpacing: 0,
  //                                       color: Colors.black),
  //                                 ),
  //                                 onPressed: () async {
  //                                   if (_controller.text.trim().isNotEmpty) {
  //                                     try {
  //                                       // Add timeout to prevent hanging
  //                                       await _dbRef.push().set({
  //                                         "url": _controller.text.trim(),
  //                                         "timestamp": DateTime.now().toIso8601String()
  //                                       }).timeout(
  //                                         Duration(seconds: 10),
  //                                         onTimeout: () {
  //                                           throw Exception('Save operation timed out');
  //                                         },
  //                                       );

  //                                       if (mounted) {
  //                                         setState(() {
  //                                           pastedUrl = _controller.text.trim();
  //                                         });
  //                                         _controller.clear();
  //                                       }
  //                                     } catch (e) {
  //                                       print('Error saving link: $e');
  //                                       // Optionally show error to user
  //                                       if (mounted) {
  //                                         ScaffoldMessenger.of(context).showSnackBar(
  //                                           SnackBar(
  //                                               content:
  //                                                   Text('Failed to save link. Please try again.')),
  //                                         );
  //                                       }
  //                                     }
  //                                   }
  //                                 }).h(46).w(double.maxFinite),
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 40,
  //                       ),
  //                       StreamBuilder(
  //                           stream: _linksStream, // Use shared stream
  //                           builder: (context, snapshot) {
  //                             int linkCount = 0;
  //                             if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
  //                               final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
  //                               linkCount = data.length;
  //                             }

  //                             return Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Column(
  //                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                   children: [
  //                                     Text(
  //                                       'Recently Saved',
  //                                       style: TextStyle(
  //                                           fontSize:
  //                                               Theme.of(context).textTheme.titleMedium!.fontSize,
  //                                           color: Colors.white60,
  //                                           fontWeight: FontWeight.w700,
  //                                           letterSpacing: 0.4,
  //                                           wordSpacing: 1),
  //                                     ),

  //                                     // ===== Shows the current saved links count from the DB ======//
  //                                     Text(
  //                                       '$linkCount Links Saved',
  //                                       style: TextStyle(
  //                                           fontSize:
  //                                               Theme.of(context).textTheme.labelSmall!.fontSize,
  //                                           color: Colors.white60,
  //                                           fontWeight: FontWeight.w700,
  //                                           letterSpacing: 0.4,
  //                                           wordSpacing: 1),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 GestureDetector(
  //                                   onTap: () {
  //                                     //====== add logic to clear the recent links from the UI not from the DB .
  //                                     setState(() {
  //                                       // This will trigger a rebuild, but data is still in DB
  //                                     });
  //                                   },
  //                                   child: SizedBox(
  //                                     child: Row(
  //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                       mainAxisSize: MainAxisSize.min,
  //                                       children: [
  //                                         Icon(
  //                                           Icons.search,
  //                                           color: Colors.white38,
  //                                           size: 18,
  //                                         ),
  //                                         4.widthBox,
  //                                         Text(
  //                                           'Search Links',
  //                                           style: TextStyle(
  //                                             fontSize: 14,
  //                                             fontWeight: FontWeight.normal,
  //                                             color: Colors.white38,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             );
  //                           }),
  //                       Expanded(
  //                         child: StreamBuilder(
  //                           stream: _linksStream, // Use shared stream
  //                           builder: (context, snapshot) {
  //                             if (snapshot.hasError) {
  //                               return Center(
  //                                 child: Text(
  //                                   'Something went wrong',
  //                                   style: TextStyle(color: Colors.white70),
  //                                 ),
  //                               );
  //                             }

  //                             if (snapshot.connectionState == ConnectionState.waiting) {
  //                               return const Center(child: CircularProgressIndicator());
  //                             }

  //                             final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

  //                             if (data == null) {
  //                               return Center(
  //                                 child: Column(
  //                                   mainAxisSize: MainAxisSize.min, // shrink-wrap to center
  //                                   children: [
  //                                     // ======= the failed case :- when the DB is empty ======//
  //                                     SvgPicture.asset(
  //                                       R.ASSETS_ICONS_EMPTY_NEST_SVG,
  //                                       color: Colors.white24,
  //                                       height: MediaQuery.sizeOf(context).height * 0.1,
  //                                     ),
  //                                     16.heightBox,
  //                                     Text(
  //                                       'Oops!',
  //                                       style: TextStyle(
  //                                         fontSize:
  //                                             Theme.of(context).textTheme.titleMedium!.fontSize,
  //                                         color: Colors.white70,
  //                                         fontWeight: FontWeight.w600,
  //                                         letterSpacing: 0.6,
  //                                         wordSpacing: 1.2,
  //                                       ),
  //                                     ),
  //                                     10.heightBox,
  //                                     Text(
  //                                       'Your nest is empty',
  //                                       style: TextStyle(
  //                                         fontSize:
  //                                             Theme.of(context).textTheme.titleLarge!.fontSize,
  //                                         color: Colors.white60,
  //                                         fontWeight: FontWeight.w500,
  //                                         letterSpacing: 0.5,
  //                                       ),
  //                                     ),
  //                                     6.heightBox,
  //                                     Text(
  //                                       'Start saving your favorite links to see them here.',
  //                                       textAlign: TextAlign.center,
  //                                       style: TextStyle(
  //                                         fontSize:
  //                                             Theme.of(context).textTheme.bodyMedium!.fontSize,
  //                                         color: Colors.white54,
  //                                         fontWeight: FontWeight.w400,
  //                                         height: 1.4,
  //                                       ),
  //                                     ),

  //                                     //====== LINK PREVIEW USED FOR PREVIEWS ON THE DISPLAY =======//
  //                                     // LinkPreviewExample(url: pastedUrl.toString()),
  //                                   ],
  //                                 ),
  //                               );
  //                             }

  //                             final items = data.entries.toList();

  //                             return ListView.builder(
  //                               itemCount: items.length,
  //                               itemBuilder: (context, index) {
  //                                 final link = items[index].value["url"];
  //                                 final key = items[index].key;

  //                                 return Dismissible(
  //                                   key: Key(key),
  //                                   direction: DismissDirection.endToStart,
  //                                   background: Container(
  //                                     alignment: Alignment.centerRight,
  //                                     padding: EdgeInsets.only(right: 20),
  //                                     color: Colors.red,
  //                                     child: Icon(Icons.delete, color: Colors.white),
  //                                   ),
  //                                   onDismissed: (direction) async {
  //                                     try {
  //                                       await _dbRef.child(key).remove().timeout(
  //                                             Duration(seconds: 5),
  //                                           );
  //                                     } catch (e) {
  //                                       print('Error deleting link: $e');
  //                                     }
  //                                   },
  //                                   child: Container(
  //                                     margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.grey[900],
  //                                       borderRadius: BorderRadius.circular(8),
  //                                       border: Border.all(color: Colors.white12),
  //                                     ),
  //                                     child: ListTile(
  //                                       leading: Icon(Icons.link, color: Colors.blueAccent),
  //                                       title: Text(
  //                                         link ?? "",
  //                                         style: TextStyle(color: Colors.white),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 );
  //                               },
  //                             );
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //       ],
  //     ),
  //   );
  // }