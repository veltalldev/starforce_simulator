import '../models/upgrade_result.dart';
import '../services/upgrade_service.dart';
import '../services/probability_provider.dart';
import '../services/cost_provider.dart';
import 'simulation_config.dart';
import 'simulation_state.dart';
import 'simulation_result.dart';

class Simulator {
  final SimulationConfig config;
  final SimulationState state;
  final ProbabilityProvider probabilityProvider;
  final CostProvider costProvider;

  // Async factory constructor to handle ProbabilityProvider's async loading
  static Future<Simulator> create({required SimulationConfig config}) async {
    final state = SimulationState(config: config);
    final probabilityProvider = await ProbabilityProvider.createProvider(
      config,
      state,
    ); // Wait for ProbabilityProvider
    final costProvider = CostProvider(config, state);
    return Simulator._internal(
      config,
      state,
      probabilityProvider,
      costProvider,
    );
  }

  // Private constructor once the async initialization is complete
  Simulator._internal(
    this.config,
    this.state,
    this.probabilityProvider,
    this.costProvider,
  );

  SimulationResult runSimulation() {
    // Simulation logic remains the same
    for (int i = 0; i < config.trialCount; i++) {
      state.resetState();
      final upgradeService = UpgradeService(probabilityProvider);

      double trialCost = 0;
      int attempts = 0;
      bool reachedTarget = false;

      // TODO: Fix the destroy check
      while (!state.equipment.isDestroyed &&
          state.getCurrentStar() < config.targetStar) {
        trialCost += costProvider.getCost();

        UpgradeResult result = upgradeService.attemptUpgrade();

        if (result == UpgradeResult.success) {
          state.incrementStar();
          if (state.getCurrentStar() >= config.targetStar) {
            reachedTarget = true;
            break;
          }
        } else if (result == UpgradeResult.failDestroy) {
          state.equipment.destroy();
          state.destroyedTrials++;
          break;
        } else if (result == UpgradeResult.failDecrease) {
          state.decrementStar();
        }

        attempts++;
      }

      state.totalAttempts += attempts;
      state.totalCost += trialCost;

      if (reachedTarget) {
        state.successfulTrials++;
      }
    }

    return SimulationResult(
      totalTrials: config.trialCount,
      successfulTrials: state.successfulTrials,
      destroyedTrials: state.destroyedTrials,
      averageCostPerAttempt: state.totalCost / state.totalAttempts / 1e9,
      averageCostPerSuccess: state.successfulTrials > 0
          ? (state.totalCost / state.successfulTrials) / 1e9
          : 0,
      destructionRate: 100 * state.destroyedTrials / config.trialCount,
    );
  }
}
