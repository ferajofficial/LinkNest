import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_nest/const/resource.dart';
import 'package:link_nest/core/router/router.gr.dart';
import 'package:link_nest/data/providers/auth/auth_repo_provider.dart';
import 'package:link_nest/shared/global_button.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SigniupPageState();
}

class _SigniupPageState extends ConsumerState<SignupPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Create staggered animations for each element
    _fadeAnimations = List.generate(8, (index) {
      double start = index * 0.08; // Reduced interval spacing
      double end = start + 0.4; // Reduced duration per element

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

  Widget _buildAnimatedWidget(Widget child, int index) {
    return SlideTransition(
      position: _slideAnimations[index],
      child: FadeTransition(
        opacity: _fadeAnimations[index],
        child: child,
      ),
    );
  }

  // =========== LOGIC PART CODE ============//
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  bool _isLoading = false;

  void _signup() async {
    if (_emailCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter your mail first.')));
      return;
    } else if (_passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter your password first.')));
      return;
    } else if (_confirmPasswordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter your confirm password first.')));
      return;
    } else if (_passwordCtrl.text.trim() != _confirmPasswordCtrl.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Password should not be different.Please cross-check the password you have entered.")));
      return;
    }
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.signUp(
          _emailCtrl.text.trim(), _confirmPasswordCtrl.text.trim(), nameCtrl.text.trim());
      if (user != null) {
        // ✅ store onboarding as seen
        await repo.setOnboardingSeen();
        if (mounted) {
          context.navigateTo(HomeRoute());
        }
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message ?? "Signup failed")));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image without animation (as requested)
                Image.asset(
                  R.ASSETS_ANIMATIONS_SIGN__UP_GIF,
                  height: MediaQuery.sizeOf(context).height * 0.28,
                ).centered(),
                30.heightBox,

                // Welcome text - animated
                _buildAnimatedWidget(
                  Text(
                    'Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                  0,
                ),
                4.heightBox,

                // Description text - animated
                _buildAnimatedWidget(
                  Text(
                    textAlign: TextAlign.left,
                    'Welcome,Please enter the below details to signup.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                      color: Colors.black45,
                      letterSpacing: 1,
                    ),
                  ),
                  1,
                ),
                20.heightBox,

                // User name field - animated
                _buildAnimatedWidget(
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      hintText: 'Your name',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.person_outline, color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                  ),
                  2,
                ),
                16.heightBox,
                _buildAnimatedWidget(
                  TextField(
                    controller: _emailCtrl,
                    decoration: InputDecoration(
                      hintText: 'Your email',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.person_outline, color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                  ),
                  2,
                ),
                16.heightBox,

                // Password field - animated
                _buildAnimatedWidget(
                  TextField(
                    controller: _passwordCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                  ),
                  3,
                ),
                16.heightBox,

                // Password field - animated
                _buildAnimatedWidget(
                  TextField(
                    controller: _confirmPasswordCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                      suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                  ),
                  3,
                ),

                16.heightBox,

                // Login button - animated
                _buildAnimatedWidget(
                  GlobalButton(
                      backgroundColor: Colors.black,
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        // context.navigateTo(HomeRoute());
                        _signup();
                      }).w(double.maxFinite).h(50),
                  5,
                ),
                20.heightBox,

                // Or Continue with - animated
                _buildAnimatedWidget(
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey[300])),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Or signup with',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey[300])),
                    ],
                  ),
                  6,
                ),
                20.heightBox,

                // Social login buttons - animated
                _buildAnimatedWidget(
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                R.ASSETS_ICONS_GOOGLE_SVG,
                                height: MediaQuery.sizeOf(context).height * 0.024,
                              ),
                              12.widthBox,
                              Text(
                                'Google',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      12.widthBox,
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                R.ASSETS_ICONS_APPLE_SVG,
                                height: MediaQuery.sizeOf(context).height * 0.024,
                              ),
                              12.widthBox,
                              Text(
                                'Apple',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
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
                20.heightBox,

                // Sign up text - animated
                _buildAnimatedWidget(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle sign up navigation
                          // context.nextAndRemoveUntilPage(SigninPage());
                          context.navigateTo(SigninRoute());
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
    );
  }
}

