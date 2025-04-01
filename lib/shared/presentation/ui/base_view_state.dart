import 'package:flutter/material.dart';

import '../../../core/di/dependecy_injection.dart';
import 'controllers/base_controller.dart';

abstract class BaseViewState<T extends StatefulWidget, R extends BaseController>
    extends State<T> with AutomaticKeepAliveClientMixin, RouteAware {
  R? controller = getIt.get<R>();
}
