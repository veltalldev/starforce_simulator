import 'package:starforce_sim_flutter/simulation/simulation_config.dart';
import 'package:starforce_sim_flutter/simulation/simulation_state.dart';

enum UpgradeResult {
  success,
  failMaintain,
  failDecrease,
  failDestroy,
}

class UpgradeOutcome {
  final UpgradeResult result;
  final SimulationState state;
  final SimulationConfig config;
  late final int targetStar;
  late final int initialStar;
  late final bool reachedUpgradeTarget;
  double upgradeCost = 0.0;

  UpgradeOutcome({
    required this.result,
    required this.state,
    required this.config,
    required this.initialStar,
  }) {
    targetStar = state.getCurrentStar();
    reachedUpgradeTarget = targetStar == config.targetStar;
  }

  void updateCost(double cost) {
    upgradeCost += cost;
  }
}
