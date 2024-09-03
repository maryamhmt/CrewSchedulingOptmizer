#include <iostream>
#include <vector>
#include <cmath>
#include "CrewScheduling.h"
#include "ortools/linear_solver/linear_solver.h"

//defining the parameters 
void CrewScheduling::setPairings(const std::vector<Pairing>& pairings) {
    this->pairings = pairings;
}

void CrewScheduling::setCosts(int C_u, int C_a, int C_d, int C_m) {
    this->C_u = C_u;
    this->C_a = C_a;
    this->C_d = C_d;
    this->C_m = C_m;
}

void CrewScheduling::setTimeRange(int start, int end) {
    this->timeRangeStart = start;
    this->timeRangeEnd = end;
}


void CrewScheduling::optimizeSchedule() {
    std::cout << "Starting schedule optimization..." << std::endl;

    operations_research::MPSolver solver("CrewSchedulingSolver", operations_research::MPSolver::CBC_MIXED_INTEGER_PROGRAMMING);
    
    
    // counting the number of covered flight, later we make sure all flights are covered within pairings 
    int pairingCount = pairings.size();

    for(const auto& paring : pairings){
        for(const auto& flight : paring.flights){
            assignedFlight.insert(flight);
        }
    }

    int flightCount = assignedFlight.size();

   

    // Create indicator matrix shows the flights in each pairing
    std::vector<std::vector<int>> alpha(pairingCount, std::vector<int>(flightCount, 0));
    for (int i = 0; i < pairingCount; ++i) {
        for (int f : pairings[i].flights) {
            alpha[i][f] = 1;
        }
    }

    // Create pairingsOverlap matrix
    std::vector<std::vector<bool>> pairingsOverlap(pairingCount, std::vector<bool>(pairingCount, false));
    for (int i = 0; i < pairingCount; ++i) {
        for (int j = i + 1; j < pairingCount; ++j) {
            if (pairings[i].startTime < pairings[j].endTime && pairings[j].startTime < pairings[i].endTime) {
                pairingsOverlap[i][j] = pairingsOverlap[j][i] = true;
            }
        }
    }

    //variables x_ic= 1 if if pairing iis assigned to crew c, y_c = 1 if crew c's schedule is modifies and z_c =1 if crew c's schedule is cleared
    std::vector<std::vector<operations_research::MPVariable*>> x;
    std::vector<operations_research::MPVariable*> y, z, s;

    // Variable x for each crew and pairing
    for (const auto& crew : crewList) {
        std::vector<operations_research::MPVariable*> crewVars;
        for (int i = 0; i < pairingCount; ++i) {
            crewVars.push_back(solver.MakeBoolVar("x_" + std::to_string(crew.id) + "_" + std::to_string(i)));
        }
        x.push_back(crewVars);
    }

    // Variable y and z for each crew schedule modification and clearing
    for (const auto& crew : crewList) {
        y.push_back(solver.MakeBoolVar("y_" + std::to_string(crew.id)));
        z.push_back(solver.MakeBoolVar("z_" + std::to_string(crew.id)));
    }

    // Variable indicating if a pairing is modified
    for (int i = 0; i < pairingCount; ++i) {
        s.push_back(solver.MakeBoolVar("s_" + std::to_string(i)));
    }

    // Define constraints

    // Flight Coverage Constraint
    for (int f = 0; f < flightCount; ++f) {
        operations_research::MPConstraint* flightCoverageConstraint = solver.MakeRowConstraint(0, 1);
        for (int i = 0; i < pairingCount; ++i) {
            for (int c = 0; c < crewList.size(); ++c) {
                flightCoverageConstraint->SetCoefficient(x[c][i], alpha[i][f]);
            }
        }
    }

    // Crew Assignment Constraints
    for (int c = 0; c < crewList.size(); ++c) {
        for (int i = 0; i < pairingCount; ++i) {
            for (int j = i + 1; j < pairingCount; ++j) {
                if (pairingsOverlap[i][j]) {
                    operations_research::MPConstraint* constraint = solver.MakeRowConstraint(0, 1);
                    constraint->SetCoefficient(x[c][i], 1);
                    constraint->SetCoefficient(x[c][j], 1);
                }
            }
        }
    }

    // Rest Periods Constraint
    for (int c = 0; c < crewList.size(); ++c) {
        for (int i = 0; i < pairingCount; ++i) {
            for (int j = 0; j < pairingCount; ++j) {
                if (i != j && pairings[i].endTime + 600 <= pairings[j].startTime) {
                    operations_research::MPConstraint* constraint = solver.MakeRowConstraint(-solver.infinity(), 600);
                    constraint->SetCoefficient(x[c][i], pairings[i].endTime);
                    constraint->SetCoefficient(x[c][j], -pairings[j].startTime);
                }
            }
        }
    }

    // Cleared Schedules Constraint
    int minClearedCrew = static_cast<int>(0.2 * crewList.size() + 0.5);
    operations_research::MPConstraint* clearedConstraint = solver.MakeRowConstraint(minClearedCrew, solver.infinity());
    for (int c = 0; c < crewList.size(); ++c) {
        clearedConstraint->SetCoefficient(z[c], 1);
    }

    // No Pairings for Cleared Crews Constraint
    for (int c = 0; c < crewList.size(); ++c) {
        operations_research::MPConstraint* constraint = solver.MakeRowConstraint(-solver.infinity(), 0);
        for (int i = 0; i < pairingCount; ++i) {
            constraint->SetCoefficient(x[c][i], 1);
        }
        constraint->SetCoefficient(z[c], -pairingCount);
    }

    // Schedule Modification Definition
    for (int c = 0; c < crewList.size(); ++c) {
        for (int i = 0; i < pairingCount; ++i) {
            operations_research::MPConstraint* constraint1 = solver.MakeRowConstraint(-solver.infinity(), 0);
            constraint1->SetCoefficient(y[c], -1);
            constraint1->SetCoefficient(x[c][i], 1);
            constraint1->SetCoefficient(s[i], -1);

            operations_research::MPConstraint* constraint2 = solver.MakeRowConstraint(-solver.infinity(), 0);
            constraint2->SetCoefficient(y[c], -1);
            constraint2->SetCoefficient(s[i], 1);
            constraint2->SetCoefficient(x[c][i], -1);
        }
    }

    // Define objective function
    operations_research::MPObjective* objective = solver.MutableObjective();
    objective->SetMinimization();

    // Cost of unassigned flights
    for (int f = 0; f < flightCount; ++f) {
        operations_research::MPVariable* unassigned = solver.MakeNumVar(0, 1, "unassigned_" + std::to_string(f));
        operations_research::MPConstraint* unassignedConstraint = solver.MakeRowConstraint(1, 1);
        unassignedConstraint->SetCoefficient(unassigned, 1);
        for (int i = 0; i < pairingCount; ++i) {
            for (int c = 0; c < crewList.size(); ++c) {
                unassignedConstraint->SetCoefficient(x[c][i], -alpha[i][f]);
            }
        }
        objective->SetCoefficient(unassigned, C_u);
    }

    // Cost of assigning off-plan pairings and deassigning original pairings
    for (int i = 0; i < pairingCount; ++i) {
        for (int c = 0; c < crewList.size(); ++c) {
            operations_research::MPVariable* offPlan = solver.MakeNumVar(0, 1, "off_plan_" + std::to_string(i) + "_" + std::to_string(c));
            operations_research::MPConstraint* offPlanConstraint = solver.MakeRowConstraint(0, 0);
            offPlanConstraint->SetCoefficient(offPlan, 1);
            offPlanConstraint->SetCoefficient(x[c][i], -1);
            offPlanConstraint->SetCoefficient(s[i], 1);
            objective->SetCoefficient(offPlan, C_a);

            operations_research::MPVariable* deassign = solver.MakeNumVar(0, 1, "deassign_" + std::to_string(i) + "_" + std::to_string(c));
            operations_research::MPConstraint* deassignConstraint = solver.MakeRowConstraint(0, 0);
            deassignConstraint->SetCoefficient(deassign, 1);
            deassignConstraint->SetCoefficient(s[i], 1);
            deassignConstraint->SetCoefficient(x[c][i], 1);
            objective->SetCoefficient(deassign, C_d);
        }
    }

    // Cost of modifying pilot schedules
    for (int c = 0; c < crewList.size(); ++c) {
        objective->SetCoefficient(y[c], C_m);
    }

    // Solve the problem
    operations_research::MPSolver::ResultStatus result_status = solver.Solve();
    if (result_status != operations_research::MPSolver::OPTIMAL) {
        std::cerr << "The problem does not have an optimal solution. Status: " << result_status << std::endl;
        return;
    }

    // Store results
    for (size_t c = 0; c < crewList.size(); ++c) {
        crewList[c].assignedPairings.clear();
        for (int i = 0; i < pairingCount; ++i) {
            if (x[c][i]->solution_value() > 0.5) {
                crewList[c].assignedPairings.push_back(i);
            }
        }
        crewList[c].scheduleModified = (y[c]->solution_value() > 0.5);
        crewList[c].scheduleCleared = (z[c]->solution_value() > 0.5);
    }
}

void CrewScheduling::printSchedule() {
    for (const auto& crew : crewList) {
        std::cout << "Crew " << crew.name << " (ID: " << crew.id << "):" << std::endl;
        if (crew.scheduleCleared) {
            std::cout << "  Schedule cleared" << std::endl;
        } else {
            for (int pairingId : crew.assignedPairings) {
                const auto& pairing = pairings[pairingId];
                std::cout << "  Pairing " << pairingId << ": Start: " << pairing.startTime 
                          << ", End: " << pairing.endTime << ", Flights: ";
                for (int flight : pairing.flights) {
                    std::cout << flight << " ";
                }
                std::cout << std::endl;
            }
            if (crew.scheduleModified) {
                std::cout << "  Schedule modified" << std::endl;
            }
        }
        std::cout << std::endl;
    }
}