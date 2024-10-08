import 'package:starforce_sim_flutter/simulation/simulation_config.dart';
import 'package:starforce_sim_flutter/simulation/simulation_state.dart';

import '../models/probability_tables.dart';

class ProbabilityProvider {
  final ProbabilityTable _table;
  final SimulationConfig config;
  final SimulationState state;

  ProbabilityProvider._(this._table, this.config, this.state);

  static Future<ProbabilityProvider> createProvider(
    SimulationConfig config,
    SimulationState state,
  ) async {
    final filePath = config.probabilityDataFilePath;
    final table = ProbabilityTable();
    await table.loadProbabilities(filePath);
    return ProbabilityProvider._(table, config, state);
  }

  double getSuccessRate() {
    final star = state.getCurrentStar();

    if (state.isEvent51015Active() || state.isPityActive()) {
      return 1.00; // 100% success rate for these special states
    }
    return _table.getSuccessRate(star);
  }

  double getFailMaintainRate() =>
      _table.getFailMaintainRate(state.getCurrentStar());

  double getFailDecreaseRate() =>
      _table.getFailDecreaseRate(state.getCurrentStar());

  double getFailDestroyRate() {
    final star = state.getCurrentStar();
    final destroyRate = _table.getFailDestroyRate(star);
    return state.isSafeguardActive() ? 0.0 : destroyRate;
  }
}
