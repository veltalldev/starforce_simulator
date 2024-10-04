# Starforce Sim Project: Functional Requirements and Implementation Summary

## Functional Requirements
This project involves creating a simulation system for equipment upgrading in a game setting. The core functionalities are defined as follows:

### 1. **Equipment Class**
   - **Purpose**: Model an item that can be upgraded, with properties for its current star level and destruction status.
   - **Methods**:
     - `upgradeStar()`: Increase the star level by one.
     - `decreaseStar()`: Decrease the star level by one.
     - `destroy()`: Mark the item as destroyed.

### 2. **Upgrade Result Enum**
   - **Description**: Enumerate possible outcomes of an upgrade attempt—success, maintain (no change), decrease, and destruction.

### 3. **Probability Table**
   - **Functionality**: Store and provide base success and failure probabilities for each star level upgrade attempt.
   - **Components**:
     - Success rates, maintain rates, decrease rates, and destroy rates per star level.

### 4. **Cost Calculator**
   - **Purpose**: Calculate the cost of each upgrade attempt based on the item's level and current star.
   - **Details**: Costs increase exponentially with higher star levels.

### 5. **Upgrade Service**
   - **Role**: Handle the logic of attempting an equipment upgrade using the provided probabilities and cost calculations.
   - **Features**:
     - Calculate the outcome based on randomized logic and update equipment status accordingly.

### 6. **Probability Provider**
   - **Previously**: ProbabilityModifier
   - **Current Role**: Provide and modify probabilities based on game mechanics like the Pity System, Event boosts, and Safeguards.

### 7. **Simulation Logic**
   - **Functionality**: Simulate a series of upgrade attempts to gather statistics on outcomes—number of successes, failures, and average costs.
   - **Setup**: Allows configuration of initial conditions such as the number of trials, starting star level, and whether special features are enabled.

## Implementation Details
The project is structured into various modules for maintainability and clarity. Here is a brief overview of the implementation:

### 1. **Models**
   - **Equipment**: Handles the state and behavior of the items being upgraded.
   - **UpgradeResult**: Provides outcome types for easy result management.

### 2. **Services**
   - **ProbabilityProvider**: Centralizes the logic for fetching and adjusting probabilities based on dynamic game rules.
   - **UpgradeService**: Uses the probability data to execute logic for determining upgrade outcomes.
   - **CostCalculator**: Implements the formula for calculating upgrade costs.

### 3. **Simulation Execution**
   - A dedicated script to run the simulation multiple times, capturing essential metrics and providing insights into the effectiveness of different strategies.

### 4. **Testing and Validation**
   - Basic tests ensure the system behaves as expected under various configurations.

## Running the Simulation
The main entry point of the simulation is configured to allow easy adjustment of parameters and quick testing of different scenarios.
