import 'package:starforce_sim_flutter/models/upgrade_result.dart';
import 'package:starforce_sim_flutter/services/upgrade_service.dart';
import 'package:starforce_sim_flutter/services/probability_provider.dart';
import 'package:starforce_sim_flutter/services/cost_provider.dart';
import 'package:starforce_sim_flutter/simulation/simulation_config.dart';
import 'package:starforce_sim_flutter/simulation/simulation_state.dart';
import 'package:starforce_sim_flutter/simulation/simulation_outcome.dart';

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

  SimulationOutcome runSimulation() {
    final simOutcome = SimulationOutcome(config: config);
    for (int i = 0; i < config.trialCount; i++) {
      state.resetState();
      final upgradeService = UpgradeService(
        config: config,
        state: state,
        probabilityProvider: probabilityProvider,
      );

      // TODO: Fix the destroy check
      while (!state.equipment.isDestroyed && !state.reachedTargetStar()) {
        UpgradeOutcome outcome = upgradeService.attemptUpgrade();

        outcome.updateCost(costProvider.getCost());

        simOutcome.add(upgradeOutcome: outcome);
      }
    }

    return simOutcome;
  }
}