/*

import 'package:auto_route/auto_route.dart';
import 'package:pnt_flutter_user/bootstrap.dart';
import 'package:pnt_flutter_user/core/router/router.gr.dart';
import 'package:pnt_flutter_user/data/service/verify_otp_db/verify_otp_db_service.dart';

class LoginGuard extends AutoRouteGuard {
  final VerifyOtpDbService verifyOtpDbService;
  // final AppStorage appStorage;
  LoginGuard({
    required this.verifyOtpDbService,
    // required this.appStorage,
  });
  @override

  /// A class that provides database services for token management.
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    //for user login
    final verifyOtpModel = verifyOtpDbService.getVerifyOtpModel();
    final token = verifyOtpModel?.verifyOtpData?.otpLogin?.token;
    final isEmailExist = verifyOtpModel?.verifyOtpData?.otpLogin?.isEmailExist;

    if (token != null && isEmailExist == false) {
      talker.debug('hi 1 $token $isEmailExist ');
      router.replaceAll([UpdateUserRoute(isEditMode: false)]);
      resolver.next(false);
    } else if (token != null && isEmailExist == true) {
      talker.debug('hi 2 $token $isEmailExist');
      talker.debug('jwt in login guards - $token');
      router.replaceAll([NavbarRoute()]);
      resolver.next(false);
    } else {
      talker.debug('hi 3 $token $isEmailExist');
      // final box = appStorage.appBox;
      // await box?.clear();
      resolver.next(true);
    }
  }
}
 */

