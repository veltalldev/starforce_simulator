import 'package:starforce_sim_flutter/models/equipment.dart';
import 'package:starforce_sim_flutter/simulation/simulation_config.dart';

class SimulationState {
  SimulationConfig config;
  Equipment equipment;
  int consecutiveFailures;
  // double currentMeso;
  int successfulTrials;
  int destroyedTrials;
  double totalCost;
  int totalAttempts;
  SimulationState({
    required this.config,
    this.successfulTrials = 0,
    this.destroyedTrials = 0,
    this.totalAttempts = 0,
    this.totalCost = 0.0,
    // consider implementing an ongoing tracker of remaining Meso
  })  : equipment = Equipment(config.equipmentLevel, config.initialStar),
        consecutiveFailures = 0;

  // ================================ star management
  int getCurrentStar() {
    return equipment.currentStar;
  }

  void incrementStar() {
    equipment.incrementStar();
    consecutiveFailures = 0;
  }

  void decrementStar() {
    equipment.decrementStar();
    consecutiveFailures++;
  }

  bool reachedTargetStar() {
    return getCurrentStar() == config.targetStar;
  }

  // ================================= pity management
  bool isPityActive() {
    final pityEnabled = config.pityEnabled;
    return pityEnabled && (consecutiveFailures >= 2);
  }

  // ================================= event management
  bool isEvent51015Active() {
    final eventEnabled = config.event51015;
    final star = getCurrentStar();
    bool is51015_stars = (star == 5 || star == 10 || star == 15);
    return eventEnabled && is51015_stars;
  }

  // ================================= safeguard management
  bool isSafeguardActive() {
    bool sgState = config.safeguardEnabled;
    final star = getCurrentStar();
    final isPity = isPityActive();
    final is51015 = isEvent51015Active();
    final isInSafeguardStarRange = (star == 15 || star == 16);
    if (is51015 || isPity || !isInSafeguardStarRange) {
      sgState = false;
    }
    return sgState;
  }

  void resetState() {
    equipment = Equipment(config.equipmentLevel, config.initialStar);
    consecutiveFailures = 0;
  }
}
