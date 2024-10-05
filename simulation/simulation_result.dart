class SimulationResult {
  final int totalTrials;
  final int successfulTrials;
  final int destroyedTrials;
  final double averageCostPerAttempt;
  final double averageCostPerSuccess;
  final double destructionRate;

  SimulationResult({
    required this.totalTrials,
    required this.successfulTrials,
    required this.destroyedTrials,
    required this.averageCostPerAttempt,
    required this.averageCostPerSuccess,
    required this.destructionRate,
  });

  // Convert the result into a map for easier display or further usage
  Map<String, dynamic> toMap() {
    return {
      'totalTrials': totalTrials,
      'successfulTrials': successfulTrials,
      'destroyedTrials': destroyedTrials,
      'averageCostPerAttempt': averageCostPerAttempt,
      'averageCostPerSuccess': averageCostPerSuccess,
      'destructionRate': destructionRate,
    };
  }

  @override
  String toString() {
    return 'Total Trials: $totalTrials\n'
        'Successful Trials: $successfulTrials\n'
        'Destroyed Trials: $destroyedTrials\n'
        'Average Cost Per Attempt: ${averageCostPerAttempt}b\n'
        'Average Cost Per Success: ${averageCostPerSuccess}b\n'
        'Destruction Rate: $destructionRate%';
  }
}
