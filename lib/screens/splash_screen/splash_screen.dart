import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tyba_great_app/constanst/assets_contants.dart';
import 'package:tyba_great_app/screens/home_screen/home_screen.dart';
import 'package:tyba_great_app/screens/login_screen/login_screen.dart';
import 'package:tyba_great_app/screens/splash_screen/splash_presenter.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();

}

class _SplashScreenState extends SplashScreenDelegate<SplashScreen> {

  final SplashPresenter presenter = SplashPresenter();

  @override
  void initState() {
    presenter.mView = this;
    presenter.checkIfUserIsLogged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(7, 48, 42, 1.0),
      body: Center(
        child: _createAnimation(),
      ),
    );
  }

  Widget _createAnimation() {
    return Lottie.asset(kLottieLoader, width: 64);
  }

  @override
  void navigateToHome() {
    navigatePushReplacement(const HomeScreen(key: Key("HomeScreen")));
  }

  @override
  void navigateToLogin() {
    navigatePushReplacement(const LoginScreen(key: Key("LoginScreen")));
  }

}