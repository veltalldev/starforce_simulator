import 'dart:math';
import '../models/equipment.dart';
import '../models/upgrade_result.dart';
import './probability_provider.dart';

class UpgradeService {
  final Equipment equipment;

  UpgradeService(this.equipment);

  UpgradeResult attemptUpgrade(
    bool pityEnabled,
    int consecutiveFailures,
    bool eventEnabled,
    bool safeguardEnabled,
  ) {
    // reading loaded data
    double successRate = ProbabilityProvider.getSuccessRate(
        equipment.currentStar, pityEnabled, consecutiveFailures, eventEnabled);
    double failMaintainRate =
        ProbabilityProvider.getFailMaintainRate(equipment.currentStar);
    double failDecreaseRate =
        ProbabilityProvider.getFailDecreaseRate(equipment.currentStar);
    double failDestroyRate = ProbabilityProvider.getFailDestroyRate(
        equipment.currentStar, safeguardEnabled);

    // roll the dice
    double randomValue = Random().nextDouble();

    if (randomValue <= successRate) {
      equipment.upgradeStar();
      return UpgradeResult.success;
    } else if (randomValue <= successRate + failMaintainRate) {
      return UpgradeResult.failMaintain;
    } else if (randomValue <=
        successRate + failMaintainRate + failDecreaseRate) {
      equipment.decreaseStar();
      return UpgradeResult.failDecrease;
    } else if (randomValue <=
        successRate + failMaintainRate + failDecreaseRate + failDestroyRate) {
      equipment.destroy();
      return UpgradeResult.failDestroy;
    } else {
      return UpgradeResult.failMaintain;
    }
    // if (randomValue <= successRate) {
    //   equipment.upgradeStar();
    //   return UpgradeResult.success;
    // } else if (randomValue <= successRate + failMaintainRate) {
    //   return UpgradeResult.failMaintain;
    // } else if (randomValue <=
    //     successRate + failMaintainRate + failDecreaseRate) {
    //   equipment.decreaseStar();
    //   return UpgradeResult.failDecrease;
    // } else {
    //   equipment.destroy();
    //   return UpgradeResult.failDestroy;
    // }
  }
}
