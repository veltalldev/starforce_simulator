import 'package:starforce_sim/models/upgrade_result.dart';
import 'package:starforce_sim/simulation/simulation_config.dart';
import 'package:test/test.dart';
import 'package:starforce_sim/simulation/simulator.dart';

void main() {
  group('Upgrade Probability Tests', () {
    test('0★ → 1★ upgrade success rate should match 95%', () async {
      // Create a Simulator instance with necessary configuration (e.g., trial count)
      final config = SimulationConfig(
        trialCount: 1000,
        initialStar: 0,
        targetStar: 1,
        probabilityDataFilePath: "./data/probability_table.csv",
      );
      var simulator = await Simulator.create(config: config);

      double expectedSuccessRate = 0.95;

      // Run trials and track outcomes
      var simOutcome = simulator.runSimulation();
      var size = simOutcome.outcomes.length;
      var success = simOutcome.outcomes
          .where((o) => o.result == UpgradeResult.success)
          .length;

      print("size = $size");
      print("sucess = $success");

      double actualSuccessRate = success.toDouble() / size;
      print("actual: $actualSuccessRate");
      print("expected: $expectedSuccessRate");
      expect(
        actualSuccessRate,
        closeTo(expectedSuccessRate, 0.02),
      ); // ±2% margin
    });
  });
}