/*
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:pnt_flutter_user/core/router/guards/login_guards.dart';
import 'package:pnt_flutter_user/core/router/router.gr.dart';
import 'package:pnt_flutter_user/data/service/verify_otp_db/verify_otp_db_service.dart';

/// This class used for defined routes and paths na dother properties
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final VerifyOtpDbService verifyOtpDbService;
  // final AppStorage appStorage;
  AppRouter({
    required this.verifyOtpDbService,
    // required this.appStorage,
  });
  @override
  late final List<AutoRoute> routes = [
    AdaptiveRoute(
      page: CounterRoute.page,
      path: '/counter',
    ),
    AdaptiveRoute(
      page: OnboardingRoute.page,
      path: '/',
      initial: true,
      guards: [
        LoginGuard(
          verifyOtpDbService: verifyOtpDbService,
        ),
      ],
    ),
    AdaptiveRoute(
      page: GrantPermissionsRoute.page,
      path: '/grant-permissions',
    ),
    AdaptiveRoute(
      page: HomeRoute.page,
      path: '/home',
    ),
    AdaptiveRoute(
      page: LoginRoute.page,
      path: '/login',
    ),
    AdaptiveRoute(
      page: NavbarRoute.page,
      path: '/navbar',
    ),
    AdaptiveRoute(
      page: UpdateUserRoute.page,
      path: '/update-user',
    ),
    AdaptiveRoute(
      page: EditProfileRoute.page,
      path: '/edit-user',
    ),
    AdaptiveRoute(
      page: CoTravellerRoute.page,
      path: '/co-traveller',
    ),
    AdaptiveRoute(
      page: CoTravellerProfileRoute.page,
      path: '/co-traveller-profile',
    ),
    AdaptiveRoute(
      page: VendorRoute.page,
      path: '/vendor',
    ),
    AdaptiveRoute(
      page: VendorListRoute.page,
      path: '/vendor-list',
    ),
    AdaptiveRoute(
      page: VendorCategorySelectionRoute.page,
      path: '/vendor-category-select',
    ),
    AdaptiveRoute(
      page: VendorCitySelectionRoute.page,
      path: '/vendor-city-select',
    ),
    AdaptiveRoute(
      page: VendorProfileRoute.page,
      path: '/vendor-profile',
    ),
    AdaptiveRoute(
      page: DmcRoute.page,
      path: '/dmc',
    ),
    AdaptiveRoute(
      page: SearchRoute.page,
      path: '/search-users',
    ),
    AdaptiveRoute(
      page: UpdatesRoute.page,
      path: '/updates',
    ),
    AdaptiveRoute(
      page: ExploreAllRoute.page,
      path: '/explore-all',
    ),
    AdaptiveRoute(
      page: ExploreTagsRoute.page,
      path: '/explore-tags',
    ),
    AdaptiveRoute(
      page: ExploreDestinationRoute.page,
      path: '/explore-destination',
    ),

    AdaptiveRoute(
      page: ProfileRoute.page,
      path: '/profile',
    ),
    AdaptiveRoute(
      page: CreateConsultantRoute.page,
      path: '/create-consultant',
    ),
    AdaptiveRoute(
      page: ConsultantListRoute.page,
      path: '/consultant-list',
    ),
    AdaptiveRoute(
      page: ConsultantProfileRoute.page,
      path: '/consultant-profile',
    ),
    AdaptiveRoute(
      page: NotificationRoute.page,
      path: '/notification',
    ),
    // AdaptiveRoute(
    //   page: InviteeJoinedRoute.page,
    //   path: '/invitee-joined',
    // ),
    AdaptiveRoute(
      page: InviteCoTravellerRoute.page,
      path: '/invite-cotraveller',
    ),
    AdaptiveRoute(
      page: HostListRoute.page,
      path: '/host-list',
    ),
    AdaptiveRoute(
      page: HostProfileRoute.page,
      path: '/host-profile',
    ),
    AdaptiveRoute(
      page: CreateHostRoute.page,
      path: '/create-host',
    ),
    AdaptiveRoute(
      page: GuideListRoute.page,
      path: '/guide-list',
    ),
    AdaptiveRoute(
      page: GuideProfileRoute.page,
      path: '/guide-profile',
    ),
    AdaptiveRoute(
      page: QuotesFormRoute.page,
      path: '/quotes-form',
    ),
    AdaptiveRoute(
      page: DynamicFormRoute.page,
      path: '/dynamic-form',
    ),
    AdaptiveRoute(
      page: ImagePreviewRoute.page,
      path: '/image-preview',
    ),
    AdaptiveRoute(
      page: MultipleImagesPreviewRoute.page,
      path: '/multiple-image-preview',
    ),
    AdaptiveRoute(
      page: BlogWebViewRoute.page,
      path: '/blog-webview',
    ),
    AdaptiveRoute(
      page: CreateGuideRoute.page,
      path: '/create-guide',
    ),
    AdaptiveRoute(
      page: SponsoredRoute.page,
      path: '/sponsored',
    ),
    AdaptiveRoute(
      page: AllCategoriesRoute.page,
      path: '/all-categories',
    ),
    AdaptiveRoute(
      page: PlansListRoute.page,
      path: '/plans-list',
    ),
    AdaptiveRoute(
      page: PastTripsListRoute.page,
      path: '/plans-trips-list',
    ),
    AdaptiveRoute(
      page: PastTripDetailsRoute.page,
      path: '/plans-trip-details-list',
    ),
    AdaptiveRoute(
      page: MyPlansRoute.page,
      path: '/my-plans',
    ),

    AdaptiveRoute(
      page: ReviewListRoute.page,
      path: '/review-list',
    ),
    AdaptiveRoute(
      page: WelcomeRoute.page,
      path: '/welcome',
    ),
    //dialog route
    // CustomRoute(
    //   page: TestDialogRoute.page,
    //   path: '/test-dialog',
    //   customRouteBuilder: <T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
    //     return BottomDialogRoute(
    //       context: context,
    //       settings: page,
    //       builder: (_) => child,
    //     );
    //   },
    // ),
    //invited history sheet route
    AdaptiveRoute(
      page: CoTravellerRequestListRoute.page,
      path: '/co-traveller-request-list-dialog',
    ),
    //verify otp sheet route
    CustomRoute(
      page: VerifyOtpDialogRoute.page,
      path: '/verify-otp-dialog',
      customRouteBuilder: <T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
        return CupertinoSheetRoute(
          settings: page,
          builder: (_) => child,
        );
      },
    ),
    //country selector sheet route
    CustomRoute(
      page: CountrySelectorDialogRoute.page,
      path: '/country-selector-dialog',
      customRouteBuilder: <T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
        return CupertinoSheetRoute(
          settings: page,
          builder: (_) => child,
        );
      },
    ),
    //state selector sheet route
    CustomRoute(
      page: StateSelectorDialogRoute.page,
      path: '/state-selector-dialog',
      customRouteBuilder: <T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
        return CupertinoSheetRoute(
          settings: page,
          builder: (_) => child,
        );
      },
    ),
    //city selector sheet route
    CustomRoute(
      page: CitySelectorDialogRoute.page,
      path: '/city-selector-dialog',
      customRouteBuilder: <T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
        return CupertinoSheetRoute(
          settings: page,
          builder: (_) => child,
        );
      },
    ),
    //language selector sheet route
    CustomRoute(
      page: LanguageSelectorDialogRoute.page,
      path: '/language-selector-dialog',
      customRouteBuilder: <T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
        return CupertinoSheetRoute(
          settings: page,
          builder: (_) => child,
        );
      },
    ),
    //destination selector sheet route
    CustomRoute(
      page: DestinationSelectorDialogRoute.page,
      path: '/destination-selector-dialog',
      customRouteBuilder: <T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
        return CupertinoSheetRoute(
          settings: page,
          builder: (_) => child,
        );
      },
    ),
    //vendor trip package detail sheet route
    CustomRoute(
      page: VendorTripPackageDetailDialogRoute.page,
      path: '/vendor-trip-package-detail-dialog',
      customRouteBuilder: <T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
        return CupertinoSheetRoute(
          settings: page,
          builder: (_) => child,
        );
      },
    ),
  ];
}
 */
