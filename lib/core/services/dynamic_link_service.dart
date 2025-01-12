import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:kumbuz/core/setup_app.dart';
import 'package:kumbuz/core/utils/navigation_service.dart';
import 'package:kumbuz/core/utils/router.dart';

class DynamicLinkService {
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleDynamicLinks() async {
    //Get initial dynamic link if the app is started using the link
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data);

    // FirebaseDynamicLinks.instance.onLink.listen((event) {
    //   _handleDeepLink(data);
    // });

    FirebaseDynamicLinks.instance.onLink;
  }

  void _handleDeepLink(PendingDynamicLinkData? data) {
    // final Uri? deeplink = data!.link;
    if (data != null) {
      print("This is the Deeplink handled: ${data.link}");

      //Todo replace this when finished test
      _navigationService.navigateTo(AppRoutes.ViewTest);
    } else {
      print("DeepLink is Null");
    }
  }
}
