import 'package:flutter/material.dart';
import 'package:kumbuz/utils/router.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop() {
    return _navigationKey.currentState!.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  popAtHome() {
    return _navigationKey.currentState!
        .pushNamedAndRemoveUntil(AppRoutes.Home, (route) => false);
  }

  goToTestPage() {
    return _navigationKey.currentState!
        .pushNamedAndRemoveUntil(AppRoutes.ViewTest, (route) => false);
  }

  goToLoginPage() {
    return _navigationKey.currentState!
        .pushNamedAndRemoveUntil(AppRoutes.Login, (route) => false);
  }

  goToSingUpPage() {
    return _navigationKey.currentState!
        .pushNamedAndRemoveUntil(AppRoutes.SingUp, (route) => false);
  }

  goToOnBoarding() {
    return _navigationKey.currentState!
        .pushNamedAndRemoveUntil(AppRoutes.OnBoarding, (route) => false);
  }
}
