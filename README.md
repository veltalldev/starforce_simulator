## Starforce Simulation TODO

### What’s Done
- [x] **Providers**:
  - [x] `ProbabilityProvider`: Handles success, fail-maintain, fail-decrease, and fail-destroy rates based on the current state and configuration.
  - [x] `CostProvider`: Calculates the cost of each upgrade attempt, considering safeguard, events, and base costs.
  
- [x] **State and Config**:
  - [x] `SimulationState`: Tracks dynamic conditions like current star, pity status, safeguard, event activity, and failure counts.
  - [x] `SimulationConfig`: Holds static configuration settings like safeguard-enabled, event flags, meso budget, equipment count, etc.

### What Still Needs to Happen

#### 1. Core Simulation Logic
- [ ] Implement `runSimulation()`:
  - [ ] Calculate the success rate for each upgrade attempt.
  - [ ] Apply the result: Increment or decrement the star level based on success or failure.
  - [ ] Update the `SimulationState` dynamically based on the results (pity, failures, safeguard).
  - [ ] Deduct meso cost using `CostProvider.getCost()`.

#### 2. Resource (Meso) Management
- [ ] Track the remaining meso budget (in `SimulationConfig` or `SimulationState`).
- [ ] Deduct cost for each upgrade attempt.
- [ ] Stop the simulation if the meso budget is exhausted before reaching the desired star.

#### 3. Simulation Configuration
- [ ] Allow customization of input for simulation:
  - [ ] Starting star level.
  - [ ] Target star level.
  - [ ] Number of trials.
  - [ ] Initial meso budget.

#### 4. Results Tracking
- [ ] Capture the following statistics during the simulation:
  - [ ] Success and failure counts.
  - [ ] Total meso spent.
  - [ ] Number of destroyed items (if applicable).
  - [ ] Stars achieved.
- [ ] Report statistics:
  - [ ] Average meso cost per success.
  - [ ] Destruction rate.
  - [ ] Success rate for reaching the target star.

#### 5. Final Reporting/Visualization
- [ ] Generate a report of the results:
  - [ ] Print the results in the console.
  - [ ] Optionally save as CSV or JSON for detailed analysis.
- [ ] Optional: Add graphing or visualization of the results (e.g., cost vs. success rate).

#### 6. Testing and Fine-Tuning
- [ ] Test the simulation with different configurations and scenarios:
  - [ ] Meso budget exhaustion.
  - [ ] High consecutive failure rates triggering the pity system.
  - [ ] Safeguard usage for star levels 15/16 during event51015.
  - [ ] Verify that all dynamic conditions (pity, safeguard, events) work as expected.
