import 'package:starforce_sim_flutter/models/upgrade_result.dart';
import 'package:starforce_sim_flutter/simulation/simulation_config.dart';
import 'package:starforce_sim_flutter/simulation/simulator.dart';
import 'package:test/test.dart';

void main() {
  group('Pity System Activation tests', () {
    test(
        'Pity system activates correctly after two consecutive failDecrease outcomes',
        () async {
      const trialCount = 10000;
      const initialStar = 15; // Star level where Pity System could be active
      const targetStar = 20;

      // Create a Simulator instance with necessary configuration
      final config = SimulationConfig(
        trialCount: trialCount,
        initialStar: initialStar,
        targetStar: targetStar,
        safeguardEnabled: false, // Pity system doesn't involve safeguard
        probabilityDataFilePath: "./data/probability_table.csv",
      );
      var simulator = await Simulator.create(config: config);
      var simOutcome = simulator.runSimulation();

      // Filter outcomes that started from the initial star
      var filteredOutcomes = simOutcome.outcomes
          .where((o) => o.initialStar == initialStar)
          .toList();

      int pityActivations = 0;
      int expectedPityActivations = 0;

      // Iterate through the outcome list and check for Pity System activations
      for (int i = 2; i < filteredOutcomes.length; i++) {
        // Check if two consecutive failDecrease outcomes occurred
        if (filteredOutcomes[i - 2].result == UpgradeResult.failDecrease &&
            filteredOutcomes[i - 1].result == UpgradeResult.failDecrease) {
          expectedPityActivations++;

          // The third outcome should be success (Pity activation)
          if (filteredOutcomes[i].result == UpgradeResult.success) {
            pityActivations++;
          } else {
            fail(
                'Pity system failed at index $i. Expected success but got ${filteredOutcomes[i].result}');
          }
        }
      }

      // Assert that the expected number of pity activations matches the actual number
      expect(pityActivations, equals(expectedPityActivations),
          reason:
              'Expected $expectedPityActivations Pity System activations but found $pityActivations.');
    });
  });
}
