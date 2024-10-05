class SimulationConfig {
  final bool pityEnabled;
  final bool safeguardEnabled;
  final bool event51015;
  final bool event30;
  final double mesoBudget;
  final int equipmentCount;
  final int equipmentLevel;
  final String probabilityDataFilePath;

  SimulationConfig({
    this.pityEnabled = true, // Sensible default values
    this.safeguardEnabled = false,
    this.event51015 = false,
    this.event30 = false,
    this.mesoBudget = 20 * 1e9, // Default resource value
    this.equipmentCount = 1,
    this.equipmentLevel = 150,
    this.probabilityDataFilePath = "./data/starcatch_probability_table.csv",
  }) {
    if (mesoBudget <= 0) {
      throw ArgumentError("Meso budget must be positive");
    }
    if (equipmentLevel <= 0) {
      throw ArgumentError("Equipment level must be positive");
    }
  }
}
