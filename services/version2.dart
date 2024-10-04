import 'dart:math';

class UpgradeSimulator {
  final List<Map<String, double>> referenceTable;

  UpgradeSimulator(this.referenceTable);

  void simulateUpgrade(int trials, int initialStars, int targetStars) {
    int successes = 0;
    int failures = 0;
    double totalCost = 0.0;

    for (int i = 0; i < trials; i++) {
      var result = upgrade(initialStars, targetStars);
      if (result['success']) {
        successes++;
      } else {
        failures++;
      }
      totalCost += result['cost'];
    }

    double averageCost = totalCost / trials;
    double successRate = (successes / trials) * 100;

    print('Successes: $successes');
    print('Failures: $failures');
    print('Average Cost per Trial: $averageCost');
    print('Success Rate: $successRate%');
  }

  Map<String, dynamic> upgrade(int initialStars, int targetStars) {
    if (initialStars >= targetStars) {
      return {'success': false, 'cost': 0.0}; // No upgrade needed
    }

    int index = initialStars; // Adjust based on your data structure
    if (index >= referenceTable.length) {
      throw Exception('Invalid star level.');
    }

    double successRate = referenceTable[index]['Starcatching Success (%)']!;
    double failMaintainRate =
        referenceTable[index]['Starcatching Fail (Maintain) (%)']!;
    double failDecreaseRate =
        referenceTable[index]['Starcatching Fail (Decrease) (%)']!;
    double failDestroyRate =
        referenceTable[index]['Starcatching Fail (Destroy) (%)']!;

    double randomValue = Random().nextDouble() * 100;

    if (randomValue < successRate) {
      return {'success': true, 'cost': calculateCost(initialStars)};
    } else if (randomValue < (successRate + failMaintainRate)) {
      return {'success': false, 'cost': calculateCost(initialStars)};
    } else if (randomValue <
        (successRate + failMaintainRate + failDecreaseRate)) {
      return {'success': false, 'cost': calculateCost(initialStars)};
    } else {
      return {'success': false, 'cost': calculateCost(initialStars)};
    }
  }

  double calculateCost(int stars) {
    // Define the cost structure based on stars
    // Implement logic to return the cost associated with the upgrade
    return stars * 1000; // Example cost structure
  }
}

void main() {
  List<Map<String, double>> referenceTable = [
    {
      'Starcatching Success (%)': 99.75,
      'Starcatching Fail (Maintain) (%)': 0.25,
      'Starcatching Fail (Decrease) (%)': 0,
      'Starcatching Fail (Destroy) (%)': 0
    },
    {
      'Starcatching Success (%)': 94.50,
      'Starcatching Fail (Maintain) (%)': 5.50,
      'Starcatching Fail (Decrease) (%)': 0,
      'Starcatching Fail (Destroy) (%)': 0
    },
    // ... continue for all rows up to 24★ → 25★
  ];

  UpgradeSimulator simulator = UpgradeSimulator(referenceTable);
  simulator.simulateUpgrade(1000, 0, 25);
}
