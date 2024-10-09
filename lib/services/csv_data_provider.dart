import 'package:csv/csv.dart';

import 'package:flutter/services.dart';

class CSVDataProvider {
  static Future<List<List<dynamic>>> readCSV(String filePath) async {
    final csvString =
        await rootBundle.loadString('data/starcatch_probability_table.csv');
    final csvData = const CsvToListConverter().convert(csvString);

    return csvData;
  }
}
