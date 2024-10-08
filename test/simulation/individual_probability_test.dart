import 'package:starforce_sim_flutter/models/upgrade_result.dart';
import 'package:starforce_sim_flutter/simulation/simulation_config.dart';
import 'package:starforce_sim_flutter/simulation/simulator.dart';
import 'package:test/test.dart';

void main() {
  group('Testing individual Probabilities: success, maintain, decrease', () {
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

    // Test FailDecrease Rate
    test('FailDecrease rate should match expected rates', () async {
      const trialCount = 10000;
      const tolerance = 0.05; // 5% multiplicative tolerance

      // Loop through each upgrade step
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

        // Define expected failDecrease rates for each step from 0★ → 25★
        final expectedFailDecreaseRate =
            simulator.probabilityProvider.getFailDecreaseRate();
        final delta = expectedFailDecreaseRate * tolerance;

        // Run the simulation
        var simOutcome = simulator.runSimulation();

        // Filter outcomes that started from the initial star
        var filteredOutcomes = simOutcome.outcomes
            .where((o) => o.initialStar == currentStar)
            .toList();

        var size = filteredOutcomes.length;
        var failDecrease = filteredOutcomes
            .where((o) => o.result == UpgradeResult.failDecrease)
            .length;

        double actualFailDecreaseRate = failDecrease.toDouble() / size;

        // Assert that the failDecrease rate is close to the expected rate
        expect(actualFailDecreaseRate, closeTo(expectedFailDecreaseRate, delta),
            reason: '''
          Upgrade from $currentStar★ → $targetStar★ failed the decrease rate check.
          Expected failDecrease rate: $expectedFailDecreaseRate, 
          Actual: $actualFailDecreaseRate.
          ''');
      }
    });
    // Test FailMaintain Rate
    test('FailMaintain rate should match expected rates', () async {
      const trialCount = 10000;
      const tolerance = 0.05; // 5% multiplicative tolerance

      // Loop through each upgrade step
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

        final expectedFailMaintainRate =
            simulator.probabilityProvider.getFailMaintainRate();
        final delta = expectedFailMaintainRate * tolerance;

        // Run the simulation
        var simOutcome = simulator.runSimulation();

        // Filter outcomes that started from the initial star
        var filteredOutcomes = simOutcome.outcomes
            .where((o) => o.initialStar == currentStar)
            .toList();

        var size = filteredOutcomes.length;
        var failMaintain = filteredOutcomes
            .where((o) => o.result == UpgradeResult.failMaintain)
            .length;

        double actualFailMaintainRate = failMaintain.toDouble() / size;

        // Assert that the failMaintain rate is close to the expected rate
        expect(actualFailMaintainRate, closeTo(expectedFailMaintainRate, delta),
            reason: '''
          Upgrade from $currentStar★ → $targetStar★ failed the maintain rate check.
          Expected failMaintain rate: $expectedFailMaintainRate, 
          Actual: $actualFailMaintainRate.
          ''');
      }
    });
  });
}
