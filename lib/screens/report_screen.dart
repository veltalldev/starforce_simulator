import 'package:flutter/material.dart';
import '../simulation/simulation_outcome.dart'; // Import the outcome class

class ReportScreen extends StatelessWidget {
  final SimulationOutcome outcome;

  // Constructor with super.key for consistency
  const ReportScreen({super.key, required this.outcome});

  @override
  Widget build(BuildContext context) {
    final report = outcome.report(); // Get the report from the outcome

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Simulation Report',
          // style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // const Text(
            //   'Simulation Statistics',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 20),
            // Table to display the statistics
            Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(200.0),
                1: FlexColumnWidth(),
              },
              children: [
                _buildTableRow('Total Trials', '${report.totalTrials}'),
                _buildTableRow(
                    'Successful Trials', '${report.successfulTrials}'),
                _buildTableRow('Destroyed Trials', '${report.destroyedTrials}'),
                _buildTableRow('Average Cost Per Attempt',
                    '${(report.averageCostPerAttempt / 1e9).toStringAsFixed(2)}b'),
                _buildTableRow('Average Cost Per Success',
                    '${(report.averageCostPerSuccess / 1e9).toStringAsFixed(2)}b'),
                _buildTableRow('Destruction Rate',
                    '${(report.destructionRate * 100).toStringAsFixed(2)}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a table row
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: const TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, style: const TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
