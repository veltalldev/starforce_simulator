import 'package:starforce_sim_flutter/simulation/simulator.dart';
import 'package:starforce_sim_flutter/simulation/simulation_config.dart';
import 'package:starforce_sim_flutter/models/upgrade_result.dart';
import 'package:starforce_sim_flutter/utils/export_helpers.dart';

void main() async {
  const int trialCount = 10000;
  const int equipLevel = 200;
  const int initialStar = 12;
  const int targetStar = 22;
  const int mesoLimit = 50000000000; // 50b meso limit

  // Variables to tally results
  int trialsBelowCap = 0;
  List<double> mesoSpentList = [];
  List<int> destructionsList = [];

  for (int i = 0; i < trialCount; i++) {
    // Set up simulation config
    final config = SimulationConfig(
      trialCount: 1, // One trial at a time
      initialStar: initialStar,
      targetStar: targetStar,
      equipmentLevel: equipLevel,
      probabilityDataFilePath: './data/probability_table.csv',
    );

    // Create the simulator
    final simulator = await Simulator.create(config: config);
    final result = simulator.runSimulation(); // Run the simulation

    double mesoSpent = 0;
    int destructions = 0;

    // Tally results for each outcome in the trial
    for (var outcome in result.outcomes) {
      mesoSpent += outcome.upgradeCost;
      if (outcome.result == UpgradeResult.failDestroy) {
        destructions++;
      }
    }

    mesoSpentList.add(mesoSpent);
    destructionsList.add(destructions);

    if (mesoSpent <= mesoLimit) {
      trialsBelowCap++;
    }
  }

  // Calculate percentage of successful trials within meso cap
  double successWithinCapPercentage = trialsBelowCap / trialCount;

  // Export results for further analysis
  Map<String, List<num>> data = {
    'Meso Spent': mesoSpentList,
    'Destructions': destructionsList,
  };

  var filePath = 'lib/reports/documents/meso-equip-cost_data.csv';
  export_csv(
    data,
    filePath,
  );

  // Print results
  print('Success within cap: $successWithinCapPercentage');
}
