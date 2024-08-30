#include "CrewScheduling.h"
#include <iostream>
#include <vector>
#include <random>

std::vector<Pairing> generateRandomPairings(int pairingCount, int flightCount, int timeRange) {
    std::vector<Pairing> pairings;
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> flightDist(0, flightCount - 1);
    std::uniform_int_distribution<> timeDist(0, timeRange - 1);

    for (int i = 0; i < pairingCount; ++i) {
        int startTime = timeDist(gen);
        int endTime = (startTime + 120 + timeDist(gen) % 480) % timeRange; // 2-10 hours later
        std::vector<int> flights = {flightDist(gen), flightDist(gen)}; // Each pairing covers 2 flights
        pairings.push_back(Pairing(i, startTime, endTime, flights));
    }
    return pairings;
}

int main() {
    CrewScheduling scheduler;

    // Set up problem parameters
    int crewCount = 10;
    int pairingCount = 20;
    int flightCount = 15;
    int timeRange = 24 * 60; // 24 hours in minutes

    // Generate crew members
    for (int i = 0; i < crewCount; ++i) {
        scheduler.crewList.push_back(CrewMember(i, "Crew " + std::to_string(i)));
    }

    // Generate random pairings
    std::vector<Pairing> pairings = generateRandomPairings(pairingCount, flightCount, timeRange);
    scheduler.setPairings(pairings);

    // Set costs
    scheduler.setCosts(100, 50, 30, 10); // C_u, C_a, C_d, C_m

    // Set time range for scheduling
    scheduler.setTimeRange(0, timeRange);

    // Run the optimization
    try {
        scheduler.optimizeSchedule();
        std::cout << "Optimization completed successfully." << std::endl;
        
        // Print results
        scheduler.printSchedule();
    } catch (const std::exception& e) {
        std::cerr << "Error during optimization: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}