import '../models/equipment.dart';
import '../models/upgrade_result.dart';
import '../services/probability_provider.dart';
import '../services/upgrade_service.dart';
import '../services/cost_calculator.dart';

void runSimulationWithFeatures(
  int startStar,
  int targetStar,
  bool pityEnabled,
  bool safeguardEnabled,
  bool eventEnabled,
) {
  int totalTrials = 10000;
  int equipmentLevel = 150;

  int totalCost = 0;
  int successfulTrials = 0;
  int destroyedTrials = 0;
  int totalAttempts = 0;

  for (int i = 0; i < totalTrials; i++) {
    final equipment = Equipment(equipmentLevel, startStar);
    final upgradeService = UpgradeService(equipment);

    int trialCost = 0;
    int attempts = 0;
    int consecutiveFailures = 0;
    bool success = false;

    while (!equipment.isDestroyed && equipment.currentStar < targetStar) {
      trialCost +=
          CostCalculator.calculateCost(equipmentLevel, equipment.currentStar);
      UpgradeResult result = upgradeService.attemptUpgrade(
        pityEnabled,
        consecutiveFailures,
        eventEnabled,
        safeguardEnabled,
      );

      if (result == UpgradeResult.success) {
        success = true;
        consecutiveFailures = 0;
        if (equipment.currentStar >= targetStar) break;
      } else if (result == UpgradeResult.failDestroy) {
        destroyedTrials++;
        break;
      } else if (result == UpgradeResult.failDecrease) {
        consecutiveFailures++;
      } else {
        // nothing happens during fail maintain
      }

      attempts++;
    }

    totalAttempts += attempts;
    totalCost += trialCost;

    if (success && equipment.currentStar == targetStar) {
      successfulTrials++;
    }
  }

  print('Total Trials: $totalTrials');
  print('Successful Trials: $successfulTrials');
  print('Destroyed Trials: $destroyedTrials');
  print('Average Cost Per Attempt: ${totalCost / totalAttempts / 1e9} b');
  print(
      'Average Cost Per Success: ${successfulTrials > 0 ? (totalCost / successfulTrials) / 1e9 : 0} b');
  print('Destruction Rate: ${100 * destroyedTrials / totalTrials}%');
}

void main() async {
  await ProbabilityProvider.ensureDataLoaded(
    "./data/starcatch_probability_table.csv",
  );

  // features: pity, safeguard, event
  runSimulationWithFeatures(15, 20, true, true, true);
}
