import 'package:starforce_sim/models/upgrade_result.dart';
import 'package:starforce_sim/simulation/simulation_config.dart';
import 'package:test/test.dart';
import 'package:starforce_sim/simulation/simulator.dart';

void main() {
  group('Destruction Probability and Safeguard tests', () {
    test('Destruction probability and success rate with and without safeguard',
        () async {
      const trialCount = 10000;
      const initialStar = 15; // A star level where destruction is possible
      const targetStar = 16;
      const tolerance = 0.05; // 5% multiplicative tolerance
      final expectedDestructionRateWithoutSafeguard =
          0.021; // Based on destruction rate for this star
      final expectedSuccessRate = 0.30; // Based on success rate for this star

      // Test without safeguard
      final configWithoutSafeguard = SimulationConfig(
        trialCount: trialCount,
        initialStar: initialStar,
        targetStar: targetStar,
        safeguardEnabled: false, // No safeguard
        probabilityDataFilePath: "./data/probability_table.csv",
      );
      var simulatorWithoutSafeguard =
          await Simulator.create(config: configWithoutSafeguard);
      var simOutcomeWithoutSafeguard =
          simulatorWithoutSafeguard.runSimulation();

      // Filter outcomes that started from the initial star
      var filteredOutcomesWithoutSafeguard = simOutcomeWithoutSafeguard.outcomes
          .where((o) => o.initialStar == initialStar);

      var sizeWithoutSafeguard = filteredOutcomesWithoutSafeguard.length;
      var destructionWithoutSafeguard = filteredOutcomesWithoutSafeguard
          .where((o) => o.result == UpgradeResult.failDestroy)
          .length;
      var successWithoutSafeguard = filteredOutcomesWithoutSafeguard
          .where((o) => o.result == UpgradeResult.success)
          .length;

      double actualDestructionRateWithoutSafeguard =
          destructionWithoutSafeguard.toDouble() / sizeWithoutSafeguard;
      double actualSuccessRateWithoutSafeguard =
          successWithoutSafeguard.toDouble() / sizeWithoutSafeguard;

      // Assert that the destruction rate without safeguard matches the expected rate within 5% multiplicative tolerance
      expect(
        actualDestructionRateWithoutSafeguard,
        closeTo(expectedDestructionRateWithoutSafeguard,
            expectedDestructionRateWithoutSafeguard * tolerance),
        reason: '''
        Statistical anomaly detected.  
        Expected destruction rate without safeguard: $expectedDestructionRateWithoutSafeguard, 
        Actual destruction rate: $actualDestructionRateWithoutSafeguard, 
        Trials: $sizeWithoutSafeguard.
        ''',
      );

      expect(
        actualSuccessRateWithoutSafeguard,
        closeTo(expectedSuccessRate, expectedSuccessRate * tolerance),
        reason: '''
        Statistical anomaly detected. 
        Expected success rate: $expectedSuccessRate, 
        Actual success rate: $actualSuccessRateWithoutSafeguard, 
        Trials: $sizeWithoutSafeguard.
        ''',
      );

      // Test with safeguard
      final configWithSafeguard = SimulationConfig(
        trialCount: trialCount,
        initialStar: initialStar,
        targetStar: targetStar,
        safeguardEnabled: true, // Safeguard enabled
        probabilityDataFilePath: "./data/probability_table.csv",
      );
      var simulatorWithSafeguard =
          await Simulator.create(config: configWithSafeguard);
      var simOutcomeWithSafeguard = simulatorWithSafeguard.runSimulation();

      // Filter outcomes that started from the initial star
      var filteredOutcomesWithSafeguard = simOutcomeWithSafeguard.outcomes
          .where((o) => o.initialStar == initialStar);

      var sizeWithSafeguard = filteredOutcomesWithSafeguard.length;
      var destructionWithSafeguard = filteredOutcomesWithSafeguard
          .where((o) => o.result == UpgradeResult.failDestroy)
          .length;
      var successWithSafeguard = filteredOutcomesWithSafeguard
          .where((o) => o.result == UpgradeResult.success)
          .length;

      double actualDestructionRateWithSafeguard =
          destructionWithSafeguard.toDouble() / sizeWithSafeguard;
      double actualSuccessRateWithSafeguard =
          successWithSafeguard.toDouble() / sizeWithSafeguard;

      // Assert that no destruction occurred when safeguard was on
      expect(
        actualDestructionRateWithSafeguard,
        equals(0.0),
        reason: '''
        Upgrade from $initialStar★ to $targetStar★ with safeguard should not have resulted in destruction. 
        Actual destruction rate: $actualDestructionRateWithSafeguard.
        Trials: $sizeWithSafeguard.
        ''',
      );

      // Assert that the success rate with safeguard matches the expected rate within 5% multiplicative tolerance
      expect(
        actualSuccessRateWithSafeguard,
        closeTo(expectedSuccessRate, expectedSuccessRate * tolerance),
        reason: '''
        Statistical anomaly detected. 
        Expected success rate: $expectedSuccessRate, 
        Actual success rate: $actualSuccessRateWithSafeguard, 
        Trials: $sizeWithSafeguard.
        ''',
      );
    });
  });
}
