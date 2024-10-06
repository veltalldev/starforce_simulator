import 'package:starforce_sim/simulation/simulation_config.dart';
import 'package:starforce_sim/simulation/simulation_state.dart';

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
  late final int star;
  late final bool reachedUpgradeTarget;
  double upgradeCost = 0.0;

  UpgradeOutcome({
    required this.result,
    required this.state,
    required this.config,
  }) {
    star = state.getCurrentStar();
    reachedUpgradeTarget = star == config.targetStar;
  }

  void updateCost(double upgradeCost) {
    upgradeCost = upgradeCost;
  }
}
