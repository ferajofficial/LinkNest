import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(deferredLoading: true)
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ONBOARDING PAGE ENTERED'),
      ),
    );
  }
}
