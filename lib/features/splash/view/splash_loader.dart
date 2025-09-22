// import 'package:flutter/material.dart';

// class SplashLoaderChild extends StatefulWidget {
//   const SplashLoaderChild({super.key});

//   @override
//   State<SplashLoaderChild> createState() => _SplashLoaderChildState();
// }

// class _SplashLoaderChildState extends State<SplashLoaderChild> with TickerProviderStateMixin {
//   // Animation Controllers
//   late AnimationController _masterController;
//   late AnimationController _logoZoomController;

//   // Logo Animations
//   late Animation<double> _outerCircleScale;
//   late Animation<double> _outerCircleOpacity;
//   late Animation<double> _middleCircleScale;
//   late Animation<double> _middleCircleOpacity;
//   late Animation<double> _innerCircleScale;
//   late Animation<double> _innerCircleOpacity;
//   late Animation<double> _logoZoomAnimation;

//   // Text Animations
//   late Animation<Offset> _titleSlideAnimation;
//   late Animation<double> _titleOpacityAnimation;
//   late Animation<Offset> _subtitleSlideAnimation;
//   late Animation<double> _subtitleOpacityAnimation;

//   // Dots and Progress Animations
//   late Animation<double> _dot1Animation;
//   late Animation<double> _dot2Animation;
//   late Animation<double> _dot3Animation;
//   late Animation<double> _dot4Animation;
//   late Animation<double> _progressAnimation;

//   // Colors - Black & White Theme
//   final Color primaryColor = Colors.black;
//   final Color lightPrimaryColor = Colors.grey.shade300;
//   final Color darkerPrimaryColor = Colors.grey.shade700;

//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//     _startAnimations();
//   }

//   void _initializeAnimations() {
//     // Master controller for 2 seconds
//     _masterController = AnimationController(
//       duration: const Duration(milliseconds: 4000),
//       vsync: this,
//     );

//     // Logo zoom controller for zoom out effect
//     _logoZoomController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );

//     // Safe logo animations with proper bounds
//     _outerCircleScale = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
//     ));

//     _outerCircleOpacity = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
//     ));

//     _middleCircleScale = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.1, 0.5, curve: Curves.easeOut),
//     ));

//     _middleCircleOpacity = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.1, 0.4, curve: Curves.easeIn),
//     ));

//     _innerCircleScale = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
//     ));

//     _innerCircleOpacity = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
//     ));

//     // Logo zoom animation
//     _logoZoomAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.95,
//     ).animate(CurvedAnimation(
//       parent: _logoZoomController,
//       curve: Curves.easeInOut,
//     ));

//     // Text animations
//     _titleSlideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.4, 0.7, curve: Curves.easeOut),
//     ));

//     _titleOpacityAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
//     ));

//     _subtitleSlideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
//     ));

//     _subtitleOpacityAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.5, 0.7, curve: Curves.easeIn),
//     ));

//     // Dot animations
//     _dot1Animation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.6, 0.75, curve: Curves.easeOut),
//     ));

//     _dot2Animation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.65, 0.8, curve: Curves.easeOut),
//     ));

//     _dot3Animation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.7, 0.85, curve: Curves.easeOut),
//     ));

//     _dot4Animation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.75, 0.9, curve: Curves.easeOut),
//     ));

//     // Progress bar animation
//     _progressAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _masterController,
//       curve: const Interval(0.7, 0.95, curve: Curves.easeInOut),
//     ));
//   }

//   void _startAnimations() async {
//     // Start master animation
//     _masterController.forward();

//     // Start zoom out after zoom in completes
//     await Future.delayed(const Duration(milliseconds: 1200));
//     if (mounted) {
//       _logoZoomController.forward();
//     }

//     // Navigate to next screen after 2 seconds
//     await Future.delayed(const Duration(milliseconds: 800));
//     if (mounted) {
//       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextScreen()));
//       print("Navigate to next screen");
//     }
//   }

//   @override
//   void dispose() {
//     _masterController.dispose();
//     _logoZoomController.dispose();
//     super.dispose();
//   }

//   double _safeOpacity(double value) {
//     return value.clamp(0.0, 1.0);
//   }

//   double _safeScale(double value) {
//     return value.clamp(0.0, 2.0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Animated Logo with Circles
//             AnimatedBuilder(
//               animation: Listenable.merge([_masterController, _logoZoomController]),
//               builder: (context, child) {
//                 double logoScale =
//                     _logoZoomController.isAnimating ? _safeScale(_logoZoomAnimation.value) : 1.0;

