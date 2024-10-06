import 'package:starforce_sim/simulation/simulation_config.dart';
import 'package:test/test.dart';
import '../lib/simulation/simulator.dart';
import '../lib/models/upgrade_result.dart';

void main() {
  group('Upgrade Probability Tests', () {
    test('0★ → 1★ upgrade success rate should match 95%', () async {
      // Create a Simulator instance with necessary configuration (e.g., trial count)
      var config =
          SimulationConfig(trialCount: 1000); // Customize the config as needed
      var simulator = await Simulator.create(config: config);

      int successCount = 0;
      int trials = 1000;
      double expectedSuccessRate = 0.95;

      // Run trials and track success count
      for (int i = 0; i < trials; i++) {
        var result = simulator.runSimulation(); // Simulate one upgrade trial
        if (result.upgradeResult == UpgradeResult.success) {
          successCount++;
        }
        simulator.state.resetState(); // Reset state between trials
      }

      double actualSuccessRate = successCount / trials;
      expect(
          actualSuccessRate, closeTo(expectedSuccessRate, 0.02)); // ±2% margin
    });
  });
}
