import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    // Initialize animation controllers
    _progressController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _titleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _descriptionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _skipController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Create fade and slide animations
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOut),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut));

    _descriptionOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _descriptionController, curve: Curves.easeOut),
    );

    _descriptionSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _descriptionController, curve: Curves.easeOut));

    _skipOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _skipController, curve: Curves.easeOut),
    );

    _skipSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _skipController, curve: Curves.easeOut));

    // Listen to progress animation completion
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _moveToNextPage();
      }
    });

    // Start initial animations and progress
    _startAnimations();
    _startAutoProgress();
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
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _resetAnimations();
      Future.delayed(const Duration(milliseconds: 300), () {
        _startAnimations();
        _startAutoProgress();
      });
    } else {
      // Navigate to login screen
      _navigateToLogin();
    }
  }

  void _skipToEnd() {
    // Navigate to login screen
    _navigateToLogin();
  }

  void _navigateToLogin() {
    // TODO: Add navigation logic to login screen
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _onPageChanged(int index) {
    if (index != currentPage) {
      setState(() {
        currentPage = index;
      });
      _resetAnimations();
      Future.delayed(const Duration(milliseconds: 100), () {
        _startAnimations();
        _startAutoProgress();
      });
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
                          progress = _progressController.value;
                        }

                        return Container(
                          height: 6,
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
    VoidCallback? onSkip,
    VoidCallback? onPrevious,
    VoidCallback? onLogin,
    VoidCallback? onGetStarted,
  }) {
    return currentPage == 0
        ? GestureDetector(
            onTap: onSkip, // Fixed: removed parentheses and semicolon
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Added for better spacing
                children: [
                  GestureDetector(
                    onTap: onPrevious, // Fixed: call the callback properly
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
                  // Removed Spacer() as mainAxisAlignment handles spacing
                  GestureDetector(
                    onTap: onSkip, // Fixed: call the callback properly
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Better spacing
                    children: [
                      Flexible(
                        // Use Flexible instead of fixed width
                        child: GlobalButton(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          onPressed: onLogin,
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ), // Fixed: call the callback properly
                        ).w(200),
                      ), // Fixed spacing instead of Spacer
                      Flexible(
                        // Use Flexible for responsive layout
                        child: GlobalButton(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          onPressed: onGetStarted,
                          child: Text(
                            'GET STARTED',
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ), // Fixed: call the callback properly
                        ),
                      ),
                    ],
                  )
                : null;
  }

  void _goToPrevious() {}
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

// class _OnboardingPageState extends State<OnboardingPage> with TickerProviderStateMixin {
//   late PageController _pageController;
//   late AnimationController _progressController;
//   late AnimationController _titleController;
//   late AnimationController _descriptionController;
//   late AnimationController _skipController;
//   late AnimationController _buttonMorphController;

//   late Animation<double> _titleOpacity;
//   late Animation<Offset> _titleSlide;
//   late Animation<double> _descriptionOpacity;
//   late Animation<Offset> _descriptionSlide;
//   late Animation<double> _skipOpacity;
//   late Animation<Offset> _skipSlide;

//   int currentPage = 0;
//   Timer? _autoProgressTimer;

//   // Onboarding data
//   final List<OnboardingData> onboardingData = [
//     OnboardingData(
//       imagePath: 'assets/animations/save-anything-anytime.gif',
//       title: 'Save Anything,\nAnytime.',
//       description:
//           'From YouTube videos to social posts and articles, keep everything in one place.',
//     ),
//     OnboardingData(
//       imagePath: 'assets/animations/Organizing projects.gif',
//       title: 'Organize Your\nContent.',
//       description:
//           'Create collections, add tags, and find what you need instantly with powerful search.',
//     ),
//     OnboardingData(
//       imagePath: 'assets/animations/Working from anywhere .gif',
//       title: 'Access Anywhere,\nAnytime.',
//       description:
//           'Sync across all your devices and access your saved content from anywhere in the world.',
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();

//     _pageController = PageController();

//     // Initialize animation controllers
//     _progressController = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     );

//     _titleController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _descriptionController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _skipController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _buttonMorphController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );

//     // Create fade and slide animations
//     _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _titleController, curve: Curves.easeOut),
//     );

//     _titleSlide = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut));

//     _descriptionOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _descriptionController, curve: Curves.easeOut),
//     );

//     _descriptionSlide = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _descriptionController, curve: Curves.easeOut));

//     _skipOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _skipController, curve: Curves.easeOut),
//     );

//     _skipSlide = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _skipController, curve: Curves.easeOut));

//     // Listen to progress animation completion
//     _progressController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _moveToNextPage();
//       }
//     });

//     // Start initial animations and progress
//     _startAnimations();
//     _startAutoProgress();
//   }

//   void _startAnimations() {
//     _titleController.forward();

//     Future.delayed(const Duration(milliseconds: 200), () {
//       if (mounted) _descriptionController.forward();
//     });

//     Future.delayed(const Duration(milliseconds: 400), () {
//       if (mounted) {
//         _skipController.forward();
//         _buttonMorphController.forward();
//       }
//     });
//   }

//   void _resetAnimations() {
//     _titleController.reset();
//     _descriptionController.reset();
//     _skipController.reset();
//     _buttonMorphController.reset();
//   }

//   void _startAutoProgress() {
//     _progressController.reset();
//     _progressController.forward();
//   }

//   void _moveToNextPage() {
//     if (currentPage < onboardingData.length - 1) {
//       setState(() {
//         currentPage++;
//       });
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//       _resetAnimations();
//       Future.delayed(const Duration(milliseconds: 300), () {
//         _startAnimations();
//         _startAutoProgress();
//       });
//     } else {
//       // Navigate to login screen
//       _navigateToLogin();
//     }
//   }

//   void _skipToEnd() {
//     // Navigate to login screen
//     _navigateToLogin();
//   }

//   void _goToPrevious() {
//     if (currentPage > 0) {
//       setState(() {
//         currentPage--;
//       });
//       _pageController.previousPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//       _resetAnimations();
//       Future.delayed(const Duration(milliseconds: 300), () {
//         _startAnimations();
//         _startAutoProgress();
//       });
//     }
//   }

//   void _navigateToLogin() {
//     // TODO: Add navigation logic to login screen
//     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
//   }

//   void _onPageChanged(int index) {
//     if (index != currentPage) {
//       setState(() {
//         currentPage = index;
//       });
//       _resetAnimations();
//       Future.delayed(const Duration(milliseconds: 100), () {
//         _startAnimations();
//         _startAutoProgress();
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _progressController.dispose();
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _skipController.dispose();
//     _buttonMorphController.dispose();
//     _autoProgressTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           // Custom Progress Indicator
//           Container(
//             padding: const EdgeInsets.only(top: 60, left: 14, right: 14),
//             child: Row(
//               children: List.generate(
//                 onboardingData.length,
//                 (index) => Expanded(
//                   child: Container(
//                     margin: EdgeInsets.only(
//                       right: index < onboardingData.length - 1 ? 8 : 0,
//                     ),
//                     child: AnimatedBuilder(
//                       animation: _progressController,
//                       builder: (context, child) {
//                         double progress = 0.0;

//                         if (index < currentPage) {
//                           progress = 1.0;
//                         } else if (index == currentPage) {
//                           progress = _progressController.value;
//                         }

//                         return Container(
//                           height: 4,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Colors.grey.shade300,
//                           ),
//                           child: FractionallySizedBox(
//                             alignment: Alignment.centerLeft,
//                             widthFactor: progress,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // PageView Content
//           Expanded(
//             child: PageView.builder(
//               controller: _pageController,
//               onPageChanged: _onPageChanged,
//               itemCount: onboardingData.length,
//               itemBuilder: (context, index) {
//                 final data = onboardingData[index];
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 14.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Spacer(),

//                       // GIF/Image
//                       Center(
//                         child: Image.asset(data.imagePath),
//                       ),

//                       // Animated title
//                       SlideTransition(
//                         position: _titleSlide,
//                         child: FadeTransition(
//                           opacity: _titleOpacity,
//                           child: Text(
//                             data.title,
//                             style: TextStyle(
//                               fontSize: Theme.of(context).textTheme.displayMedium!.fontSize,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1,
//                             ),
//                           ),
//                         ),
//                       ),

//                       20.heightBox,

//                       // Animated description
//                       SlideTransition(
//                         position: _descriptionSlide,
//                         child: FadeTransition(
//                           opacity: _descriptionOpacity,
//                           child: Text(
//                             data.description,
//                             style: TextStyle(
//                               fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black45,
//                               letterSpacing: 0.6,
//                             ),
//                           ),
//                         ),
//                       ),

//                       const Spacer(),

//                       // Animated button section
//                       SlideTransition(
//                         position: _skipSlide,
//                         child: FadeTransition(
//                           opacity: _skipOpacity,
//                           child: _buildAnimatedButtons(),
//                         ),
//                       ),

//                       const Spacer(),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAnimatedButtons() {
//     return AnimatedBuilder(
//       animation: _buttonMorphController,
//       builder: (context, child) {
//         if (currentPage == 0) {
//           // First page - only skip button on the right
//           return Align(
//             alignment: Alignment.bottomRight,
//             child: _buildButton(
//               text: 'SKIP',
//               onTap: _skipToEnd,
//               isBlack: false,
//             ),
//           );
//         } else if (currentPage == 1) {
//           // Second page - Previous (left) and Skip (right)
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Previous button - morphs from left side
//               Transform.scale(
//                 scale: _buttonMorphController.value,
//                 alignment: Alignment.centerLeft,
//                 child: Opacity(
//                   opacity: _buttonMorphController.value,
//                   child: _buildButton(
//                     text: 'PREVIOUS',
//                     onTap: _goToPrevious,
//                     isBlack: false,
//                   ),
//                 ),
//               ),
//               // Skip button - stays on right
//               _buildButton(
//                 text: 'SKIP',
//                 onTap: _skipToEnd,
//                 isBlack: false,
//               ),
//             ],
//           );
//         } else {
//           // Last page - Login Instead (left) and Get Started (right)
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Login Instead button - morphs from left
//               Transform.scale(
//                 scale: _buttonMorphController.value,
//                 alignment: Alignment.centerLeft,
//                 child: Opacity(
//                   opacity: _buttonMorphController.value,
//                   child: _buildButton(
//                     text: 'LOGIN INSTEAD',
//                     onTap: _navigateToLogin,
//                     isBlack: true,
//                   ),
//                 ),
//               ),
//               // Get Started button - morphs from skip position
//               Transform.scale(
//                 scale: _buttonMorphController.value,
//                 alignment: Alignment.centerRight,
//                 child: _buildButton(
//                   text: 'GET STARTED',
//                   onTap: _navigateToLogin,
//                   isBlack: true,
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }

//   Widget _buildButton({
//     required String text,
//     required VoidCallback onTap,
//     required bool isBlack,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1.2,
//             color: isBlack ? Colors.black : Colors.grey,
//           ),
//           borderRadius: BorderRadius.circular(20),
//           color: isBlack ? Colors.black : Colors.grey.shade200,
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
//             fontWeight: FontWeight.normal,
//             color: isBlack ? Colors.white : Colors.black45,
//             letterSpacing: 1,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Data model for onboarding content
// class OnboardingData {
//   final String imagePath;
//   final String title;
//   final String description;

//   OnboardingData({
//     required this.imagePath,
//     required this.title,
//     required this.description,
//   });
// }
//  Stack(
          //   children: [
          // // First circle
          // Positioned(
          //   // top: -40,
          //   top: MediaQuery.sizeOf(context).height * -0.28,
          //   left: MediaQuery.sizeOf(context).height * -0.048,
          //   child: Container(
          //     height: MediaQuery.sizeOf(context).height * 0.6,
          //     width: MediaQuery.sizeOf(context).height * 0.6,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.black54,
          //     ),
          //   ),
          // ),

          // // Second circle
          // Positioned(
          //   top: MediaQuery.sizeOf(context).height * -0.11,
          //   right: MediaQuery.sizeOf(context).height * -0.38,
          //   // top: 40,
          //   // right: -60,
          //   child: Container(
          //     height: MediaQuery.sizeOf(context).height * 0.6,
          //     width: MediaQuery.sizeOf(context).height * 0.6,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.black54,
          //     ),
          //   ),
          // ),
 //   ],
      // ),
          // Example content to see circles behind