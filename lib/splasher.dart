import 'package:flutter/material.dart';
import 'package:link_nest/app/view/app.dart';
import 'package:link_nest/bootstrap.dart';
import 'package:link_nest/features/splash/view/splash_view.dart';

// class Splasher extends StatelessWidget {
//   const Splasher({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primaryColor: Colors.blue),
//       home: SplashView(
//         removeSpalshLoader: false,
//         onInitialized: (container) {
//           bootstrap(
//             () => Center(child: const App()),
//             parent: container,
//           );
//         },
//       ),
//     );
//   }
// }


class Splasher extends StatelessWidget {
  const Splasher({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: SplashView(
        removeSpalshLoader: false,
        onInitialized: (container) {
          bootstrap(
            () => App(),  // Pass the container here
            parent: container,
          );
        },
      ),
    );
  }
}