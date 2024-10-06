import '../services/csv_data_provider.dart';

class ProbabilityTable {
  List<double> successRates = [];
  List<double> failMaintainRates = [];
  List<double> failDecreaseRates = [];
  List<double> failDestroyRates = [];

  Future<void> loadProbabilities(String filePath) async {
    List<List<dynamic>> data = await CSVDataProvider.readCSV(filePath);
    // Assuming the first row is headers and subsequent rows follow the order: star, success, maintain, decrease, destroy
    for (int i = 1; i < data.length; i++) {
      // Convert and store as double immediately
      successRates.add(double.parse(data[i][1].toString()));
      failMaintainRates.add(double.parse(data[i][2].toString()));
      failDecreaseRates.add(double.parse(data[i][3].toString()));
      failDestroyRates.add(double.parse(data[i][4].toString()));
    }
  }

  double getSuccessRate(int star) {
    return star < successRates.length ? successRates[star] : 0.0;
  }

  double getFailMaintainRate(int star) {
    return star < failMaintainRates.length ? failMaintainRates[star] : 0.0;
  }

  double getFailDecreaseRate(int star) {
    return star < failDecreaseRates.length ? failDecreaseRates[star] : 0.0;
  }

  double getFailDestroyRate(int star) {
    return star < failDestroyRates.length ? failDestroyRates[star] : 0.0;
  }
}
