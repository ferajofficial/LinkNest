import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:link_nest/core/router/router.gr.dart';
import 'package:link_nest/shared/global_button.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(deferredLoading: true)
// class OnboardingPage extends StatelessWidget {
//   const OnboardingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // INSTEAD OF SIZED BOX ADD CUSTOM INDICATOR
//               // SizedBox(
//               //   height: MediaQuery.sizeOf(context).height * 0.1,
//               // ),
//               Spacer(),
//               Image.asset('assets/animations/save-anything-anytime.gif'),
//               Text(
//                 'Save Anything,\nAnytime.',
//                 style: TextStyle(
//                     fontSize: Theme.of(context).textTheme.displayMedium!.fontSize,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1),
//               ),
//               20.heightBox,
//               Text(
//                 'From YouTube videos to social posts and articles, keep everything in one place.',
//                 style: TextStyle(
//                     fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.black45,
//                     letterSpacing: 0.6),
//               ),
//               // 60.heightBox,
//               Spacer(),
//               GestureDetector(
//                 onTap: () {
//                   //TODO: ADD NAVOGATION LOGIC
//                 },
//                 child: Align(
//                   alignment: Alignment.bottomRight,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 1.2, color: Colors.grey),
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.grey.shade200),
//                     child: Text(
//                       'SKIP',
//                       style: TextStyle(
//                           fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
//                           fontWeight: FontWeight.normal,
//                           color: Colors.black45,
//                           letterSpacing: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//===========ANIMATED========//
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  late AnimationController _titleController;
  late AnimationController _descriptionController;
  late AnimationController _skipController;

  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _descriptionOpacity;
  late Animation<Offset> _descriptionSlide;
  late Animation<double> _skipOpacity;
  late Animation<Offset> _skipSlide;

  int currentPage = 0;
  Timer? _autoProgressTimer;

  // Onboarding data
  final List<OnboardingData> onboardingData = [
    OnboardingData(
      imagePath: 'assets/animations/save-anything-anytime.gif',
      title: 'Save Anything,\nAnytime.',
      description:
          'From YouTube videos to social posts and articles, keep everything in one place.',
    ),
    OnboardingData(
      imagePath: 'assets/animations/Organizing projects.gif',
      title: 'Organize Your\nContent.',
      description:
          'Create collections, add tags, and find what you need instantly with powerful search.',
    ),
    OnboardingData(
      imagePath: 'assets/animations/Working from anywhere .gif',
      title: 'Access Anywhere,\nAnytime.',
      description:
          'Sync across all your devices and access your saved content from anywhere in the world.',
    ),
  ];

  // @override
  // void initState() {
  //   super.initState();

  //   _pageController = PageController();

  //   // Initialize animation controllers
  //   _progressController = AnimationController(
  //     duration: const Duration(seconds: 4),
  //     vsync: this,
  //   );

  //   _titleController = AnimationController(
  //     duration: const Duration(milliseconds: 800),
  //     vsync: this,
  //   );

  //   _descriptionController = AnimationController(
  //     duration: const Duration(milliseconds: 800),
  //     vsync: this,
  //   );

  //   _skipController = AnimationController(
  //     duration: const Duration(milliseconds: 800),
  //     vsync: this,
  //   );

  //   // Create fade and slide animations
  //   _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
  //     CurvedAnimation(parent: _titleController, curve: Curves.easeOut),
  //   );

  //   _titleSlide = Tween<Offset>(
  //     begin: const Offset(0, 0.3),
  //     end: Offset.zero,
  //   ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut));

  //   _descriptionOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
  //     CurvedAnimation(parent: _descriptionController, curve: Curves.easeOut),
  //   );

  //   _descriptionSlide = Tween<Offset>(
  //     begin: const Offset(0, 0.3),
  //     end: Offset.zero,
  //   ).animate(CurvedAnimation(parent: _descriptionController, curve: Curves.easeOut));

  //   _skipOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
  //     CurvedAnimation(parent: _skipController, curve: Curves.easeOut),
  //   );

  //   _skipSlide = Tween<Offset>(
  //     begin: const Offset(0, 0.3),
  //     end: Offset.zero,
  //   ).animate(CurvedAnimation(parent: _skipController, curve: Curves.easeOut));

  //   // Listen to progress animation completion
  //   _progressController.addStatusListener((status) {
  //     if (status == AnimationStatus.completed) {
  //       _moveToNextPage();
  //     }
  //   });

  //   // Start initial animations and progress
  //   _startAnimations();
  //   _startAutoProgress();
  // }

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    // Progress controller
    _progressController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _moveToNextPage();
        }
      });

    // Title animation
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Description animation
    _descriptionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Skip button animation
    _skipController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Title animations
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOut),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut));

    // Description animations
    _descriptionOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _descriptionController, curve: Curves.easeOut),
    );

    _descriptionSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _descriptionController, curve: Curves.easeOut));

    // Skip button animations
    _skipOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _skipController, curve: Curves.easeOut),
    );

    _skipSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _skipController, curve: Curves.easeOut));

    // Start initial animations
    _startAnimations();

    // Start first progress bar AFTER first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _progressController.forward(from: 0.0);
    });
  }

  void _startAnimations() {
    _titleController.forward();

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _descriptionController.forward();
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _skipController.forward();
    });
  }

  void _resetAnimations() {
    _titleController.reset();
    _descriptionController.reset();
    _skipController.reset();
  }

  void _startAutoProgress() {
    _progressController.reset();
    _progressController.forward();
  }

  void _moveToNextPage() {
    if (currentPage < onboardingData.length - 1) {
      setState(() {
        currentPage++;
      });
        _startAutoProgress();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _resetAnimations();
      Future.delayed(const Duration(milliseconds: 300), () {
        _startAnimations();
      });
    } else {
      // Navigate to login screen
      // _navigateToLogin();
    }
  }

  void _skipToEnd() {
    // Navigate to login screen
    setState(() {
      currentPage++;
    });
  }

  void _navigateToLogin() {
    // TODO: Add navigation logic to login screen
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    context.navigateTo(SigninRoute());
  }

  // void _onPageChanged(int index) {
  //   if (index != currentPage) {
  //     setState(() {
  //       currentPage = index;
  //     });
  //     _resetAnimations();
  //     Future.delayed(const Duration(milliseconds: 100), () {
  //       _startAnimations();
  //       _startAutoProgress();
  //     });
  //   }
  // }
  void _onPageChanged(int index) {
    if (index != currentPage) {
      // Reset controller BEFORE setState
      _progressController.stop();
      _progressController.reset();

      setState(() {
        currentPage = index;
      });

      _resetAnimations();

      // Start immediately, no delay needed
      _startAnimations();
      _startAutoProgress();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _skipController.dispose();
    _autoProgressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom Progress Indicator
          // Container(
          //   padding: const EdgeInsets.only(top: 60, left: 14, right: 14),
          //   child: Row(
          //     children: List.generate(
          //       onboardingData.length,
          //       (index) => Expanded(
          //         child: Container(
          //           margin: EdgeInsets.only(
          //             right: index < onboardingData.length - 1 ? 8 : 0,
          //           ),
          //           child: AnimatedBuilder(
          //             animation: _progressController,
          //             builder: (context, child) {
          //               double progress = 0.0;

          //               if (index < currentPage) {
          //                 progress = 1.0;
          //               } else if (index == currentPage) {
          //                 progress =
          //                     _progressController.isDismissed ? 0.0 : _progressController.value;
          //               }

          //               return Container(
          //                 height: 4,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(6),
          //                   color: Colors.grey.shade300,
          //                 ),
          //                 child: FractionallySizedBox(
          //                   alignment: Alignment.centerLeft,
          //                   widthFactor: progress,
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(10),
          //                       color: Colors.black,
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          Container(
            padding: const EdgeInsets.only(top: 60, left: 14, right: 14),
            child: Row(
              children: List.generate(
                onboardingData.length,
                (index) => Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: index < onboardingData.length - 1 ? 8 : 0,
                    ),
                    child: AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) {
                        double progress = 0.0;

                        if (index < currentPage) {
                          progress = 1.0;
                        } else if (index == currentPage) {
                          progress = _progressController.value.clamp(0.0, 1.0);
                        }

                        return Container(
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.shade300,
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progress,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          // PageView Content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),

                      // GIF/Image
                      Center(
                        child: Image.asset(data.imagePath),
                      ),

                      // Animated title
                      SlideTransition(
                        position: _titleSlide,
                        child: FadeTransition(
                          opacity: _titleOpacity,
                          child: Text(
                            data.title,
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.displayMedium!.fontSize,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),

                      20.heightBox,

                      // Animated description
                      SlideTransition(
                        position: _descriptionSlide,
                        child: FadeTransition(
                          opacity: _descriptionOpacity,
                          child: Text(
                            data.description,
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                              fontWeight: FontWeight.normal,
                              color: Colors.black45,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      SlideTransition(
                        position: _skipSlide,
                        child: FadeTransition(
                          opacity: _skipOpacity,
                          child: buildCustomButtons(
                            onSkip: _skipToEnd,
                            onPrevious: _goToPrevious,
                            onLogin: _navigateToLogin,
                            onGetStarted: _navigateToLogin, // or whatever function you want
                          ),
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget? buildCustomButtons({
    Function? onSkip,
    Function? onPrevious,
    Function? onLogin,
    Function? onGetStarted,
  }) {
    return currentPage == 0
        ? GestureDetector(
            onTap: () {
              if (onSkip != null) onSkip();
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  fontWeight: FontWeight.normal,
                  color: Colors.black45,
                  letterSpacing: 1,
                ),
              ),
            ),
          )
        : currentPage == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (onPrevious != null) onPrevious();
                    },
                    child: Text(
                      'PREVIOUS',
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.normal,
                        color: Colors.black45,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (onSkip != null) onSkip();
                    },
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.normal,
                        color: Colors.black45,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              )
            : currentPage == 2
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: GlobalButton(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          onPressed: () {
                            if (onLogin != null) onLogin();
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ).w(200),
                      ),
                      Flexible(
                        child: GlobalButton(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          onPressed: () {
                            if (onGetStarted != null) onGetStarted();
                          },
                          child: Text(
                            'GET STARTED',
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : null;
  }

  void _goToPrevious() {
    setState(() {
      currentPage--;
    });
  }
}

// Data model for onboarding content
class OnboardingData {
  final String imagePath;
  final String title;
  final String description;

  OnboardingData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}


// class OnboardingPage extends StatefulWidget {
//   const OnboardingPage({super.key});

//   @override
//   State<OnboardingPage> createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<OnboardingPage>
//     with SingleTickerProviderStateMixin {
//   late final PageController _pageController;
//   late final AnimationController _progressController;

//   int currentPage = 0;
//   final Duration progressDuration = const Duration(seconds: 5);

//   final List<String> onboardingData = [
//     "Welcome to LinkNest!",
//     "Connect everything in one place.",
//     "Share with the world.",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);

//     _progressController = AnimationController(
//       vsync: this,
//       duration: progressDuration,
//     )..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           if (currentPage < onboardingData.length - 1) {
//             _pageController.nextPage(
//               duration: const Duration(milliseconds: 350),
//               curve: Curves.easeInOut,
//             );
//           } else {
//             // last page: stop
//           }
//         }
//       });

//     // Start first progress
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) _progressController.forward(from: 0.0);
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _progressController.dispose();
//     super.dispose();
//   }

//   void _onPageChanged(int index) {
//     if (!mounted) return;
//     if (index == currentPage) return;

//     // Reset immediately
//     _progressController.stop();
//     _progressController.value = 0.0;

//     setState(() {
//       currentPage = index;
//     });

//     // Restart safely after rebuild
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) _progressController.forward(from: 0.0);
//     });
//   }

//   Widget _buildProgressIndicator() {
//     return Container(
//       padding: const EdgeInsets.only(top: 60, left: 14, right: 14),
//       child: Row(
//         children: List.generate(
//           onboardingData.length,
//           (index) => Expanded(
//             child: Container(
//               margin: EdgeInsets.only(
//                 right: index < onboardingData.length - 1 ? 8 : 0,
//               ),
//               child: AnimatedBuilder(
//                 animation: _progressController,
//                 builder: (context, child) {
//                   double progress = 0.0;

//                   if (index < currentPage) {
//                     progress = 1.0;
//                   } else if (index == currentPage) {
//                     progress = _progressController.value.clamp(0.0, 1.0);
//                   }

//                   return Container(
//                     height: 4,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(6),
//                       color: Colors.grey.shade300,
//                     ),
//                     child: FractionallySizedBox(
//                       alignment: Alignment.centerLeft,
//                       widthFactor: progress,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPageView() {
//     return PageView.builder(
//       controller: _pageController,
//       itemCount: onboardingData.length,
//       onPageChanged: _onPageChanged,
//       itemBuilder: (context, index) {
//         return Center(
//           child: Text(
//             onboardingData[index],
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _buildPageView(),
//           _buildProgressIndicator(),
//         ],
//       ),
//     );
//   }
// }
          // Example content to see circles behind