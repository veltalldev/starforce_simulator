import 'package:starforce_sim_flutter/models/upgrade_result.dart';
import 'package:starforce_sim_flutter/models/simulation_report.dart';
import 'package:starforce_sim_flutter/simulation/simulation_config.dart';

class SimulationOutcome {
  final List<UpgradeOutcome> outcomes = <UpgradeOutcome>[];
  final SimulationConfig config;
  // final SimulationReport report;

  SimulationOutcome({required this.config});

  void add({required UpgradeOutcome upgradeOutcome}) {
    outcomes.add(upgradeOutcome);
  }

  SimulationReport report() {
    final totalTrials = config.trialCount;
    final totalAttempts = outcomes.length;
    final successfulTrials =
        outcomes.where((o) => o.reachedUpgradeTarget).length;
    final destroyedTrials =
        outcomes.where((o) => o.result == UpgradeResult.failDestroy).length;
    final totalCost = outcomes.fold(0.0, (a, b) => a + b.upgradeCost);
    final avgCostPerAttempt = totalCost / totalAttempts;
    final avgCostPerSuccess = totalCost / successfulTrials;
    final destructionRate = destroyedTrials / totalTrials;

    return SimulationReport(
      totalTrials: totalTrials,
      successfulTrials: successfulTrials,
      destroyedTrials: destroyedTrials,
      averageCostPerAttempt: avgCostPerAttempt,
      averageCostPerSuccess: avgCostPerSuccess,
      destructionRate: destructionRate,
    );
  }
}
