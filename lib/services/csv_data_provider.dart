import 'dart:io';
import 'package:csv/csv.dart';
import 'dart:convert';

class CSVDataProvider {
  static Future<List<List<dynamic>>> readCSV(String filePath) async {
    final input = File(filePath).openRead();
    return await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
  }
}
