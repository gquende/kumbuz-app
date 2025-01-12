import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/presenter/pages/auth/login.dart';
import 'package:kumbuz/features/sateva/presenter/pages/mock_widgets.dart';
import 'package:kumbuz/features/sateva/presenter/pages/newhome/presentation/newhome.dart';
import 'package:kumbuz/features/sateva/presenter/pages/onboarding.dart';

import '../../features/sateva/presenter/pages/auth/sign_up.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.SingUp:
      return _getPageRoute(routeName: settings.name, viewtoShow: SignUp());
    case AppRoutes.Home:
      return _getPageRoute(
          routeName: settings.name, viewtoShow: const NewHome());
    case AppRoutes.Login:
      return _getPageRoute(routeName: settings.name, viewtoShow: Login());
    case AppRoutes.ViewTest:
      return _getPageRoute(
          routeName: settings.name, viewtoShow: const MockWidgetsTest());
    case AppRoutes.OnBoarding:
      return _getPageRoute(
          routeName: settings.name, viewtoShow: const OnBoarding());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Sem rota definida!!"),
                ),
              ));
  }
}

PageRoute _getPageRoute({String? routeName, Widget? viewtoShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(name: routeName), builder: (_) => viewtoShow!);
}

class AppRoutes {
  static const String Login = "login";
  static const String Home = "home";
  static const String ViewTest = "view_test";
  static const String SingUp = "singup";
  static const String OnBoarding = "onboarding";
}
