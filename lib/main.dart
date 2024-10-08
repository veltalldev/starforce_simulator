import 'package:starforce_sim_flutter/simulation/simulation_config.dart';
import 'package:starforce_sim_flutter/simulation/simulator.dart';

void main() async {
  final config = SimulationConfig(
    pityEnabled: true,
    safeguardEnabled: true,
    event51015: true,
    event30: true,
    // mesoBudget: 50 * 1e9,
    equipmentLevel: 200,
    initialStar: 15,
    targetStar: 22,
    trialCount: 10000,
  );

  // Wait for the simulator to be created with all async loading complete
  final simulator = await Simulator.create(config: config);
  final result = simulator.runSimulation();

  result.report().toMap().entries.forEach((r) {
    print(r);
  });
}
