import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_guest.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../controller/kixikila_controller.dart';

class MyKixikilaGuestTagController<T extends String>
    extends TextfieldTagsController<T> {
  var kikixilaController = DI.get<KixikilaController>();

  @override
  bool? onTagSubmitted(T value) {
    String? validate = getValidator != null ? getValidator!(value) : null;
    if (validate == null) {
      bool? addTag = super.addTag(value);
      if (addTag == true) {
        setError = null;
        scrollTags();
      }
    } else
      setError = validate;

    return null;
  }

  @override
  set setError(String? error) {
    super.setError = error;
    notifyListeners();
  }

  doOtherThings() {}
}
