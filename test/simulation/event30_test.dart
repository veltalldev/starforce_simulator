import 'package:starforce_sim_flutter/simulation/simulation_config.dart';
import 'package:starforce_sim_flutter/simulation/simulator.dart';
import 'package:test/test.dart';

void main() {
  group('Event30 Full Path Cost Tests', () {
    test(
        'Total upgrade cost should be reduced by 30% during Event30 (0★ → 22★)',
        () async {
      const trialCount = 1000;
      const initialStar = 0;
      const targetStar = 22;
      const tolerance = 0.05; // 5% multiplicative tolerance
      final equipLevel = 150; // Example equipment level

      // Helper to run the simulation and accumulate total costs
      Future<double> runSimulationAndCalculateTotalCost(
          bool event30Active) async {
        double totalCost = 0.0;

        // Loop through the stars from 0★ to 22★
        for (int currentStar = initialStar;
            currentStar < targetStar;
            currentStar++) {
          final config = SimulationConfig(
            equipmentLevel: equipLevel,
            trialCount: trialCount,
            initialStar: currentStar,
            targetStar: currentStar + 1, // One star step at a time
            event30: event30Active, // Apply event30 if true
            probabilityDataFilePath: "./data/probability_table.csv",
          );
          var simulator = await Simulator.create(config: config);
          var simOutcome = simulator.runSimulation();

          // Accumulate costs from each step
          for (var outcome in simOutcome.outcomes) {
            totalCost += outcome.upgradeCost;
          }
        }
        return totalCost;
      }

      // Run the simulation without the event
      var totalCostWithoutEvent =
          await runSimulationAndCalculateTotalCost(false);

      // Run the simulation with the event30 enabled
      var totalCostWithEvent = await runSimulationAndCalculateTotalCost(true);

      // Calculate the expected cost with event30 (30% discount)
      var expectedCostWithEvent = totalCostWithoutEvent * 0.7;

      // Assert that the actual cost with event30 is close to the expected cost (5% tolerance)
      expect(totalCostWithEvent.toDouble(),
          closeTo(expectedCostWithEvent, expectedCostWithEvent * tolerance),
          reason: '''
        Total upgrade cost with Event30 did not match expected discounted cost.
        Without Event: $totalCostWithoutEvent, 
        With Event: $totalCostWithEvent, 
        Expected: $expectedCostWithEvent.
        ''');
    });
  });
}
