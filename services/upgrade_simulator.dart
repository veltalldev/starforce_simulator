import 'dart:math';

class EquipmentUpgradeSimulator {
  final int equipmentLevel;
  final int trialSize;
  final int initialStar;
  final int targetStar;

  // Constructor with default equipment level
  EquipmentUpgradeSimulator({
    this.equipmentLevel = 150, // Default value
    required this.trialSize,
    required this.initialStar,
    required this.targetStar,
  });

  // Function to simulate the probability of upgrading at a given star level
  Map<String, double> getUpgradeProbabilities(int currentStar) {
    // Define the probabilities for each star level
    const probabilitiesTable = {
      0: {
        'success': 0.95,
        'failMaintain': 0.05,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      1: {
        'success': 0.90,
        'failMaintain': 0.10,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      2: {
        'success': 0.85,
        'failMaintain': 0.15,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      3: {
        'success': 0.85,
        'failMaintain': 0.15,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      4: {
        'success': 0.80,
        'failMaintain': 0.20,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      5: {
        'success': 0.75,
        'failMaintain': 0.25,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      6: {
        'success': 0.70,
        'failMaintain': 0.30,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      7: {
        'success': 0.65,
        'failMaintain': 0.35,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      8: {
        'success': 0.60,
        'failMaintain': 0.40,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      9: {
        'success': 0.55,
        'failMaintain': 0.45,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      10: {
        'success': 0.50,
        'failMaintain': 0.50,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      11: {
        'success': 0.45,
        'failMaintain': 0.55,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      12: {
        'success': 0.40,
        'failMaintain': 0.60,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      13: {
        'success': 0.35,
        'failMaintain': 0.65,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      14: {
        'success': 0.30,
        'failMaintain': 0.70,
        'failDecrease': 0.0,
        'destroy': 0.0
      },
      15: {
        'success': 0.30,
        'failMaintain': 0.679,
        'failDecrease': 0.0,
        'destroy': 0.021
      },
      16: {
        'success': 0.30,
        'failMaintain': 0.679,
        'failDecrease': 0.0,
        'destroy': 0.021
      },
      17: {
        'success': 0.30,
        'failMaintain': 0.679,
        'failDecrease': 0.0,
        'destroy': 0.021
      },
      18: {
        'success': 0.30,
        'failMaintain': 0.672,
        'failDecrease': 0.0,
        'destroy': 0.028
      },
      19: {
        'success': 0.30,
        'failMaintain': 0.672,
        'failDecrease': 0.0,
        'destroy': 0.028
      },
      20: {
        'success': 0.30,
        'failMaintain': 0.63,
        'failDecrease': 0.0,
        'destroy': 0.07
      },
      21: {
        'success': 0.30,
        'failMaintain': 0.63,
        'failDecrease': 0.0,
        'destroy': 0.07
      },
      22: {
        'success': 0.03,
        'failMaintain': 0.776,
        'failDecrease': 0.0,
        'destroy': 0.194
      },
      23: {
        'success': 0.02,
        'failMaintain': 0.686,
        'failDecrease': 0.0,
        'destroy': 0.294
      },
      24: {
        'success': 0.01,
        'failMaintain': 0.594,
        'failDecrease': 0.0,
        'destroy': 0.396
      },
    };

    // Return the probabilities for the current star level
    return probabilitiesTable[currentStar] ??
        {
          'success': 0.0,
          'failMaintain': 0.0,
          'failDecrease': 0.0,
          'destroy': 0.0
        };
  }

  // Function to calculate the resource cost for upgrading based on the star level
  int calculateUpgradeCost(int currentStar) {
    // Formula based on star level
    const resourceCostFactor = {
      0: 2500,
      1: 2500,
      2: 2500,
      3: 2500,
      4: 2500,
      5: 2500,
      6: 2500,
      7: 2500,
      8: 2500,
      9: 2500,
      10: 40000,
      11: 22000,
      12: 15000,
      13: 11000,
      14: 7500,
      15: 20000,
      16: 20000,
      17: 20000,
      18: 20000,
      19: 20000,
      20: 20000,
      21: 20000,
      22: 20000,
      23: 20000,
      24: 20000,
    };

    // Calculate cost based on equipment level and star level
    return (100 *
            ((pow(equipmentLevel, 3) * pow(currentStar + 1, 2.7)) /
                    resourceCostFactor[currentStar]! +
                10))
        .round();
  }

  // Function to simulate a single upgrade attempt
  Map<String, dynamic> simulateUpgrade(int currentStar) {
    var probabilities = getUpgradeProbabilities(currentStar);

    // Perform random roll to determine outcome
    double roll = Random().nextDouble();
    if (roll <= probabilities['success']!) {
      return {'result': 'success', 'newStar': currentStar + 1};
    } else if (roll <=
        probabilities['success']! + probabilities['failMaintain']!) {
      return {'result': 'failMaintain', 'newStar': currentStar};
    } else if (roll <=
        probabilities['success']! +
            probabilities['failMaintain']! +
            probabilities['failDecrease']!) {
      return {'result': 'failDecrease', 'newStar': max(0, currentStar - 1)};
    } else {
      return {'result': 'destroy', 'newStar': 0}; // Destruction resets stars
    }
  }

  // Function to run the entire simulation across multiple trials
  void runSimulation() {
    int successes = 0;
    int destructions = 0;
    int totalCost = 0;

    for (int trial = 0; trial < trialSize; trial++) {
      int currentStar = initialStar;
      int costForTrial = 0;

      while (currentStar < targetStar) {
        var result = simulateUpgrade(currentStar);
        currentStar = result['newStar'];
        costForTrial += calculateUpgradeCost(currentStar);

        if (currentStar == targetStar) {
          successes++; // Count as success only when target star is reached
          break; // Stop the trial when the target is reached
        }

        if (result['result'] == 'destroy') {
          destructions++;
          break; // Stop the trial if the item is destroyed
        }
      }

      totalCost += costForTrial;
    }

    // After the loop, calculate the average cost per success
    double averageCostPerSuccess = successes > 0 ? totalCost / successes : 0;
    double averageCostPerSuccessInBillions = averageCostPerSuccess / 1e9;

    // Calculate the average cost per trial
    double averageCost = totalCost / trialSize;

    // Convert average cost to billions for display purposes
    double averageCostInBillions = averageCost / 1e9;

    // Calculate the average cost per success (handle the case where successes == 0)

    // Output the statistics
    print('Total successes: $successes');
    print('Total destructions: $destructions');
    print(
        'Average cost per trial: ${averageCostInBillions.toStringAsFixed(2)} billion');
// Print the new metric
    print(
        'Average cost per success: ${averageCostPerSuccessInBillions.toStringAsFixed(2)} billion');
  }
}

void main() {
  // Create the simulator instance with the desired input parameters
  EquipmentUpgradeSimulator simulator = EquipmentUpgradeSimulator(
    trialSize: 1000, // Number of trials to run
    initialStar: 20, // Starting star level
    targetStar: 22, // Target star level
  );

  // Run the simulation
  simulator.runSimulation();
}
