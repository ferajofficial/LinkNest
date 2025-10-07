import 'package:auto_route/auto_route.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

@RoutePage(deferredLoading: true)
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController _controller = TextEditingController();
//   String? pastedUrl;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: Container(
//           padding: EdgeInsets.all(2),
//           decoration: BoxDecoration(
//             border: Border.all(width: 4, color: Colors.blueAccent),
//             shape: BoxShape.circle,
//             image: DecorationImage(
//               fit: BoxFit.contain,
//               image: AssetImage('assets/illustrations/profile.jpg'),
//             ),
//           ),
//         ),
//         leadingWidth: 100,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                     color: Colors.black,
//                     // border: Border.all(width: 1, color: Colors.grey),
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Add new link',
//                       style: TextStyle(
//                         fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                         // letterSpacing: 1,
//                       ),
//                     ),
//                     Text(
//                       'Paste your link below',
//                       style: TextStyle(
//                         fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
//                         color: Colors.white54,
//                         fontWeight: FontWeight.w700,
//                         // letterSpacing: 1,
//                       ),
//                     ),
//                     16.heightBox,
//                     // Spacer(),
//                     TextField(
//                       controller: _controller,
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                       decoration: InputDecoration(
//                         hintText: 'https://wwww.example.com',
//                         hintStyle: TextStyle(color: Colors.white54),
//                         prefixIcon: Icon(Icons.link, color: Colors.grey[400]),
//                         // filled: true,
//                         // fillColor: Colors.grey[50],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(width: 1, color: Colors.white),
//                         ),
//                         contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                       ),
//                     ),
//                     // Spacer(),
//                     20.heightBox,
//                     GlobalButton(
//                         backgroundColor: Colors.white,
//                         elevation: 0,
//                         child: Text(
//                           'Save Link',
//                           style: TextStyle(
//                               fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0,
//                               color: Colors.black),
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             pastedUrl = _controller.text.trim();
//                           });
//                         }).h(46).w(double.maxFinite),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Recently Saved',
//                         style: TextStyle(
//                             fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
//                             color: Colors.white60,
//                             fontWeight: FontWeight.w700,
//                             letterSpacing: 0.4,
//                             wordSpacing: 1),
//                       ),

//                       // ===== Shows the current saved links count from the DB ======//
//                       Text(
//                         '0 Links Saved',
//                         style: TextStyle(
//                             fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
//                             color: Colors.white60,
//                             fontWeight: FontWeight.w700,
//                             letterSpacing: 0.4,
//                             wordSpacing: 1),
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       //====== add logic to clear the recent links from the UI not from the DB .
//                     },
//                     child: SizedBox(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'Clear all',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.normal,
//                               color: Colors.white38,
//                             ),
//                           ),
//                           8.widthBox,
//                           Icon(
//                             Icons.delete_forever,
//                             color: Colors.white38,
//                             size: 18,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min, // shrink-wrap to center
//                     children: [
//                       // ======= the failed case :- when the DB is empty ======//
//                       SvgPicture.asset(
//                         R.ASSETS_ICONS_EMPTY_NEST_SVG,
//                         color: Colors.white24,
//                         height: MediaQuery.sizeOf(context).height * 0.1,
//                       ),
//                       16.heightBox,
//                       Text(
//                         'Oops!',
//                         style: TextStyle(
//                           fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
//                           color: Colors.white70,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: 0.6,
//                           wordSpacing: 1.2,
//                         ),
//                       ),
//                       10.heightBox,
//                       Text(
//                         'Your nest is empty',
//                         style: TextStyle(
//                           fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
//                           color: Colors.white60,
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                       6.heightBox,
//                       Text(
//                         'Start saving your favorite links to see them here.',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
//                           color: Colors.white54,
//                           fontWeight: FontWeight.w400,
//                           height: 1.4,
//                         ),
//                       ),

//                       //====== LINK PREVIEW USED FOR PREVIEWS ON THE DISPLAY =======//
//                       // LinkPreviewExample(url: pastedUrl.toString()),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("links");
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LinkNest")),
      body: Column(
        children: [
          // Input box
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Enter Link",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _dbRef.push().set(
                          {"url": _controller.text, "timestamp": DateTime.now().toIso8601String()});
                      _controller.clear();
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),

          // Show data in realtime
          Expanded(
            child: StreamBuilder(
              stream: _dbRef.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final data = (snapshot.data!).snapshot.value as Map<dynamic, dynamic>?;

                if (data == null) {
                  return const Center(child: Text("No links found"));
                }

                final items = data.entries.toList();

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final link = items[index].value["url"];
                    return ListTile(
                      leading: const Icon(Icons.link),
                      title: Text(link ?? ""),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
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
