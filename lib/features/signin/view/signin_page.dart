import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_nest/const/resource.dart';
import 'package:link_nest/core/router/router.gr.dart';
import 'package:link_nest/data/providers/auth/auth_repo_provider.dart';
import 'package:link_nest/shared/global_loader.dart';

@RoutePage(deferredLoading: true)
// class SigninPage extends StatelessWidget {
//   const SigninPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   R.ASSETS_ANIMATIONS_SIGN_IN_GIF,
//                   height: MediaQuery.sizeOf(context).height * 0.28,
//                 ).centered(),
//                 30.heightBox,
//                 Text(
//                   'Welcome Back!',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
//                     color: Colors.black,
//                     letterSpacing: 1,
//                   ),
//                 ),
//                 4.heightBox,
//                 Text(
//                   textAlign: TextAlign.left,
//                   'Please enter valid credentials to getinto the app.if you are not registered yet,please click on the signup below.',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
//                     color: Colors.black45,
//                     letterSpacing: 1,
//                   ),
//                 ),
//                 20.heightBox,
//                 // User name field
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: 'User name',
//                     hintStyle: TextStyle(color: Colors.grey[400]),
//                     prefixIcon: Icon(Icons.person_outline, color: Colors.grey[400]),
//                     filled: true,
//                     fillColor: Colors.grey[50],
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                   ),
//                 ),
//                 16.heightBox,

//                 // Password field
//                 TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     hintText: 'Password',
//                     hintStyle: TextStyle(color: Colors.grey[400]),
//                     prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
//                     suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.grey[400]),
//                     filled: true,
//                     fillColor: Colors.grey[50],
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                   ),
//                 ),
//                 8.heightBox,

//                 // Forget password
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       // Handle forget password
//                     },
//                     child: Text(
//                       'Forget password?',
//                       style: TextStyle(
//                         color: Colors.black45,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 16.heightBox,

//                 // Login button
//                 GlobalButton(
//                         backgroundColor: Colors.black,
//                         child: Text(
//                           'Sign in',
//                           style: TextStyle(
//                               fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 1,
//                               color: Colors.white),
//                         ),
//                         onPressed: () {})
//                     .w(double.maxFinite)
//                     .h(50),
//                 20.heightBox,

//                 // Or Continue with
//                 Row(
//                   children: [
//                     Expanded(child: Divider(color: Colors.grey[300])),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Text(
//                         'Or Continue with',
//                         style: TextStyle(
//                           color: Colors.grey[500],
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     Expanded(child: Divider(color: Colors.grey[300])),
//                   ],
//                 ),
//                 20.heightBox,

//                 // Social login buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[50],
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.grey[200]!),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.g_mobiledata, color: Colors.red, size: 24),
//                             8.widthBox,
//                             Text(
//                               'Google',
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     12.widthBox,
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[50],
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.grey[200]!),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.facebook, color: Colors.blue, size: 24),
//                             8.widthBox,
//                             Text(
//                               'Apple',
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 20.heightBox,

//                 // Sign up text
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Haven't any account? ",
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 14,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         // Handle sign up navigation
//                       },
//                       child: Text(
//                         'Sign up',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

// class _SigninPageState extends ConsumerState<SigninPage> with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late List<Animation<double>> _fadeAnimations;
//   late List<Animation<Offset>> _slideAnimations;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     // Create staggered animations for each element
//     _fadeAnimations = List.generate(8, (index) {
//       double start = index * 0.08; // Reduced interval spacing
//       double end = start + 0.4; // Reduced duration per element

//       return Tween<double>(
//         begin: 0.0,
//         end: 1.0,
//       ).animate(CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(
//           start.clamp(0.0, 1.0),
//           end.clamp(0.0, 1.0),
//           curve: Curves.easeOutCubic,
//         ),
//       ));
//     });

//     _slideAnimations = List.generate(8, (index) {
//       double start = index * 0.08;
//       double end = start + 0.4;

//       return Tween<Offset>(
//         begin: const Offset(0, 0.5),
//         end: Offset.zero,
//       ).animate(CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(
//           start.clamp(0.0, 1.0),
//           end.clamp(0.0, 1.0),
//           curve: Curves.easeOutCubic,
//         ),
//       ));
//     });

//     // Start animation after a brief delay
//     Future.delayed(const Duration(milliseconds: 300), () {
//       _animationController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   // ============= FUNCTIONS PART ==========//
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   bool _isLoading = false;

//   void _login() async {
//     setState(() => _isLoading = true);
//     try {
//       final repo = ref.read(authRepositoryProvider);
//       final user = await repo.login(_emailCtrl.text, _passwordCtrl.text);

//       if (user != null && mounted) {
//         // Wait a bit for auth state to update
//         await Future.delayed(const Duration(milliseconds: 100));
//         context.router.replaceAll([NavBarRoute()]);
//       }
//       setState(() {
//         _isLoading = false;
//       });
//     } on FirebaseAuthException catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.message ?? "Login failed")),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   Widget _buildAnimatedWidget(Widget child, int index) {
//     return SlideTransition(
//       position: _slideAnimations[index],
//       child: FadeTransition(
//         opacity: _fadeAnimations[index],
//         child: child,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           _isLoading
//               ? Center(
//                   child: LoadingWidget(
//                       bgColor: Colors.black26,
//                       title: 'Hold on a moment',
//                       subTitle: 'Signing you in...'))
//               : SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Image without animation (as requested)
//                           Image.asset(
//                             R.ASSETS_ANIMATIONS_SIGN_IN_GIF,
//                             height: MediaQuery.sizeOf(context).height * 0.28,
//                           ).centered(),
//                           30.heightBox,

//                           // Welcome text - animated
//                           _buildAnimatedWidget(
//                             Text(
//                               'Welcome Back!',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
//                                 color: Colors.black,
//                                 letterSpacing: 1,
//                               ),
//                             ),
//                             0,
//                           ),
//                           4.heightBox,

//                           // Description text - animated
//                           _buildAnimatedWidget(
//                             Text(
//                               textAlign: TextAlign.left,
//                               'Please enter valid credentials to get into the app.if you are not registered yet,please click on the signup below.',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
//                                 color: Colors.black45,
//                                 letterSpacing: 1,
//                               ),
//                             ),
//                             1,
//                           ),
//                           20.heightBox,

