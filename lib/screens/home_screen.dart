import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _equipmentLevelController =
      TextEditingController();
  final TextEditingController _initialStarController = TextEditingController();
  final TextEditingController _targetStarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Starforce Simulator'),
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
            ElevatedButton(
              onPressed: () {
                // Trigger simulation and navigate to results screen here
              },
              child: const Text('Start Simulation'),
            ),
          ],
        ),
      ),
    );
  }
}
