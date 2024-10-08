import 'dart:math';

import 'package:starforce_sim/simulation/simulation_config.dart';
import 'package:starforce_sim/simulation/simulation_state.dart';

class CostProvider {
  final SimulationConfig config;
  final SimulationState state;
  CostProvider(this.config, this.state);

  double getCost() {
    final star = state.getCurrentStar();
    if (star < 0 || star > 25) {
      throw ArgumentError('Invalid star level: $star');
    }
    var cost = _calculateBaseCost();
    final isSafeguardActive = state.isSafeguardActive();
    var event30 = config.event30;

    if (event30) {
      cost *= 0.7;
    }
    if (isSafeguardActive) {
      cost *= 2;
    }

    return cost;
  }

  double _calculateBaseCost() {
    final star = state.getCurrentStar();
    final equipmentLevel = config.equipmentLevel;
    double scale;
    int base;

    if (star <= 9) {
      scale = 0.5;
      base = 2500;
    } else if (star <= 14) {
      scale = 2.7;
      base = getBaseForStar(star);
    } else {
      scale = 2.7;
      base = 20000;
    }

    return (100.0 *
        (pow(equipmentLevel, 3) * pow((star + 1), scale) / base + 10));
  }

  static int getBaseForStar(int star) {
    switch (star) {
      case 10:
        return 40000;
      case 11:
        return 22000;
      case 12:
        return 15000;
      case 13:
        return 11000;
      case 14:
        return 7500;
      default:
        return 0;
    }
  }
}