//                           // User name field - animated
//                           _buildAnimatedWidget(
//                             TextField(
//                               style: TextStyle(color: Colors.black54),
//                               controller: _emailCtrl,
//                               decoration: InputDecoration(
//                                 hintText: 'Your user name/email',
//                                 hintStyle: TextStyle(color: Colors.grey[400]),
//                                 prefixIcon: Icon(Icons.person_outline, color: Colors.grey[400]),
//                                 filled: true,
//                                 fillColor: Colors.grey[50],
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                               ),
//                             ),
//                             2,
//                           ),
//                           16.heightBox,

//                           // Password field - animated
//                           _buildAnimatedWidget(
//                             TextField(
//                               style: TextStyle(color: Colors.black54),
//                               controller: _passwordCtrl,
//                               obscureText: true,
//                               decoration: InputDecoration(
//                                 hintText: 'Password',
//                                 hintStyle: TextStyle(color: Colors.grey[400]),
//                                 prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
//                                 suffixIcon:
//                                     Icon(Icons.visibility_off_outlined, color: Colors.grey[400]),
//                                 filled: true,
//                                 fillColor: Colors.grey[50],
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                               ),
//                             ),
//                             3,
//                           ),

//                           // Forget password - animated
//                           _buildAnimatedWidget(
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: TextButton(
//                                 onPressed: () {
//                                   // Handle forget password
//                                 },
//                                 child: Text(
//                                   'Forget password?',
//                                   style: TextStyle(
//                                     color: Colors.black45,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             4,
//                           ),
//                           16.heightBox,

//                           // Login button - animated
//                           _buildAnimatedWidget(
//                             GlobalButton(
//                                 backgroundColor: Colors.black,
//                                 child: Text(
//                                   'Sign in',
//                                   style: TextStyle(
//                                       fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
//                                       fontWeight: FontWeight.w600,
//                                       letterSpacing: 1,
//                                       color: Colors.white),
//                                 ),
//                                 onPressed: () {
//                                   //+++++++++++++  PERFORM LOGIN
//                                   _login();
//                                 }).w(double.maxFinite).h(50),
//                             5,
//                           ),
//                           20.heightBox,

//                           // Or Continue with - animated
//                           _buildAnimatedWidget(
//                             Row(
//                               children: [
//                                 Expanded(child: Divider(color: Colors.grey[300])),
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 16),
//                                   child: Text(
//                                     'Or Continue with',
//                                     style: TextStyle(
//                                       color: Colors.grey[500],
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(child: Divider(color: Colors.grey[300])),
//                               ],
//                             ),
//                             6,
//                           ),
//                           20.heightBox,

//                           // Social login buttons - animated
//                           _buildAnimatedWidget(
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(vertical: 12),
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[50],
//                                       borderRadius: BorderRadius.circular(8),
//                                       border: Border.all(color: Colors.grey[200]!),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         SvgPicture.asset(
//                                           R.ASSETS_ICONS_GOOGLE_SVG,
//                                           height: MediaQuery.sizeOf(context).height * 0.024,
//                                         ),
//                                         12.widthBox,
//                                         Text(
//                                           'Google',
//                                           style: TextStyle(
//                                             color: Colors.black87,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 12.widthBox,
//                                 Expanded(
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(vertical: 12),
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[50],
//                                       borderRadius: BorderRadius.circular(8),
//                                       border: Border.all(color: Colors.grey[200]!),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         SvgPicture.asset(
//                                           R.ASSETS_ICONS_APPLE_SVG,
//                                           height: MediaQuery.sizeOf(context).height * 0.024,
//                                         ),
//                                         12.widthBox,
//                                         Text(
//                                           'Apple',
//                                           style: TextStyle(
//                                             color: Colors.black87,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             7,
//                           ),
//                           20.heightBox,

//                           // Sign up text - animated
//                           _buildAnimatedWidget(
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Haven't any account? ",
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     // Handle sign up navigation
//                                     context.navigateTo(SignupRoute());
//                                   },
//                                   child: Text(
//                                     'Sign up',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             7,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }

// class _SigninPageState extends ConsumerState<SigninPage> with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late List<Animation<double>> _fadeAnimations;
//   late List<Animation<Offset>> _slideAnimations;

//   // Modern Dark Theme Colors
//   final Color darkBg1 = const Color(0xFF1a1a2e);
//   final Color darkBg2 = const Color(0xFF16213e);
//   final Color darkBg3 = const Color(0xFF0f3460);
//   final Color cardBg = const Color(0xFF1e293b);
//   final Color inputBg = const Color(0xFF0f172a);
//   final Color primaryGradientStart = const Color(0xFF6366f1);
//   final Color primaryGradientEnd = const Color(0xFF8b5cf6);
//   final Color textPrimary = Colors.white;
//   final Color textSecondary = const Color(0xFF94a3b8);
//   final Color textHint = const Color(0xFF64748b);

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     // Create staggered animations for each element
//     _fadeAnimations = List.generate(8, (index) {
//       double start = index * 0.08; // Reduced interval spacing
//       double end = start + 0.4; // Reduced duration per element

//       return Tween<double>(
//         begin: 0.0,
//         end: 1.0,
//       ).animate(CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(
//           start.clamp(0.0, 1.0),
//           end.clamp(0.0, 1.0),
//           curve: Curves.easeOutCubic,
//         ),
//       ));
//     });

//     _slideAnimations = List.generate(8, (index) {
//       double start = index * 0.08;
//       double end = start + 0.4;

//       return Tween<Offset>(
//         begin: const Offset(0, 0.5),
//         end: Offset.zero,
//       ).animate(CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(
//           start.clamp(0.0, 1.0),
//           end.clamp(0.0, 1.0),
//           curve: Curves.easeOutCubic,
//         ),
//       ));
//     });

//     // Start animation after a brief delay
//     Future.delayed(const Duration(milliseconds: 300), () {
//       _animationController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   // ============= FUNCTIONS PART ==========//
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   bool _isLoading = false;

