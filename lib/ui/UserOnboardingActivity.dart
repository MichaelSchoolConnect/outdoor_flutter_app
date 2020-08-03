import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outdoor_flutter_app/widgets/slider_layout_view.dart';

class UserOnboardingActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingLandingPage();
}

class _OnboardingLandingPage extends State<UserOnboardingActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: onBordingBody(),
    );
  }

  Widget onBordingBody() => Container(
        child: SliderLayoutView(),
      );
}
