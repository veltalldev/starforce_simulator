import 'dart:math';

import '../models/upgrade_result.dart';
import '../services/probability_provider.dart';

class UpgradeService {
  final ProbabilityProvider probabilityProvider;

  // Constructor that takes in the ProbabilityProvider (which is already async-loaded)
  UpgradeService(this.probabilityProvider);

  // Method to handle an upgrade attempt using the provided probability values
  UpgradeResult attemptUpgrade() {
    // Use the probabilityProvider to determine success, fail, or destruction
    final double successRate = probabilityProvider.getSuccessRate() / 100.0;
    final double failDecreaseRate =
        probabilityProvider.getFailDecreaseRate() / 100.0;
    final double failDestroyRate =
        probabilityProvider.getFailDestroyRate() / 100.0;

    // Randomly decide the result of the upgrade
    final double roll = Random().nextDouble();

    if (roll < successRate) {
      return UpgradeResult.success; // The upgrade was successful
    }

    if (roll < successRate + failDecreaseRate) {
      return UpgradeResult.failDecrease; // The star decreased
    }

    if (roll < successRate + failDecreaseRate + failDestroyRate) {
      return UpgradeResult.failDestroy; // The equipment was destroyed
    }

    // If none of the above conditions were met, the upgrade failed, but the star remained the same
    return UpgradeResult.failMaintain;
  }
}