//   void _login() async {
//     setState(() => _isLoading = true);
//     try {
//       final repo = ref.read(authRepositoryProvider);
//       final user = await repo.login(_emailCtrl.text, _passwordCtrl.text);

//       if (user != null && mounted) {
//         // Wait a bit for auth state to update
//         await Future.delayed(const Duration(milliseconds: 100));
//         context.router.replaceAll([NavBarRoute()]);
//       }
//       setState(() {
//         _isLoading = false;
//       });
//     } on FirebaseAuthException catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.message ?? "Login failed")),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   Widget _buildAnimatedWidget(Widget child, int index) {
//     return SlideTransition(
//       position: _slideAnimations[index],
//       child: FadeTransition(
//         opacity: _fadeAnimations[index],
//         child: child,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               darkBg1,
//               darkBg2,
//               darkBg3,
//             ],
//           ),
//         ),
//         child: Stack(
//           children: [
//             _isLoading
//                 ? Center(
//                     child: LoadingWidget(
//                         bgColor: Colors.black26,
//                         title: 'Hold on a moment',
//                         subTitle: 'Signing you in...'))
//                 : SafeArea(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Image without animation (as requested)
//                             Image.asset(
//                               R.ASSETS_ANIMATIONS_SIGN_IN_GIF,
//                               height: MediaQuery.sizeOf(context).height * 0.28,
//                             ).centered(),
//                             30.heightBox,

//                             // Welcome text - animated
//                             _buildAnimatedWidget(
//                               Text(
//                                 'Welcome Back!',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
//                                   color: textPrimary,
//                                   letterSpacing: 1,
//                                 ),
//                               ),
//                               0,
//                             ),
//                             4.heightBox,

//                             // Description text - animated
//                             _buildAnimatedWidget(
//                               Text(
//                                 textAlign: TextAlign.left,
//                                 'Please enter valid credentials to get into the app.if you are not registered yet,please click on the signup below.',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
//                                   color: textSecondary,
//                                   letterSpacing: 1,
//                                 ),
//                               ),
//                               1,
//                             ),
//                             20.heightBox,

//                             // User name field - animated
//                             _buildAnimatedWidget(
//                               TextField(
//                                 style: TextStyle(color: textPrimary),
//                                 controller: _emailCtrl,
//                                 decoration: InputDecoration(
//                                   hintText: 'Your user name/email',
//                                   hintStyle: TextStyle(color: textHint),
//                                   prefixIcon: Icon(Icons.person_outline, color: textHint),
//                                   filled: true,
//                                   fillColor: inputBg,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(color: cardBg.withOpacity(0.5)),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(color: cardBg.withOpacity(0.5)),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(color: primaryGradientStart, width: 2),
//                                   ),
//                                   contentPadding:
//                                       EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                                 ),
//                               ),
//                               2,
//                             ),
//                             16.heightBox,

//                             // Password field - animated
//                             _buildAnimatedWidget(
//                               TextField(
//                                 style: TextStyle(color: textPrimary),
//                                 controller: _passwordCtrl,
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                   hintText: 'Password',
//                                   hintStyle: TextStyle(color: textHint),
//                                   prefixIcon: Icon(Icons.lock_outline, color: textHint),
//                                   suffixIcon: Icon(Icons.visibility_off_outlined, color: textHint),
//                                   filled: true,
//                                   fillColor: inputBg,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(color: cardBg.withOpacity(0.5)),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(color: cardBg.withOpacity(0.5)),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(color: primaryGradientStart, width: 2),
//                                   ),
//                                   contentPadding:
//                                       EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                                 ),
//                               ),
//                               3,
//                             ),

//                             // Forget password - animated
//                             _buildAnimatedWidget(
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     // Handle forget password
//                                   },
//                                   child: Text(
//                                     'Forget password?',
//                                     style: TextStyle(
//                                       color: primaryGradientEnd,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               4,
//                             ),
//                             16.heightBox,

//                             // Login button - animated with gradient
//                             _buildAnimatedWidget(
//                               Container(
//                                 width: double.maxFinite,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       primaryGradientStart,
//                                       primaryGradientEnd,
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(12),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: primaryGradientStart.withOpacity(0.4),
//                                       blurRadius: 15,
//                                       spreadRadius: 1,
//                                       offset: Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Material(
//                                   color: Colors.transparent,
//                                   child: InkWell(
//                                     onTap: () {
//                                       _login();
//                                     },
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: Center(
//                                       child: Text(
//                                         'Sign in',
//                                         style: TextStyle(
//                                           fontSize:
//                                               Theme.of(context).textTheme.titleMedium!.fontSize,
//                                           fontWeight: FontWeight.w600,
//                                           letterSpacing: 1,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               5,
//                             ),
//                             20.heightBox,

//                             // Or Continue with - animated
//                             _buildAnimatedWidget(
//                               Row(
//                                 children: [
//                                   Expanded(child: Divider(color: Colors.white.withOpacity(0.2))),
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 16),
//                                     child: Text(
//                                       'Or Continue with',
//                                       style: TextStyle(
//                                         color: textSecondary,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(child: Divider(color: Colors.white.withOpacity(0.2))),
//                                 ],
//                               ),
//                               6,
//                             ),
//                             20.heightBox,

