# Crew Scheduling Problem

**Maryam Hemmati**  
**Date:** \today  
**Title:** Crew Scheduling Problem

## Flight Scheduling

### Problem Statement

**Introduction:**  
Pilots' schedules consist of flight sequences called pairings. For simplicity, we assume a pairing is a sequence of flights (two or more) that starts and ends at the same airport (being the crew's home base). After each pairing, there must be a required rest period.

**Problem:**  
There was a hurricane forecast, and many flights were canceled. Pilots cannot continue flying with their original schedules (pairings) because, with flight cancellations, pairings usually become corrupted (missing flight connections or the same airport start and end requirement). Thus, other flights from the original pairings cannot be flown if the current schedules remain unchanged. In this situation, the airline recovery system generated a new set of pairings from all non-canceled flights (containing all possible pairings); however, due to the huge number of possibilities, the system couldn't build new schedules for pilots. The airline asked an OR expert for help.

You are responsible for building new schedules for pilots using pre-generated flight sequences (pairings), minimizing the cost, with the following objectives and constraints in mind:

### Objectives

- As many flights as possible should be covered (pilots assigned).
- Pilots should keep as much of their original schedule as possible (minimize the total number of off-plan pairings).
- The number of pilots with schedule changes should be minimized (minimize the number of modified pilot schedules).

### Constraints

- Each flight can be assigned to a maximum of one pilot.
- After each pairing, there must be at least a 1-hour rest period (two consecutive assignments should be separated by at least 10 hours).
- As the airline would like to keep a pool of pilots available for other possible tasks/disruptions, 20% (rounded up) of pilots should have their schedules cleared (all pairings removed).

### Parameters

- \( R_s, R_e \): Integer parameters representing the start time and end time (in minutes from 01.01.1970) of the period for schedule generation. The assumption is that all flights, pairings, and schedules are contained within this period.
- \( C \): Set of crew (pilots).
- \( F \): Set of non-canceled flights.
- \( P \): Set of pairings generated from flights \( F \).
- \( p_{if} \): Binary coefficient, where \( p_{if} = 1 \) if and only if pairing \( i \) includes flight \( f \).
- \( s_{ic} \): Binary coefficient, where \( s_{ic} = 1 \) if and only if pairing \( i \) was in the original schedule of crew \( c \).
- \( s_i, e_i \): Integer coefficients representing the start time and end time (in minutes from 01.01.1970) of pairing \( i \).
- \( C_u \): Cost of an unassigned flight.
- \( C_a \): Cost of assigning a pairing that was not in the original plan.
- \( C_d \): Cost of deassigning a pairing that was in the original plan.
- \( C_m \): Unit cost if the pilot's original schedule was modified.

### Tasks

1. **Formulate the problem as an Integer Programming (IP) model.**

#### Model Formulation

### Decision Variables

- \( x_{ic} \) is defined as:
  \[
  x_{ic} =
  \begin{cases} 
  1 & \text{if pairing \( i \) is assigned to crew \( c \),} \\ 
  0 & \text{otherwise.} 
  \end{cases}
  \]

- \( y_c \) is defined as:
  \[
  y_c =
  \begin{cases} 
  1 & \text{if crew \( c \)'s schedule is modified,} \\ 
  0 & \text{otherwise.} 
  \end{cases}
  \]

- \( z_c \) is defined as:
  \[
  z_c =
  \begin{cases} 
  1 & \text{if crew \( c \)'s schedule is cleared,} \\ 
  0 & \text{otherwise.} 
  \end{cases}
  \]


##### Objective Function

\[
\min \left( \sum_{f \in F} C_u \cdot \left(1 - \sum_{i \in P} \sum_{c \in C} \alpha_{if} x_{ic}\right) + \sum_{i \in P} \sum_{c \in C} C_a \cdot (1 - s_{ic}) x_{ic} + \sum_{i \in P} \sum_{c \in C} C_d \cdot s_{ic} (1 - x_{ic}) + \sum_{c \in C} C_m \cdot y_c \right)
\]

##### Constraints

1. **Flight Coverage:**

\[
\sum_{i \in P} \sum_{c \in C} \alpha_{if} x_{ic} \leq 1, \quad \forall f \in F
\]

2. **Crew Assignment:**

\[
x_{ic} + x_{jc} \leq 1, \quad \forall c \in C, \forall i, j \in P \text{ where } [s_i, e_i] \cap [s_j, e_j] \neq \emptyset
\]

3. **Rest Periods:**

\[
e_i x_{ic} + 600 \leq s_j x_{jc} + M(2 - x_{ic} - x_{jc}), \quad \forall c \in C, \forall i, j \in P \text{ where } e_i < s_j
\]

4. **Cleared Schedules:**

\[
\sum_{c \in C} z_c \geq \lceil 0.2 \cdot |C| \rceil
\]

5. **No Pairings for Cleared Crews:**

\[
\sum_{i \in P} x_{ic} \leq M(1 - z_c), \quad \forall c \in C
\]

6. **Schedule Modification Definition:**

\[
y_c \geq x_{ic} - s_{ic}, \quad \forall c \in C, \forall i \in P
\]

\[
y_c \geq s_{ic} - x_{ic}, \quad \forall c \in C, \forall i \in P
\]

##### Binary Constraints

\[
x_{ic}, y_c, z_c \in \{0, 1\}, \quad \forall c \in C, \forall i \in P
\]

### Additional Considerations

- **Two Pilots on a Flight:**

\[
\sum_{i \in P} \sum_{c \in C} \alpha_{if} x_{ic} \leq 2, \quad \forall f \in F
\]

- **Solving the Model:**

To efficiently solve this model with a large set of possible pairings, I would start with **column generation**. This technique begins with a restricted master problem (RMP) containing only a subset of pairings, then iteratively adds new pairings with reduced cost from a pricing subproblem until no more reduced cost is observed.

For more complex scenarios, I might consider **Branch-and-Price**, **Heuristics**, or even **Parallel Computing** on a GPU.

**Note:** I am currently writing C++ code for this model and solving it using OR-Tools. You can watch my progress on my [GitHub repository](https://github.com/maryamhmt/CrewSchedulingOptimizer).

 To compile:
 
 g++ -std=c++17 -I/usr/local/opt/or-tools/include -I/usr/local/include -Iinclude -L/usr/local/opt/or-tools/lib -L/usr/local/Cellar/abseil/20240722.0/lib -L/usr/local/lib -lortools -labsl_base -labsl_cord -labsl_strings -labsl_synchronization -labsl_time -lprotobuf src/main.cpp src/CrewScheduling.cpp -o CrewSchedulingOptimizer

To run:
 ./CrewSchedulingOptimizer
