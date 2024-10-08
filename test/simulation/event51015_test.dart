import 'package:starforce_sim/models/upgrade_result.dart';
import 'package:starforce_sim/simulation/simulation_config.dart';
import 'package:test/test.dart';
import 'package:starforce_sim/simulation/simulator.dart';

void main() {
  group('5/10/15 Event Boost Tests', () {
    test(
        'Success rate should be 100% during 5/10/15 event for upgrades 5★ → 6★, 10★ → 11★, 15★ → 16★',
        () async {
      const trialCount = 10000;
      const tolerance = 0.0; // No tolerance, should be exactly 100% success

      // List of event-specific upgrades to test: 5★ → 6★, 10★ → 11★, 15★ → 16★
      final eventUpgrades = [
        {'initialStar': 5, 'targetStar': 6},
        {'initialStar': 10, 'targetStar': 11},
        {'initialStar': 15, 'targetStar': 16},
      ];

      for (var upgrade in eventUpgrades) {
        final initialStar = upgrade['initialStar']!;
        final targetStar = upgrade['targetStar']!;

        // Create a Simulator instance with the 5/10/15 event active
        final config = SimulationConfig(
          trialCount: trialCount,
          initialStar: initialStar,
          targetStar: targetStar,
          event51015: true, // Enable the event boost
          probabilityDataFilePath: "./data/probability_table.csv",
        );
        var simulator = await Simulator.create(config: config);

        // Run the simulation
        var simOutcome = simulator.runSimulation();

        // Filter outcomes that started from the initial star
        var filteredOutcomes = simOutcome.outcomes
            .where((o) => o.initialStar == initialStar)
            .toList();

        var size = filteredOutcomes.length;
        var success = filteredOutcomes
            .where((o) => o.result == UpgradeResult.success)
            .length;

        double actualSuccessRate = success.toDouble() / size;

        // Assert that the success rate is exactly 100% during the 5/10/15 event
        expect(actualSuccessRate, closeTo(1.0, tolerance), // 100% success rate
            reason: '''
          Expected 100% success rate for $initialStar★ → $targetStar★ during the 5/10/15 event, 
          but got $actualSuccessRate success rate. Trials: $size.
          ''');

        // Assert that no downgrade or destruction occurred
        var downgradeOrDestruction = filteredOutcomes
            .where((o) =>
                o.result == UpgradeResult.failDecrease ||
                o.result == UpgradeResult.failDestroy)
            .isNotEmpty;

        expect(downgradeOrDestruction, isFalse,
            reason:
                'There should be no downgrade or destruction during $initialStar★ → $targetStar★ upgrades with 5/10/15 event active.');
      }
    });
  });
}