//                             // Social login buttons - animated
//                             _buildAnimatedWidget(
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(vertical: 12),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(0.08),
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(color: Colors.white.withOpacity(0.1)),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           SvgPicture.asset(
//                                             R.ASSETS_ICONS_GOOGLE_SVG,
//                                             height: MediaQuery.sizeOf(context).height * 0.024,
//                                           ),
//                                           12.widthBox,
//                                           Text(
//                                             'Google',
//                                             style: TextStyle(
//                                               color: textPrimary,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   12.widthBox,
//                                   Expanded(
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(vertical: 12),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(0.08),
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(color: Colors.white.withOpacity(0.1)),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           SvgPicture.asset(
//                                             R.ASSETS_ICONS_APPLE_SVG,
//                                             color: Colors.white,
//                                             height: MediaQuery.sizeOf(context).height * 0.024,
//                                           ),
//                                           12.widthBox,
//                                           Text(
//                                             'Apple',
//                                             style: TextStyle(
//                                               color: textPrimary,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               7,
//                             ),
//                             20.heightBox,

//                             // Sign up text - animated
//                             _buildAnimatedWidget(
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Haven't any account? ",
//                                     style: TextStyle(
//                                       color: textSecondary,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       // Handle sign up navigation
//                                       context.navigateTo(SignupRoute());
//                                     },
//                                     child: Text(
//                                       'Sign up',
//                                       style: TextStyle(
//                                         color: primaryGradientEnd,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               7,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SigninPageState extends ConsumerState<SigninPage> with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late List<Animation<double>> _fadeAnimations;
//   late List<Animation<Offset>> _slideAnimations;

//   // Modern Dark Theme Colors
//   final Color darkBg1 = const Color(0xFF1a1a2e);
//   final Color darkBg2 = const Color(0xFF16213e);
//   final Color darkBg3 = const Color(0xFF0f3460);
//   final Color cardBg = const Color(0xFF1e293b);
//   final Color inputBg = const Color(0xFF0f172a);
//   final Color primaryGradientStart = const Color(0xFF6366f1);
//   final Color primaryGradientEnd = const Color(0xFF8b5cf6);
//   final Color textPrimary = Colors.white;
//   final Color textSecondary = const Color(0xFF94a3b8);
//   final Color textHint = const Color(0xFF64748b);

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     // Create staggered animations for each element
//     _fadeAnimations = List.generate(8, (index) {
//       double start = index * 0.08;
//       double end = start + 0.4;

//       return Tween<double>(
//         begin: 0.0,
//         end: 1.0,
//       ).animate(CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(
//           start.clamp(0.0, 1.0),
//           end.clamp(0.0, 1.0),
//           curve: Curves.easeOutCubic,
//         ),
//       ));
//     });

//     _slideAnimations = List.generate(8, (index) {
//       double start = index * 0.08;
//       double end = start + 0.4;

//       return Tween<Offset>(
//         begin: const Offset(0, 0.5),
//         end: Offset.zero,
//       ).animate(CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(
//           start.clamp(0.0, 1.0),
//           end.clamp(0.0, 1.0),
//           curve: Curves.easeOutCubic,
//         ),
//       ));
//     });

//     // Start animation after a brief delay
//     Future.delayed(const Duration(milliseconds: 300), () {
//       _animationController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   // ============= FUNCTIONS PART ==========//
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   bool _isLoading = false;

//   void _login() async {
//     setState(() => _isLoading = true);
//     try {
//       final repo = ref.read(authRepositoryProvider);
//       final user = await repo.login(_emailCtrl.text, _passwordCtrl.text);

//       if (user != null && mounted) {
//         // Wait a bit for auth state to update
//         await Future.delayed(const Duration(milliseconds: 100));
//         context.router.replaceAll([NavBarRoute()]);
//       }
//       setState(() {
//         _isLoading = false;
//       });
//     } on FirebaseAuthException catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.message ?? "Login failed")),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   Widget _buildAnimatedWidget(Widget child, int index) {
//     return SlideTransition(
//       position: _slideAnimations[index],
//       child: FadeTransition(
//         opacity: _fadeAnimations[index],
//         child: child,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       body: Container(
//         height: double.maxFinite,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               darkBg1,
//               darkBg2,
//               darkBg3,
//             ],
//           ),
//         ),
//         child: Stack(
//           children: [
//             _isLoading
//                 ? Center(
//                     child: LoadingWidget(
//                         bgColor: Colors.black26,
//                         title: 'Hold on a moment',
//                         subTitle: 'Signing you in...'))
//                 : SafeArea(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Enhanced GIF Container with Modern Frame
//                             // Center(
//                             //   child: Container(
//                             //     margin: EdgeInsets.symmetric(vertical: 10),
//                             //     padding: EdgeInsets.all(8),
//                             //     decoration: BoxDecoration(
//                             //       gradient: LinearGradient(
//                             //         begin: Alignment.topLeft,
//                             //         end: Alignment.bottomRight,
//                             //         colors: [
//                             //           primaryGradientStart.withOpacity(0.3),
//                             //           primaryGradientEnd.withOpacity(0.3),
//                             //         ],
//                             //       ),
//                             //       borderRadius: BorderRadius.circular(24),
//                             //       boxShadow: [
//                             //         BoxShadow(
//                             //           color: primaryGradientStart.withOpacity(0.2),
//                             //           blurRadius: 20,
//                             //           spreadRadius: 2,
//                             //         ),
//                             //       ],
//                             //     ),
//                             //     child: Container(
//                             //       decoration: BoxDecoration(
//                             //         color: Colors.white,
//                             //         borderRadius: BorderRadius.circular(20),
//                             //         boxShadow: [
//                             //           BoxShadow(
//                             //             color: Colors.black.withOpacity(0.1),
//                             //             blurRadius: 10,
//                             //             spreadRadius: 1,
//                             //           ),
//                             //         ],
//                             //       ),
//                             //       child: ClipRRect(
//                             //         borderRadius: BorderRadius.circular(20),
//                             //         child: Image.asset(
//                             //           R.ASSETS_ANIMATIONS_SIGN_IN_GIF,
//                             //           height: MediaQuery.sizeOf(context).height * 0.26,
//                             //           fit: BoxFit.cover,
//                             //         ),
//                             //       ),
//                             //     ),
//                             //   ),
//                             // ),
//                             GlassLogoWidget(),
//                             20.heightBox,

//                             // Welcome text - animated
//                             _buildAnimatedWidget(
//                               Text(
//                                 'Welcome Back!',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
//                                   color: textPrimary,
//                                   letterSpacing: 1,
//                                   shadows: [
//                                     Shadow(
//                                       color: primaryGradientStart.withOpacity(0.3),
//                                       blurRadius: 10,
//                                       offset: Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               0,
//                             ),
//                             4.heightBox,

//                             // Description text - animated
//                             _buildAnimatedWidget(
//                               Text(
//                                 textAlign: TextAlign.left,
//                                 'Please enter valid credentials to get into the app.if you are not registered yet,please click on the signup below.',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
//                                   color: textSecondary,
//                                   letterSpacing: 0.5,
//                                   height: 1.4,
//                                 ),
//                               ),
//                               1,
//                             ),
//                             24.heightBox,

//                             // User name field - animated
//                             _buildAnimatedWidget(
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.2),
//                                       blurRadius: 10,
//                                       offset: Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: TextField(
//                                   style: TextStyle(color: textPrimary, fontSize: 15),
//                                   controller: _emailCtrl,
//                                   decoration: InputDecoration(
//                                     hintText: 'Your user name/email',
//                                     hintStyle: TextStyle(color: textHint, fontSize: 14),
//                                     prefixIcon: Container(
//                                       margin: EdgeInsets.all(12),
//                                       padding: EdgeInsets.all(8),
//                                       decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             primaryGradientStart.withOpacity(0.2),
//                                             primaryGradientEnd.withOpacity(0.2),
//                                           ],
//                                         ),
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: Icon(Icons.person_outline,
//                                           color: primaryGradientStart, size: 20),
//                                     ),
//                                     filled: true,
//                                     fillColor: inputBg,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide:
//                                           BorderSide(color: cardBg.withOpacity(0.5), width: 1),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(color: primaryGradientStart, width: 2),
//                                     ),
//                                     contentPadding:
//                                         EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//                                   ),
//                                 ),
//                               ),
//                               2,
//                             ),
//                             16.heightBox,

//                             // Password field - animated
//                             _buildAnimatedWidget(
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.2),
//                                       blurRadius: 10,
//                                       offset: Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: TextField(
//                                   style: TextStyle(color: textPrimary, fontSize: 15),
//                                   controller: _passwordCtrl,
//                                   obscureText: true,
//                                   decoration: InputDecoration(
//                                     hintText: 'Password',
//                                     hintStyle: TextStyle(color: textHint, fontSize: 14),
//                                     prefixIcon: Container(
//                                       margin: EdgeInsets.all(12),
//                                       padding: EdgeInsets.all(8),
//                                       decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             primaryGradientStart.withOpacity(0.2),
//                                             primaryGradientEnd.withOpacity(0.2),
//                                           ],
//                                         ),
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: Icon(Icons.lock_outline,
//                                           color: primaryGradientStart, size: 20),
//                                     ),
//                                     suffixIcon: Icon(Icons.visibility_off_outlined,
//                                         color: textHint, size: 20),
//                                     filled: true,
//                                     fillColor: inputBg,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide:
//                                           BorderSide(color: cardBg.withOpacity(0.5), width: 1),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide(color: primaryGradientStart, width: 2),
//                                     ),
//                                     contentPadding:
//                                         EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//                                   ),
//                                 ),
//                               ),
//                               3,
//                             ),

//                             // Forget password - animated
//                             _buildAnimatedWidget(
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     // Handle forget password
//                                   },
//                                   child: Text(
//                                     'Forget password?',
//                                     style: TextStyle(
//                                       color: primaryGradientStart,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               4,
//                             ),
//                             8.heightBox,

//                             // Login button - animated with gradient
//                             _buildAnimatedWidget(
//                               Container(
//                                 width: double.maxFinite,
//                                 height: 54,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       primaryGradientStart,
//                                       primaryGradientEnd,
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(14),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: primaryGradientStart.withOpacity(0.5),
//                                       blurRadius: 20,
//                                       spreadRadius: 2,
//                                       offset: Offset(0, 6),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Material(
//                                   color: Colors.transparent,
//                                   child: InkWell(
//                                     onTap: () {
//                                       _login();
//                                     },
//                                     borderRadius: BorderRadius.circular(14),
//                                     child: Center(
//                                       child: Text(
//                                         'Sign in',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           letterSpacing: 1,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               5,
//                             ),
//                             24.heightBox,

//                             // Or Continue with - animated
//                             _buildAnimatedWidget(
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       height: 1,
//                                       decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Colors.transparent,
//                                             cardBg,
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 16),
//                                     child: Text(
//                                       'Or Continue with',
//                                       style: TextStyle(
//                                         color: textSecondary,
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       height: 1,
//                                       decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             cardBg,
//                                             Colors.transparent,
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               6,
//                             ),
//                             20.heightBox,

//                             // Social login buttons - animated
//                             _buildAnimatedWidget(
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(vertical: 14),
//                                       decoration: BoxDecoration(
//                                         color: inputBg,
//                                         borderRadius: BorderRadius.circular(12),
//                                         border: Border.all(color: cardBg, width: 1.5),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.black.withOpacity(0.1),
//                                             blurRadius: 8,
//                                             offset: Offset(0, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           SvgPicture.asset(
//                                             R.ASSETS_ICONS_GOOGLE_SVG,
//                                             height: 22,
//                                           ),
//                                           12.widthBox,
//                                           Text(
//                                             'Google',
//                                             style: TextStyle(
//                                               color: textPrimary,
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   12.widthBox,
//                                   Expanded(
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(vertical: 14),
//                                       decoration: BoxDecoration(
//                                         color: inputBg,
//                                         borderRadius: BorderRadius.circular(12),
//                                         border: Border.all(color: cardBg, width: 1.5),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.black.withOpacity(0.1),
//                                             blurRadius: 8,
//                                             offset: Offset(0, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           SvgPicture.asset(
//                                             R.ASSETS_ICONS_APPLE_SVG,
//                                             height: 22,
//                                           ),
//                                           12.widthBox,
//                                           Text(
//                                             'Apple',
//                                             style: TextStyle(
//                                               color: textPrimary,
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               7,
//                             ),
//                             24.heightBox,

//                             // Sign up text - animated
//                             _buildAnimatedWidget(
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Haven't any account? ",
//                                     style: TextStyle(
//                                       color: textSecondary,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       context.navigateTo(SignupRoute());
//                                     },
//                                     child: ShaderMask(
//                                       shaderCallback: (bounds) => LinearGradient(
//                                         colors: [
//                                           primaryGradientStart,
//                                           primaryGradientEnd,
//                                         ],
//                                       ).createShader(bounds),
//                                       child: Text(
//                                         'Sign up',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               7,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class GlassLogoWidget extends StatelessWidget {
  const GlassLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width * 0.46;

    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.75, end: 1.0),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.28),
                Colors.white.withOpacity(0.07),
              ],
            ),
            // border: Border.all(
            //   width: 1,
            //   color: Colors.blue.withOpacity(0.55),
            // ),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.2),
                blurRadius: 30,
                spreadRadius: 6,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Image.asset(
            'assets/logos/linkNest.png', // ✅ <-- Your logo
            fit: BoxFit.contain,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// class _SigninPageState extends ConsumerState<SigninPage> with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late AnimationController _shimmerController;
//   late List<Animation<double>> _fadeAnimations;
//   late List<Animation<Offset>> _slideAnimations;

//   // Ultra Modern Dark Theme Colors
//   final Color darkBg1 = const Color(0xFF0f0f1e);
//   final Color darkBg2 = const Color(0xFF1a1a2e);
//   final Color darkBg3 = const Color(0xFF16213e);
//   final Color cardBg = const Color(0xFF1e293b);
//   final Color inputBg = const Color(0xFF0f172a);
//   final Color primaryGradientStart = const Color(0xFF6366f1);
//   final Color primaryGradientEnd = const Color(0xFF8b5cf6);
//   final Color accentPurple = const Color(0xFF7c3aed);
//   final Color textPrimary = Colors.white;
//   final Color textSecondary = const Color(0xFF94a3b8);
//   final Color textHint = const Color(0xFF64748b);

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     _shimmerController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     )..repeat();

