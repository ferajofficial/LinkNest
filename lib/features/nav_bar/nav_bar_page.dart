import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:link_nest/features/collections/collection_page.dart';
import 'package:link_nest/features/home/view/home_page.dart';
import 'package:link_nest/features/tags/tags_page.dart';
import 'package:liquid_glass_bottom_bar/liquid_glass_bottom_bar.dart';

@RoutePage()
class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int currentIndex = 0; // Move this to the state class level

  final List<Widget> screens = const [
    HomePage(),
    CollectionPage(),
    TagsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[currentIndex], // Simplified - no need for PageView here
      bottomNavigationBar: LiquidGlassBottomBar(
        showLabels: false,
        items: const [
          LiquidGlassBottomBarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
          ),
          LiquidGlassBottomBarItem(
            icon: Icons.collections_bookmark_outlined,
            activeIcon: Icons.collections_bookmark_rounded,
            label: 'Collections',
          ),
          LiquidGlassBottomBarItem(
            icon: Icons.tag_rounded,
            activeIcon: Icons.tag_rounded,
            label: 'Tags',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        activeColor: Colors.deepPurpleAccent,
        barBlurSigma: 16,
        activeBlurSigma: 24,
      ),
    );
  }
}

/*
import 'package:auto_route/auto_route.dart';
import 'package:college_buddy/const/resource.dart';
import 'package:college_buddy/features/account_page/account_page.dart';
import 'package:college_buddy/features/homepage/home_page.dart';
import 'package:college_buddy/features/noticepage/notice_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class NavbarPage extends StatelessWidget {
  const NavbarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NavbarView();
  }
}

class NavbarView extends StatefulWidget {
  const NavbarView({super.key});

  @override
  State<NavbarView> createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
  List screen = [
    const HomePage(),
    const NoticePage(),
    const AccountPage(),
  ];
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // double displayWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: PageView.builder(
        pageSnapping: false,
        itemCount: 1,
        itemBuilder: (context, index) {
          return screen[currentIndex];
        },
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.grey.shade400,
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          height: 50,
          backgroundColor: Colors.white,
          // AppColors.kBottomSheetListColor.withOpacity(0.2),
          onDestinationSelected: (value) => setState(() {
            currentIndex = value;
          }),
          destinations: [
            NavigationDestination(icon: SvgPicture.asset(R.ASSETS_ICONS_HOME_SVG, height: 20), label: 'Home'),
            NavigationDestination(icon: SvgPicture.asset(R.ASSETS_ICONS_NOTICE_SVG, height: 20), label: 'Notice'),
            NavigationDestination(icon: SvgPicture.asset(R.ASSETS_ICONS_BANK_SVG, height: 22), label: 'Accounts'),
          ],
        ),
      ),
    );
  }
}
 */
