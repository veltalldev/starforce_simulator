import 'package:starforce_sim/models/upgrade_result.dart';
import 'package:starforce_sim/simulation/simulation_config.dart';
import 'package:test/test.dart';
import 'package:starforce_sim/simulation/simulator.dart';

void main() {
  group('Sequential One-Step Upgrade tests', () {
    test(
        'One-step upgrades from 0★ → 25★ should match expected success rates with relative tolerance',
        () async {
      const trialCount = 100000;
      const tolerance = 0.05; // 5% relative tolerance

      // Loop through each one-step upgrade from 0★ to 24★ to 25★
      for (int currentStar = 0; currentStar < 25; currentStar++) {
        final targetStar = currentStar + 1;

        // Create a Simulator instance with necessary configuration
        final config = SimulationConfig(
          trialCount: trialCount,
          initialStar: currentStar,
          targetStar: targetStar,
          probabilityDataFilePath: "./data/probability_table.csv",
        );
        var simulator = await Simulator.create(config: config);

        final expectedSuccessRate =
            simulator.probabilityProvider.getSuccessRate();
        final delta = expectedSuccessRate * tolerance;

        // Run trials and track outcomes
        var simOutcome = simulator.runSimulation();
        var filteredOutcomes =
            simOutcome.outcomes.where((o) => o.initialStar == currentStar);
        var size = filteredOutcomes.length;
        var success = filteredOutcomes
            .where((o) => o.result == UpgradeResult.success)
            .length;

        double actualSuccessRate = success.toDouble() / size;

        // Assert that the actual success rate is within the relative tolerance (delta)
        expect(
          actualSuccessRate,
          closeTo(expectedSuccessRate, delta),
          reason: '''
          Upgrade from $currentStar★ to $targetStar★ failed.
          Expected success rate: $expectedSuccessRate
          Actual success rate: $actualSuccessRate
          Number of trials: $size
          ''',
        );
      }
    });
  });
}
