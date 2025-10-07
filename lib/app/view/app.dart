// ignore_for_file: deprecated_member_use

import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_nest/core/guards/auth_guards.dart';
import 'package:link_nest/core/router/auto_route_observer.dart';
import 'package:link_nest/core/router/router.dart';
import 'package:link_nest/core/router/router_pod.dart';
import 'package:link_nest/core/theme/app_theme.dart';
import 'package:link_nest/core/theme/theme_controller.dart';
import 'package:link_nest/l10n/arb/app_localizations.dart';
import 'package:link_nest/shared/helper/global_helper.dart';
import 'package:link_nest/shared/pods/locale_pod.dart';
import 'package:link_nest/shared/widget/no_internet_widget.dart';
import 'package:link_nest/shared/widget/responsive_wrapper.dart';

///This class holds Material App or Cupertino App
///with routing,theming and locale setup .
///Also responsive framerwork used for responsive application
///which auto resize or autoscale the app.
// class App extends ConsumerStatefulWidget {
//    final ProviderContainer container;
//   const App(this.container, {super.key});

//   @override
//   ConsumerState<App> createState() => _AppState();
// }

// class _AppState extends ConsumerState<App> with GlobalHelper {

//   @override
//   Widget build(BuildContext context) {
//   final authGuard = AuthGuard();
//     final appRouter = AppRouter(authGuard: authGuard);
//     final approuter = ref.watch(autorouterProvider);
//     final currentTheme = ref.watch(themecontrollerProvider);
//     final locale = ref.watch(localePod);
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Link Nest',
//       theme: Themes.theme,
//       darkTheme: Themes.darkTheme,
//       themeMode: currentTheme,
//       routerConfig: approuter.config(
//         placeholder: (context) => const SizedBox.shrink(),
//         navigatorObservers: () => [
//           RouterObserver(),
//         ],
//       ),
//       localizationsDelegates: AppLocalizations.localizationsDelegates,
//       supportedLocales: AppLocalizations.supportedLocales,
//       locale: locale,
//       builder: (context, child) {
//         if (mounted) {
//           ///Used for responsive design
//           ///Here you can define breakpoint and how the responsive should work
//           child = ResponsiveBreakPointWrapper(
//             firstFrameWidget: Container(
//               color: Colors.white,
//             ),
//             child: child!,
//           );

//           /// Add support for maximum text scale according to changes in
//           /// accessibilty in sytem settings
//           final mediaquery = MediaQuery.of(context);
//           child = MediaQuery(
//             data: mediaquery.copyWith(
//               textScaler: TextScaler.linear(mediaquery.textScaleFactor.clamp(0, 1)),
//             ),
//             child: child,
//           );

//           /// Added annotate region by default to switch according to theme which
//           /// customize the system ui veray style
//           child = AnnotatedRegion<SystemUiOverlayStyle>(
//             value: currentTheme == ThemeMode.dark
//                 ? SystemUiOverlayStyle.light.copyWith(
//                     statusBarColor: Colors.white,
//                     systemNavigationBarColor: Colors.black,
//                     systemNavigationBarDividerColor: Colors.black,
//                     systemNavigationBarIconBrightness: Brightness.dark,
//                   )
//                 : currentTheme == ThemeMode.light
//                     ? SystemUiOverlayStyle.dark.copyWith(
//                         statusBarColor: Colors.white,
//                         systemNavigationBarColor: Colors.grey,
//                         systemNavigationBarDividerColor: Colors.grey,
//                         systemNavigationBarIconBrightness: Brightness.light,
//                       )
//                     : SystemUiOverlayStyle.dark.copyWith(
//                         statusBarColor: Colors.white,
//                         systemNavigationBarColor: Colors.grey,
//                         systemNavigationBarDividerColor: Colors.grey,
//                         systemNavigationBarIconBrightness: Brightness.light,
//                       ),
//             child: GestureDetector(
//               child: child,
//               onTap: () {
//                 hideKeyboard();
//               },
//             ),
//           );
//         } else {
//           child = const SizedBox.shrink();
//         }

//         ///Add toast support for flash
//         return Toast(
//           navigatorKey: navigatorKey,
//           child: child,
//         ).monitorConnection();
//       },
//     );
//   }
// }


class App extends ConsumerStatefulWidget {
  final ProviderContainer container;
  const App(this.container, {super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    // Create AuthGuard with ref
    final authGuard = AuthGuard(ref);
    
    // Create router with the guard
    final appRouter = AppRouter(authGuard: authGuard);
    
    final currentTheme = ref.watch(themecontrollerProvider);
    final locale = ref.watch(localePod);
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Link Nest',
      theme: Themes.theme,
      darkTheme: Themes.darkTheme,
      themeMode: currentTheme,
      routerConfig: appRouter.config(  // Use appRouter instead of approuter
        placeholder: (context) => const SizedBox.shrink(),
        navigatorObservers: () => [
          RouterObserver(),
        ],
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      builder: (context, child) {
        if (mounted) {
          ///Used for responsive design
          child = ResponsiveBreakPointWrapper(
            firstFrameWidget: Container(
              color: Colors.white,
            ),
            child: child!,
          );

          final mediaquery = MediaQuery.of(context);
          child = MediaQuery(
            data: mediaquery.copyWith(
              textScaler: TextScaler.linear(mediaquery.textScaleFactor.clamp(0, 1)),
            ),
            child: child,
          );

          child = AnnotatedRegion<SystemUiOverlayStyle>(
            value: currentTheme == ThemeMode.dark
                ? SystemUiOverlayStyle.light.copyWith(
                    statusBarColor: Colors.white,
                    systemNavigationBarColor: Colors.black,
                    systemNavigationBarDividerColor: Colors.black,
                    systemNavigationBarIconBrightness: Brightness.dark,
                  )
                : currentTheme == ThemeMode.light
                    ? SystemUiOverlayStyle.dark.copyWith(
                        statusBarColor: Colors.white,
                        systemNavigationBarColor: Colors.grey,
                        systemNavigationBarDividerColor: Colors.grey,
                        systemNavigationBarIconBrightness: Brightness.light,
                      )
                    : SystemUiOverlayStyle.dark.copyWith(
                        statusBarColor: Colors.white,
                        systemNavigationBarColor: Colors.grey,
                        systemNavigationBarDividerColor: Colors.grey,
                        systemNavigationBarIconBrightness: Brightness.light,
                      ),
            child: GestureDetector(
              child: child,
              onTap: () {
                hideKeyboard();
              },
            ),
          );
        } else {
          child = const SizedBox.shrink();
        }

        return Toast(
          navigatorKey: navigatorKey,
          child: child,
        ).monitorConnection();
      },
    );
  }
}