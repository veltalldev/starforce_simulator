import 'dart:math';

import 'package:starforce_sim/simulation/simulation_config.dart';
import 'package:starforce_sim/simulation/simulation_state.dart';

import '../models/upgrade_result.dart';
import '../services/probability_provider.dart';

class UpgradeService {
  final ProbabilityProvider probabilityProvider;
  final SimulationState state;
  final SimulationConfig config;

  // Constructor that takes in the ProbabilityProvider (which is already async-loaded)
  UpgradeService({
    required this.probabilityProvider,
    required this.state,
    required this.config,
  });

  // Method to handle an upgrade attempt using the provided probability values
  UpgradeOutcome attemptUpgrade() {
    // Use the probabilityProvider to determine success, fail, or destruction
    final double successRate = probabilityProvider.getSuccessRate();
    final double failDecreaseRate = probabilityProvider.getFailDecreaseRate();
    final double failDestroyRate = probabilityProvider.getFailDestroyRate();

    // Randomly decide the result of the upgrade
    final double roll = Random().nextDouble();

    final currentStar = state.getCurrentStar();

    if (roll < successRate) {
      state.incrementStar();
      return UpgradeOutcome(
        result: UpgradeResult.success,
        state: state,
        config: config,
        initialStar: currentStar,
      ); // The upgrade was successful
    }

    if (roll < successRate + failDecreaseRate) {
      state.decrementStar();
      return UpgradeOutcome(
        result: UpgradeResult.failDecrease,
        state: state,
        config: config,
        initialStar: currentStar,
      ); // The star decreased
    }

    if (roll < successRate + failDecreaseRate + failDestroyRate) {
      state.equipment.destroy();
      state.destroyedTrials++;
      return UpgradeOutcome(
        result: UpgradeResult.failDestroy,
        state: state,
        config: config,
        initialStar: currentStar,
      ); // The equipment was destroyed
    }

    // If none of the above conditions were met, the upgrade failed, but the star remained the same
    return UpgradeOutcome(
      result: UpgradeResult.failMaintain,
      state: state,
      config: config,
      initialStar: currentStar,
    );
  }
}
