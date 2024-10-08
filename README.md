# 🌟 Starforce Sim: Equipment Upgrade Simulator 🌟

## Overview

This project is a Dart application that simulates the upgrading process of equipment in the MMORPG MapleStory. The simulator models various features such as upgrade success rates, failure consequences, destruction events, safeguard options, and event-driven modifications (such as the Pity System, 5/10/15 guaranteed success events, and cost discounts).

Users can input equipment properties like the level, initial stars, target stars, and the number of trials. The simulator will run those trials and provide detailed statistics, including success rates, destruction rates, and resource costs.

## Features

- **Simulates equipment upgrades** with outcomes like success, failure (maintain, decrease), and destruction.
- **Incorporates special events and features** such as:
  - 🛡️ **Pity System**: Guarantees success after consecutive failures.
  - 🎉 **5/10/15 Events**: Guaranteed success for specific star levels.
  - 💸 **30% Discount Event**: Reduces the cost of upgrade attempts.
  - 🔒 **Safeguard Mechanic**: Prevents destruction during high-risk upgrades at star levels 15 and 16.
- **Tracks and reports**:
  - Success, failure, and destruction statistics.
  - Total meso spent and average cost per successful upgrade.
- **Dynamic Configuration**: Allows users to customize input parameters like equipment level, initial stars, target stars, and meso budget.

## 📂 Directory Structure

```
/starforce_sim/
│
├── /lib/
│   ├── /models/                     # Data models (e.g., probability table, results)
│   ├── /services/                   # Core simulation logic (cost and probability providers)
│   ├── /simulation/                 # State management and core simulation execution logic
│   ├── /utils/                      # Helper functions (probability adjustments, calculations)
│   └── main.dart                    # Main entry point for running the simulation
│
├── /test/                           # Unit tests for the simulator
│   └── upgrade_simulator_test.dart
│
├── /assets/                         # Assets (if needed)
├── /data/                           # Data storage (optional)
├── pubspec.yaml                     # Project dependencies
└── README.md                        # Project documentation (this file)
```

---

## 📜 Functional Requirements and Implementation Summary

### Functional Requirements
This project involves creating a simulation system for equipment upgrading in a game setting. The core functionalities are defined as follows:

#### 1. **Equipment Class**
   - **Purpose**: Model an item that can be upgraded, with properties for its current star level and destruction status.
   - **Methods**:
     - ⭐ `upgradeStar()`: Increase the star level by one.
     - ⬇️ `decreaseStar()`: Decrease the star level by one.
     - 💥 `destroy()`: Mark the item as destroyed.

#### 2. **Upgrade Result Enum**
   - **Description**: Enumerate possible outcomes of an upgrade attempt—success, maintain (no change), decrease, and destruction.

#### 3. **Probability Table**
   - **Functionality**: Store and provide base success and failure probabilities for each star level upgrade attempt.
   - **Components**:
     - Success rates, maintain rates, decrease rates, and destroy rates per star level.

#### 4. **Cost Provider**
   - **Purpose**: Calculate the cost of each upgrade attempt based on the item's level, current star level, and events like safeguard or discounts (e.g., event30).
   - **Details**: Costs increase exponentially with higher star levels, with adjustments for special conditions such as safeguard and event discounts.

#### 5. **Upgrade Service**
   - **Role**: Handle the logic of attempting an equipment upgrade using the provided probabilities and cost calculations.
   - **Features**:
     - Calculate the outcome based on randomized logic and update equipment status accordingly.

#### 6. **Probability Provider**
   - **Role**: Provide base success and failure probabilities for each star level and adjust them based on dynamic game mechanics like:
     - **Pity System**: Increases success rate after consecutive failures.
     - **Event Boosts**: Provides a 100% success rate for specific stars (5, 10, 15) during special events.
     - **Safeguard**: Prevents destruction at certain stars.

#### 7. **SimulationState**
   - **Purpose**: Tracks dynamic conditions during the simulation, such as the current star level, number of consecutive failures, pity activation, and event/safeguard activity.
   - **Methods**:
     - `incrementStar()`, `decrementStar()`, `activatePity()`, `isSafeguardActive()`, `isEvent51015Active()`, and more.

#### 8. **Simulation Logic**
   - **Functionality**: Simulate a series of upgrade attempts and track statistics such as:
     - Number of successes and failures.
     - Meso spent.
     - Number of destroyed items.
     - Stars achieved.
   - **Setup**: Allows configuration of starting conditions, such as initial star level, meso budget, target star level, and enabled special features (e.g., event51015, safeguard).

### 🛠️ Implementation Details
The project is structured into various modules for maintainability and clarity. Here is a brief overview of the updated implementation:

#### 1. **Models**
   - **Equipment**: Manages the state and behavior of the items being upgraded.
   - **UpgradeResult**: Provides outcome types for easy result management (success, maintain, decrease, destroy).

#### 2. **Services**
   - **ProbabilityProvider**: Centralizes logic for fetching base probabilities and adjusting them dynamically based on game rules (pity, events, safeguards).
   - **CostProvider**: Implements the logic for calculating upgrade costs, considering base costs, events (e.g., event30), and safeguards.
   - **UpgradeService**: Uses the probability and cost data to execute logic for determining upgrade outcomes.

#### 3. **Simulation Execution**
   - A dedicated script runs the simulation multiple times, capturing essential metrics and providing insights into the effectiveness of different strategies. It uses the updated `SimulationState` to manage dynamic conditions during each trial.

#### 4. **State and Config Management**
   - **SimulationConfig**: Holds static configuration settings, such as whether pity, safeguard, or events are enabled, as well as equipment level, meso budget, and probability data paths.
   - **SimulationState**: Tracks dynamic states such as the current star level, pity activation, event activity, and safeguard use, allowing for clean management of simulation logic.

#### 5. **Testing and Validation**
   - Tests ensure the system behaves as expected under different configurations and edge cases, such as resource exhaustion, event-triggered boosts, and safeguard protection.

### 🔧 Running the Simulation
The main entry point of the simulation is designed to allow easy adjustment of parameters and testing of different scenarios. The user can configure initial star levels, meso budgets, target star levels, and whether special events or boosts are active.

---

## 🚀 Future Plans

- Integrate UI components using Flutter for easy visualization of the results.
- Add graphing functionality to display statistics in charts (success rates, failure events, etc.).
- Improve customization options for event toggles and simulator settings.

## 🤝 Contributing

Feel free to contribute by submitting issues or pull requests. Make sure to run the unit tests before making any changes.

## 📜 License

This project is licensed under the MIT License - see the LICENSE file for details.
