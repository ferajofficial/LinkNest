import 'package:auto_route/auto_route.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_nest/bootstrap.dart';
import 'package:link_nest/const/resource.dart';
import 'package:link_nest/core/router/router.gr.dart';
import 'package:link_nest/data/providers/auth/auth_repo_provider.dart';
import 'package:link_nest/shared/global_loader.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(deferredLoading: true)
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("links");
  final TextEditingController _controller = TextEditingController();
  String? pastedUrl;

  // Single stream that both StreamBuilders will share
  late final Stream<DatabaseEvent> _linksStream;

  @override
  void initState() {
    super.initState();
    // Create a single broadcast stream that can be listened to multiple times
    _linksStream = _dbRef.onValue.asBroadcastStream();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

//TODO: logout bug should be fixed .
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
  @override
  Widget build(BuildContext context) {
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
                        // Enhanced Header with glassmorphism
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            // gradient: LinearGradient(colors: [
                            //   Color(0xFF1a1a2e),
                            //   Color(0xFF16213e),
                            // ]),
                            // // border: Border(
                            // //   bottom: BorderSide(
                            // //     color: Colors.white.withOpacity(0.1),
                            // //     width: 1,
                            // //   ),
                            // // ),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Color(0xFF667eea).withOpacity(0.2),
                            //     blurRadius: 20,
                            //     offset: Offset(0, 4),
                            //   ),
                            // ],
                          ),
                          child: Row(
                            children: [
                              // Enhanced Avatar with gradient border
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
                              16.widthBox,
                              // Profile Info
                              // Expanded(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         'Link Nest',
                              //         style: TextStyle(
                              //           fontSize: 20,
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.w600,
                              //         ),
                              //       ),
                              //       // 4.heightBox,
                              //       Text(
                              //         'Save & organize your links',
                              //         style: TextStyle(
                              //           fontSize: 14,
                              //           color: Colors.white.withOpacity(0.6),
                              //           fontWeight: FontWeight.w400,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
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
                                    12.widthBox,
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
                                16.heightBox,
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
                                16.heightBox,
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
                                            await _dbRef.push().set({
                                              "url": _controller.text.trim(),
                                              "timestamp": DateTime.now().toIso8601String()
                                            }).timeout(
                                              Duration(seconds: 10),
                                              onTimeout: () {
                                                throw Exception('Save operation timed out');
                                              },
                                            );

                                            if (mounted) {
                                              setState(() {
                                                pastedUrl = _controller.text.trim();
                                              });
                                              _controller.clear();
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

                        28.heightBox,

                        // Links Section Header
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
                                  Container(
                                    // height: 40,
                                    padding: EdgeInsets.all(10),
                                    // width: 40,
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
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                            Icons.search_rounded,
                                            color: Colors.white54,
                                            size: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        16.heightBox,

                        // Enhanced Links List
                        StreamBuilder(
                          stream: _linksStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Container(
                                padding: EdgeInsets.all(40),
                                child: Center(
                                  child: Text(
                                    'Something went wrong',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              );
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                padding: EdgeInsets.all(40),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF667eea),
                                  ),
                                ),
                              );
                            }

                            final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

                            if (data == null) {
                              return _noDataHandler();
                            }

                            final items = data.entries.toList();

                            return Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  final link = items[index].value["url"];
                                  final key = items[index].key;

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
                                                        // Color(0xFF667eea),
                                                        // Color(0xFF764ba2)
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
                                                14.widthBox,
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
                                                      4.heightBox,
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
                                                8.widthBox,
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
                    child: LoadingWidget(
                      title: 'Hold on a moment',
                      subTitle: 'Signing you out...',
                    ),
                  ),
          ],
        ),
      ),
    );
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
}

class LinkPreviewExample extends StatelessWidget {
  final String url;

  const LinkPreviewExample({super.key, required this.url}); // any link user pasted

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LinkPreview(
        squareImageSize: 20,
        maxWidth: double.maxFinite,
        minWidth: double.maxFinite,
        enableAnimation: true,
        forcedLayout: LinkPreviewImagePosition.bottom,
        onLinkPreviewDataFetched: (data) {
          print("Preview fetched: ${data.title}");
        },
        text: url,
      ),
    );
  }
}