//                 return Transform.scale(
//                   scale: logoScale,
//                   child: SizedBox(
//                     width: 220,
//                     height: 220,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // Outer circle (outline)
//                         Transform.scale(
//                           scale: _safeScale(_outerCircleScale.value),
//                           child: Opacity(
//                             opacity: _safeOpacity(_outerCircleOpacity.value),
//                             child: Container(
//                               width: 220,
//                               height: 220,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: Colors.black,
//                                   width: 1.5,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Middle circle
//                         Transform.scale(
//                           scale: _safeScale(_middleCircleScale.value),
//                           child: Opacity(
//                             opacity: _safeOpacity(_middleCircleOpacity.value),
//                             child: Container(
//                               width: 160,
//                               height: 160,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.grey.shade200,
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Inner circle with content
//                         Transform.scale(
//                           scale: _safeScale(_innerCircleScale.value),
//                           child: Opacity(
//                             opacity: _safeOpacity(_innerCircleOpacity.value),
//                             child: Container(
//                               width: 110,
//                               height: 110,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.grey.shade100,
//                                 image: DecorationImage(
//                                   image: AssetImage('assets/logos/appIcon.png'),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),

//             const SizedBox(height: 50),

//             // Animated Title
//             SlideTransition(
//               position: _titleSlideAnimation,
//               child: AnimatedBuilder(
//                 animation: _titleOpacityAnimation,
//                 builder: (context, child) {
//                   return Opacity(
//                     opacity: _safeOpacity(_titleOpacityAnimation.value),
//                     child: Text(
//                       'Link Nest',
//                       style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 12),

//             // Animated Subtitle
//             SlideTransition(
//               position: _subtitleSlideAnimation,
//               child: AnimatedBuilder(
//                 animation: _subtitleOpacityAnimation,
//                 builder: (context, child) {
//                   return Opacity(
//                     opacity: _safeOpacity(_subtitleOpacityAnimation.value),
//                     child: Text(
//                       'Link it, nest it, forget the rest.',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey[600],
//                         letterSpacing: 0.3,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 80),

//             // Animated Dots
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildDot(_dot1Animation),
//                 _buildDot(_dot2Animation),
//                 _buildDot(_dot3Animation),
//                 _buildDot(_dot4Animation),
//               ],
//             ),

//             const SizedBox(height: 40),

//             // Animated Progress Bar
//             AnimatedBuilder(
//               animation: _progressAnimation,
//               builder: (context, child) {
//                 return Container(
//                   width: 220,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(2),
//                     color: Colors.grey[300],
//                   ),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       // Progress fill from center
//                       Container(
//                         width: 220 * _safeOpacity(_progressAnimation.value),
//                         height: 4,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(2),
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.black.withOpacity(0.6),
//                               Colors.black,
//                               Colors.black.withOpacity(0.6),
//                             ],
//                             stops: const [0.0, 0.5, 1.0],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDot(Animation<double> animation) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, child) {
//         double animValue = _safeOpacity(animation.value);
//         return Transform.scale(
//           scale: animValue,
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 4),
//             width: 10,
//             height: 10,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.black.withOpacity(animValue),
//               border: Border.all(
//                 color: Colors.grey.withOpacity(0.5),
//                 width: 1,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class SplashLoaderChild extends StatefulWidget {
  const SplashLoaderChild({super.key});

  @override
  State<SplashLoaderChild> createState() => _SplashLoaderChildState();
}

class _SplashLoaderChildState extends State<SplashLoaderChild> with TickerProviderStateMixin {
  // Animation Controllers
  late AnimationController _masterController;
  late AnimationController _logoZoomController;

  // Logo Animations
  late Animation<double> _outerCircleScale;
  late Animation<double> _outerCircleOpacity;
  late Animation<double> _middleCircleScale;
  late Animation<double> _middleCircleOpacity;
  late Animation<double> _innerCircleScale;
  late Animation<double> _innerCircleOpacity;
  late Animation<double> _logoZoomAnimation;

  // Text Animations
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _titleOpacityAnimation;
  late Animation<Offset> _subtitleSlideAnimation;
  late Animation<double> _subtitleOpacityAnimation;
  late Animation<double> _typingAnimation;

  // Dots and Progress Animations
  late Animation<double> _dot1Animation;
  late Animation<double> _dot2Animation;
  late Animation<double> _dot3Animation;
  late Animation<double> _dot4Animation;
  late Animation<double> _progressAnimation;