//     // Create staggered animations for each element
//     _fadeAnimations = List.generate(9, (index) {
//       double start = index * 0.08;
//       double end = start + 0.4;

//       return Tween<double>(
//         begin: 0.0,
//         end: 1.0,
//       ).animate(CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(
//           start.clamp(0.0, 1.0),
//           end.clamp(0.0, 1.0),
//           curve: Curves.easeOutCubic,
//         ),
//       ));
//     });

//     _slideAnimations = List.generate(9, (index) {
//       double start = index * 0.08;
//       double end = start + 0.4;

//       return Tween<Offset>(
//         begin: const Offset(0, 0.5),
//         end: Offset.zero,
//       ).animate(CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(
//           start.clamp(0.0, 1.0),
//           end.clamp(0.0, 1.0),
//           curve: Curves.easeOutCubic,
//         ),
//       ));
//     });

//     // Start animation after a brief delay
//     Future.delayed(const Duration(milliseconds: 300), () {
//       _animationController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _shimmerController.dispose();
//     super.dispose();
//   }

//   // ============= FUNCTIONS PART ==========//
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   bool _isLoading = false;

//   void _login() async {
//     setState(() => _isLoading = true);
//     try {
//       final repo = ref.read(authRepositoryProvider);
//       final user = await repo.login(_emailCtrl.text, _passwordCtrl.text);

