import '../environments/environments.dart';

enum FeatureFlag { openFinance, kixikila }

extension FeatureFlagExtension on FeatureFlag {
  bool isFeatureEnabledFor(Environment environment) {
    switch (environment) {
      case Environment.dev:
        switch (this) {
          case FeatureFlag.openFinance:
            return true;
          case FeatureFlag.kixikila:
            return true;
        }

      case Environment.prod:
        switch (this) {
          case FeatureFlag.openFinance:
            return false;
          case FeatureFlag.kixikila:
            return true;
        }
    }
  }
}