  // Colors - Black & White Theme
  final Color primaryColor = Colors.black;
  final Color lightPrimaryColor = Colors.grey.shade300;
  final Color darkerPrimaryColor = Colors.grey.shade700;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Master controller for 2 seconds
    _masterController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    // Logo zoom controller for zoom out effect
    _logoZoomController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Safe logo animations with proper bounds
    _outerCircleScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    ));

    _outerCircleOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
    ));

    _middleCircleScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.1, 0.5, curve: Curves.easeOut),
    ));

    _middleCircleOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.1, 0.4, curve: Curves.easeIn),
    ));

    _innerCircleScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    ));

    _innerCircleOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
    ));

    // Logo zoom animation
    _logoZoomAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _logoZoomController,
      curve: Curves.easeInOut,
    ));

    // Text animations
    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.4, 0.7, curve: Curves.easeOut),
    ));

    _titleOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
    ));

    _subtitleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
    ));

    _subtitleOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.5, 0.7, curve: Curves.easeIn),
    ));

    // Typing animation for subtitle
    _typingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.55, 0.99, curve: Curves.easeInOut),
    ));

    // Dot animations
    _dot1Animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.6, 0.75, curve: Curves.easeOut),
    ));

    _dot2Animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.65, 0.8, curve: Curves.easeOut),
    ));

    _dot3Animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.7, 0.85, curve: Curves.easeOut),
    ));

    _dot4Animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.75, 0.9, curve: Curves.easeOut),
    ));

    // Progress bar animation
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.7, 0.95, curve: Curves.easeInOut),
    ));
  }

  void _startAnimations() async {
    // Start master animation
    _masterController.forward();

    // Start zoom out after zoom in completes
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      _logoZoomController.forward();
    }

    // Navigate to next screen after 2 seconds
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextScreen()));
      print("Navigate to next screen");
    }
  }

  @override
  void dispose() {
    _masterController.dispose();
    _logoZoomController.dispose();
    super.dispose();
  }

  double _safeOpacity(double value) {
    return value.clamp(0.0, 1.0);
  }

  double _safeScale(double value) {
    return value.clamp(0.0, 2.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacer(),
            // Animated Logo with Circles
            AnimatedBuilder(
              animation: Listenable.merge([_masterController, _logoZoomController]),
              builder: (context, child) {
                double logoScale =
                    _logoZoomController.isAnimating ? _safeScale(_logoZoomAnimation.value) : 1.0;

                return Transform.scale(
                  scale: logoScale,
                  child: SizedBox(
                    width: 220,
                    height: 220,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer circle (outline)
                        Transform.scale(
                          scale: _safeScale(_outerCircleScale.value),
                          child: Opacity(
                            opacity: _safeOpacity(_outerCircleOpacity.value),
                            child: Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Middle circle
                        Transform.scale(
                          scale: _safeScale(_middleCircleScale.value),
                          child: Opacity(
                            opacity: _safeOpacity(_middleCircleOpacity.value),
                            child: Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                        ),
                        // Inner circle with content
                        Transform.scale(
                          scale: _safeScale(_innerCircleScale.value),
                          child: Opacity(
                            opacity: _safeOpacity(_innerCircleOpacity.value),
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade100,
                                image: DecorationImage(
                                  image: AssetImage('assets/logos/appIcon.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 50),
            // Spacer(),

            // Animated Title
            SlideTransition(
              position: _titleSlideAnimation,
              child: AnimatedBuilder(
                animation: _titleOpacityAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _safeOpacity(_titleOpacityAnimation.value),
                    child: Text(
                      'Link Nest',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 0.5,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Animated Subtitle with Typing Effect
            SlideTransition(
              position: _subtitleSlideAnimation,
              child: AnimatedBuilder(
                animation: Listenable.merge([_subtitleOpacityAnimation, _typingAnimation]),
                builder: (context, child) {
                  String fullText = 'Link it, nest it, forget the rest.';
                  int charactersToShow = (_typingAnimation.value * fullText.length).floor();
                  String displayText = fullText.substring(0, charactersToShow);

                  return Opacity(
                    opacity: _safeOpacity(_subtitleOpacityAnimation.value),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          displayText,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            letterSpacing: 0.3,
                          ),
                        ),
                        // Blinking cursor effect
                        if (charactersToShow < fullText.length)
                          AnimatedBuilder(
                            animation: _masterController,
                            builder: (context, child) {
                              return Opacity(
                                opacity:
                                    ((_masterController.value * 8) % 2).floor() == 0 ? 1.0 : 0.0,
                                child: Text(
                                  '|',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 60),
            // Spacer(),

            // Animated Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(_dot1Animation),
                _buildDot(_dot2Animation),
                _buildDot(_dot3Animation),
                _buildDot(_dot4Animation),
              ],
            ),

            const SizedBox(height: 40),

            // Animated Progress Bar
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return Container(
                  width: 220,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey[300],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Progress fill from center
                      Container(
                        width: 220 * _safeOpacity(_progressAnimation.value),
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.black,
                              Colors.black.withOpacity(0.6),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        double animValue = _safeOpacity(animation.value);
        return Transform.scale(
          scale: animValue,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(animValue),
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}