//       if (user != null && mounted) {
//         await Future.delayed(const Duration(milliseconds: 100));
//         context.router.replaceAll([NavBarRoute()]);
//       }
//       setState(() {
//         _isLoading = false;
//       });
//     } on FirebaseAuthException catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.message ?? "Login failed")),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   Widget _buildAnimatedWidget(Widget child, int index) {
//     return SlideTransition(
//       position: _slideAnimations[index],
//       child: FadeTransition(
//         opacity: _fadeAnimations[index],
//         child: child,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               darkBg1,
//               darkBg2,
//               darkBg3,
//             ],
//           ),
//         ),
//         child: Stack(
//           children: [
//             // Subtle background particles/dots effect
//             Positioned.fill(
//               child: CustomPaint(
//                 painter: ParticlesPainter(),
//               ),
//             ),
//             _isLoading
//                 ? Center(
//                     child: LoadingWidget(
//                         bgColor: Colors.black26,
//                         title: 'Hold on a moment',
//                         subTitle: 'Signing you in...'))
//                 : SafeArea(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             10.heightBox,
//                             // Ultra Premium GIF Card with Glassmorphism
//                             _buildAnimatedWidget(
//                               Center(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(32),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: primaryGradientStart.withOpacity(0.3),
//                                         blurRadius: 40,
//                                         spreadRadius: 5,
//                                       ),
//                                       BoxShadow(
//                                         color: accentPurple.withOpacity(0.2),
//                                         blurRadius: 60,
//                                         spreadRadius: 10,
//                                       ),
//                                     ],
//                                   ),
//                                   child: AnimatedBuilder(
//                                     animation: _shimmerController,
//                                     builder: (context, child) {
//                                       return Container(
//                                         padding: EdgeInsets.all(3),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(32),
//                                           gradient: LinearGradient(
//                                             begin: Alignment.topLeft,
//                                             end: Alignment.bottomRight,
//                                             colors: [
//                                               primaryGradientStart.withOpacity(0.6),
//                                               accentPurple.withOpacity(0.6),
//                                               primaryGradientEnd.withOpacity(0.6),
//                                             ],
//                                             stops: [
//                                               0.0,
//                                               _shimmerController.value,
//                                               1.0,
//                                             ],
//                                           ),
//                                         ),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(30),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.black.withOpacity(0.3),
//                                                 blurRadius: 20,
//                                                 spreadRadius: 2,
//                                               ),
//                                             ],
//                                           ),
//                                           child: ClipRRect(
//                                             borderRadius: BorderRadius.circular(30),
//                                             child: Image.asset(
//                                               R.ASSETS_ANIMATIONS_SIGN_IN_GIF,
//                                               height: MediaQuery.sizeOf(context).height * 0.20,
//                                               width: MediaQuery.sizeOf(context).width * 0.85,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               0,
//                             ),
//                             30.heightBox,

//                             // Welcome text with gradient
//                             _buildAnimatedWidget(
//                               ShaderMask(
//                                 shaderCallback: (bounds) => LinearGradient(
//                                   colors: [
//                                     Colors.white,
//                                     textPrimary.withOpacity(0.9),
//                                   ],
//                                 ).createShader(bounds),
//                                 child: Text(
//                                   'Welcome Back!',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w900,
//                                     fontSize: 34,
//                                     color: Colors.white,
//                                     letterSpacing: 0.5,
//                                     height: 1.2,
//                                   ),
//                                 ),
//                               ),
//                               1,
//                             ),
//                             8.heightBox,

