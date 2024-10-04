import '../models/probability_tables.dart';

class ProbabilityProvider {
  static final ProbabilityTable _table = ProbabilityTable();

  static Future<void> ensureDataLoaded(String filePath) async {
    try {
      if (_table.successRates.isEmpty) {
        await _table.loadProbabilities(filePath);
      }
    } catch (e) {
      print('Failed to load probability data: $e');
      throw e; // Re-throw the exception to handle it further up the call stack.
    }
  }

  static void printTables() {
    print("${_table.successRates}\n");
    print("${_table.failMaintainRates}\n");
    print("${_table.failDecreaseRates}\n");
    print("${_table.failDestroyRates}\n");
  }

  static double getSuccessRate(
    int star,
    bool pityEnabled,
    int consecutiveFailures,
    bool eventEnabled,
  ) {
    double successRate = _table.getSuccessRate(star);

    if (eventEnabled && (star == 5 || star == 10 || star == 15)) {
      successRate = 1.00; // 100% success rate for these special events
    }
    if (pityEnabled && consecutiveFailures >= 2) {
      successRate = 1.00; // Pity system guarantees success
    }
    return successRate;
  }

  static double getFailMaintainRate(int star) =>
      _table.getFailMaintainRate(star);

  static double getFailDecreaseRate(int star) =>
      _table.getFailDecreaseRate(star);

  static double getFailDestroyRate(int star, bool safeguardEnabled) {
    return safeguardEnabled && (star == 15 || star == 16)
        ? 0.0
        : _table.getFailDestroyRate(star);
  }
}
