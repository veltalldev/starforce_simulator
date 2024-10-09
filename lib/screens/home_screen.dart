import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../simulation/simulator.dart'; // Import the simulator logic
import '../simulation/simulation_config.dart'; // Import the config
import '../simulation/simulation_outcome.dart'; // Import the outcome class
import 'report_screen.dart'; // Import the report page

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _equipmentLevelController =
      TextEditingController();
  final TextEditingController _initialStarController = TextEditingController();
  final TextEditingController _targetStarController = TextEditingController();
  final TextEditingController _trialCountController =
      TextEditingController(text: '1000');
  final TextEditingController _mesoLimitController = TextEditingController();

  bool _isLoading = false;
  SimulationOutcome? _simulationOutcome;

  // Method to trigger the simulation
  void _runSimulation() async {
    final int equipmentLevel = int.parse(_equipmentLevelController.text);
    final int initialStar = int.parse(_initialStarController.text);
    final int targetStar = int.parse(_targetStarController.text);
    final int trialCount = int.parse(_trialCountController.text);
    final int? mesoLimit = _mesoLimitController.text.isNotEmpty
        ? int.parse(_mesoLimitController.text)
        : null;

    final config = SimulationConfig(
      equipmentLevel: equipmentLevel,
      initialStar: initialStar,
      targetStar: targetStar,
      trialCount: trialCount,
      // mesoLimit: mesoLimit,
    );

    setState(() {
      _isLoading = true;
    });

    // Run simulation asynchronously
    final simulator = await Simulator.create(config: config);
    final SimulationOutcome outcome = simulator.runSimulation();

    if (!mounted) return; // Ensure the widget is still in the tree

    setState(() {
      _isLoading = false;
      _simulationOutcome = outcome;
    });

    // Navigate to the report screen after simulation completes
    if (_simulationOutcome != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportScreen(outcome: _simulationOutcome!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Starforce Simulator',
          // style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter Simulation Parameters',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _equipmentLevelController,
              decoration: const InputDecoration(
                labelText: 'Equipment Level',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _initialStarController,
              decoration: const InputDecoration(
                labelText: 'Initial Star',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _targetStarController,
              decoration: const InputDecoration(
                labelText: 'Target Star',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _trialCountController,
              decoration: const InputDecoration(
                labelText: 'Number of Trials',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _mesoLimitController,
              decoration: const InputDecoration(
                labelText: 'Meso Limit (optional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _runSimulation,
                    child: const Text('Run Simulation'),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _equipmentLevelController.dispose();
    _initialStarController.dispose();
    _targetStarController.dispose();
    _trialCountController.dispose();
    _mesoLimitController.dispose();
    super.dispose();
  }
}