//                             // Description text
//                             _buildAnimatedWidget(
//                               Text(
//                                 'Enter your credentials to access your account',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 15,
//                                   color: textSecondary,
//                                   letterSpacing: 0.3,
//                                   height: 1.5,
//                                 ),
//                               ),
//                               2,
//                             ),
//                             32.heightBox,

//                             // Email Field - Ultra Premium
//                             _buildAnimatedWidget(
//                               _buildPremiumTextField(
//                                 controller: _emailCtrl,
//                                 hintText: 'Email or username',
//                                 icon: Icons.person_outline_rounded,
//                                 isPassword: false,
//                               ),
//                               3,
//                             ),
//                             20.heightBox,

//                             // Password Field - Ultra Premium
//                             _buildAnimatedWidget(
//                               _buildPremiumTextField(
//                                 controller: _passwordCtrl,
//                                 hintText: 'Password',
//                                 icon: Icons.lock_outline_rounded,
//                                 isPassword: true,
//                               ),
//                               4,
//                             ),

//                             // Forget password
//                             _buildAnimatedWidget(
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: TextButton(
//                                   onPressed: () {},
//                                   style: TextButton.styleFrom(
//                                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                                   ),
//                                   child: ShaderMask(
//                                     shaderCallback: (bounds) => LinearGradient(
//                                       colors: [
//                                         primaryGradientStart,
//                                         primaryGradientEnd,
//                                       ],
//                                     ).createShader(bounds),
//                                     child: Text(
//                                       'Forgot password?',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               5,
//                             ),
//                             16.heightBox,

//                             // Ultra Premium Sign In Button with Shimmer
//                             _buildAnimatedWidget(
//                               AnimatedBuilder(
//                                 animation: _shimmerController,
//                                 builder: (context, child) {
//                                   return Container(
//                                     width: double.maxFinite,
//                                     height: 58,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(16),
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           primaryGradientStart,
//                                           accentPurple,
//                                           primaryGradientEnd,
//                                         ],
//                                       ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: primaryGradientStart.withOpacity(0.5),
//                                           blurRadius: 25,
//                                           spreadRadius: 3,
//                                           offset: Offset(0, 8),
//                                         ),
//                                         BoxShadow(
//                                           color: accentPurple.withOpacity(0.3),
//                                           blurRadius: 35,
//                                           spreadRadius: 5,
//                                           offset: Offset(0, 12),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Stack(
//                                       children: [
//                                         // Shimmer effect overlay
//                                         Positioned.fill(
//                                           child: ClipRRect(
//                                             borderRadius: BorderRadius.circular(16),
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 gradient: LinearGradient(
//                                                   begin: Alignment(
//                                                       -1 + _shimmerController.value * 2, 0),
//                                                   end: Alignment(
//                                                       -0.5 + _shimmerController.value * 2, 0),
//                                                   colors: [
//                                                     Colors.transparent,
//                                                     Colors.white.withOpacity(0.3),
//                                                     Colors.transparent,
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Material(
//                                           color: Colors.transparent,
//                                           child: InkWell(
//                                             onTap: _login,
//                                             borderRadius: BorderRadius.circular(16),
//                                             child: Center(
//                                               child: Text(
//                                                 'Sign in',
//                                                 style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                   letterSpacing: 1.2,
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                               6,
//                             ),
//                             28.heightBox,

//                             // Premium Divider
//                             _buildAnimatedWidget(
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       height: 1,
//                                       decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Colors.transparent,
//                                             cardBg.withOpacity(0.5),
//                                             cardBg,
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 20),
//                                     child: Text(
//                                       'Or continue with',
//                                       style: TextStyle(
//                                         color: textSecondary,
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w500,
//                                         letterSpacing: 0.5,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       height: 1,
//                                       decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             cardBg,
//                                             cardBg.withOpacity(0.5),
//                                             Colors.transparent,
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               7,
//                             ),
//                             24.heightBox,

//                             // Ultra Premium Social Buttons
//                             _buildAnimatedWidget(
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: _buildSocialButton(
//                                       icon: R.ASSETS_ICONS_GOOGLE_SVG,
//                                       label: 'Google',
//                                       onTap: () {},
//                                     ),
//                                   ),
//                                   16.widthBox,
//                                   Expanded(
//                                     child: _buildSocialButton(
//                                       icon: R.ASSETS_ICONS_APPLE_SVG,
//                                       label: 'Apple',
//                                       onTap: () {},
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               8,
//                             ),
//                             28.heightBox,

//                             // Sign up text with gradient
//                             _buildAnimatedWidget(
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Don't have an account? ",
//                                     style: TextStyle(
//                                       color: textSecondary,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       context.navigateTo(SignupRoute());
//                                     },
//                                     child: ShaderMask(
//                                       shaderCallback: (bounds) => LinearGradient(
//                                         colors: [
//                                           primaryGradientStart,
//                                           primaryGradientEnd,
//                                         ],
//                                       ).createShader(bounds),
//                                       child: Text(
//                                         'Sign up',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           letterSpacing: 0.5,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               8,
//                             ),
//                             20.heightBox,
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPremiumTextField({
//     required TextEditingController controller,
//     required String hintText,
//     required IconData icon,
//     required bool isPassword,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 15,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: inputBg,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: cardBg.withOpacity(0.5),
//             width: 1,
//           ),
//         ),
//         child: TextField(
//           style: TextStyle(
//             color: textPrimary,
//             fontSize: 15,
//             fontWeight: FontWeight.w500,
//           ),
//           controller: controller,
//           obscureText: isPassword,
//           decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: TextStyle(
//               color: textHint,
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//             ),
//             prefixIcon: Container(
//               margin: EdgeInsets.all(14),
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     primaryGradientStart.withOpacity(0.15),
//                     primaryGradientEnd.withOpacity(0.15),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 icon,
//                 color: primaryGradientStart,
//                 size: 20,
//               ),
//             ),
//             suffixIcon: isPassword
//                 ? Padding(
//                     padding: EdgeInsets.only(right: 12),
//                     child: Icon(
//                       Icons.visibility_off_outlined,
//                       color: textHint,
//                       size: 20,
//                     ),
//                   )
//                 : null,
//             filled: false,
//             border: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: primaryGradientStart,
//                 width: 2,
//               ),
//             ),
//             contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialButton({
//     required String icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 12,
//             offset: Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(14),
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 16),
//             decoration: BoxDecoration(
//               color: inputBg,
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(
//                 color: cardBg.withOpacity(0.6),
//                 width: 1.5,
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(
//                   icon,
//                   height: 22,
//                 ),
//                 12.widthBox,
//                 Text(
//                   label,
//                   style: TextStyle(
//                     color: textPrimary,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Custom Painter for Background Particles
// class ParticlesPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white.withOpacity(0.02)
//       ..style = PaintingStyle.fill;

//     for (int i = 0; i < 30; i++) {
//       final x = (i * 37) % size.width;
//       final y = (i * 53) % size.height;
//       canvas.drawCircle(Offset(x, y), 2, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

class _SigninPageState extends ConsumerState<SigninPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  // Modern Dark Theme Colors
  final Color darkBg1 = const Color(0xFF1a1a2e);
  final Color darkBg2 = const Color(0xFF16213e);
  final Color darkBg3 = const Color(0xFF0f3460);
  final Color cardBg = const Color(0xFF1e293b);
  final Color inputBg = const Color(0xFF0f172a);
  final Color primaryGradientStart = const Color(0xFF6366f1);
  final Color primaryGradientEnd = const Color(0xFF8b5cf6);
  final Color textPrimary = Colors.white;
  final Color textSecondary = const Color(0xFF94a3b8);
  final Color textHint = const Color(0xFF64748b);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Create staggered animations for each element
    _fadeAnimations = List.generate(8, (index) {
      double start = index * 0.08;
      double end = start + 0.4;

      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          start.clamp(0.0, 1.0),
          end.clamp(0.0, 1.0),
          curve: Curves.easeOutCubic,
        ),
      ));
    });

    _slideAnimations = List.generate(8, (index) {
      double start = index * 0.08;
      double end = start + 0.4;

      return Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          start.clamp(0.0, 1.0),
          end.clamp(0.0, 1.0),
          curve: Curves.easeOutCubic,
        ),
      ));
    });

    // Start animation after a brief delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ============= FUNCTIONS PART ==========//
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _login() async {
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.login(_emailCtrl.text, _passwordCtrl.text);

      if (user != null && mounted) {
        // Wait a bit for auth state to update
        await Future.delayed(const Duration(milliseconds: 100));
        context.router.replaceAll([NavBarRoute()]);
      }
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Login failed")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildAnimatedWidget(Widget child, int index) {
    return SlideTransition(
      position: _slideAnimations[index],
      child: FadeTransition(
        opacity: _fadeAnimations[index],
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Background gradient - full screen
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primaryGradientStart,
                  primaryGradientEnd,
                ],
              ),
            ),
          ),

          // Content
          _isLoading
              ? Center(
                  child: LoadingWidget(
                      bgColor: Colors.black26,
                      title: 'Hold on a moment',
                      subTitle: 'Signing you in...'))
              : SafeArea(
                  child: Column(
                    children: [
                      // Top section with back button and sign up link
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    context.navigateTo(SignupRoute());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                    ),
                                    child: Text(
                                      'Get Started',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // App name
                      _buildAnimatedWidget(
                        Text(
                          'Jobsly',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                        0,
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      // White card section
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Welcome Back title
                                _buildAnimatedWidget(
                                  Text(
                                    'Welcome Back',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1a1a2e),
                                    ),
                                  ),
                                  1,
                                ),
                                SizedBox(height: 8),

                                // Subtitle
                                _buildAnimatedWidget(
                                  Text(
                                    'Enter your details below',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  2,
                                ),
                                SizedBox(height: 32),

                                // Email field
                                _buildAnimatedWidget(
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email Address',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: TextField(
                                          controller: _emailCtrl,
                                          style: TextStyle(
                                            color: Color(0xFF1a1a2e),
                                            fontSize: 15,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'nicholas@ergemla.com',
                                            hintStyle: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 15,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  3,
                                ),
                                SizedBox(height: 20),

                                // Password field
                                _buildAnimatedWidget(
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Password',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: TextField(
                                          controller: _passwordCtrl,
                                          obscureText: _obscurePassword,
                                          style: TextStyle(
                                            color: Color(0xFF1a1a2e),
                                            fontSize: 15,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '••••••••••••••••',
                                            hintStyle: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 15,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obscurePassword
                                                    ? Icons.visibility_off_outlined
                                                    : Icons.visibility_outlined,
                                                color: Colors.grey[400],
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _obscurePassword = !_obscurePassword;
                                                });
                                              },
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  4,
                                ),
                                SizedBox(height: 24),

                                // Sign in button
                                _buildAnimatedWidget(
                                  Container(
                                    width: double.infinity,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          primaryGradientStart,
                                          primaryGradientEnd,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primaryGradientStart.withOpacity(0.4),
                                          blurRadius: 20,
                                          spreadRadius: 0,
                                          offset: Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: _login,
                                        borderRadius: BorderRadius.circular(14),
                                        child: Center(
                                          child: Text(
                                            'Sign in',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  5,
                                ),
                                SizedBox(height: 16),

                                // Forgot password
                                _buildAnimatedWidget(
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        // Handle forget password
                                      },
                                      child: Text(
                                        'Forgot your password?',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  6,
                                ),
                                SizedBox(height: 16),

                                // Divider
                                _buildAnimatedWidget(
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(color: Colors.grey[300]),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child: Text(
                                          'Or sign in with',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(color: Colors.grey[300]),
                                      ),
                                    ],
                                  ),
                                  7,
                                ),
                                SizedBox(height: 20),

                                // Social buttons
                                _buildAnimatedWidget(
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 14),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.grey[300]!,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                R.ASSETS_ICONS_GOOGLE_SVG,
                                                height: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Google',
                                                style: TextStyle(
                                                  color: Color(0xFF1a1a2e),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 14),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.grey[300]!,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.facebook,
                                                color: Color(0xFF1877F2),
                                                size: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Facebook',
                                                style: TextStyle(
                                                  color: Color(0xFF1a1a2e),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  7,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
