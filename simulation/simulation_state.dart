import 'package:starforce_sim/simulation/simulation_config.dart';

class SimulationState {
  SimulationConfig config;
  int currentStar;
  int consecutiveFailures;
  // double currentMeso;

  SimulationState({
    required this.config,
    this.currentStar = 0,
    this.consecutiveFailures = 0,
    // consider implementing an ongoing tracker of remaining Meso
  });

  // ================================ modifying stars
  void incrementStar() {
    this.currentStar++;
    consecutiveFailures = 0;
  }

  void decrementStar() {
    this.currentStar--;
    consecutiveFailures++;
  }

  // ================================= pity management
  bool isPityActive() {
    final pityEnabled = config.pityEnabled;
    return pityEnabled && (consecutiveFailures >= 2);
  }

  // ================================= event management
  bool isEvent51015Active() {
    final eventEnabled = config.event51015;
    final star = currentStar;
    bool is51015_stars = (star == 5 || star == 10 || star == 15);
    return eventEnabled && is51015_stars;
  }

  // ================================= safeguard management
  bool isSafeguardActive() {
    bool sgState = config.safeguardEnabled;
    final isPity = isPityActive();
    final is51015 = isEvent51015Active();
    final isInSafeguardStarRange = (currentStar == 15 || currentStar == 16);
    if (is51015 || isPity || !isInSafeguardStarRange) {
      sgState = false;
    }
    return sgState;
  }

  void resetState() {
    currentStar = 0;
    consecutiveFailures = 0;
  }
}
