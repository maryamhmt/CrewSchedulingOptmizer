#ifndef CREW_SCHEDULING_H
#define CREW_SCHEDULING_H

#include <vector>
#include <string>

struct CrewMember {
    int id;
    std::string name;
    std::vector<int> assignedPairings;
    bool scheduleModified;
    bool scheduleCleared;

    CrewMember(int id, std::string name) 
        : id(id), name(name), scheduleModified(false), scheduleCleared(false) {}
};

struct Pairing {
    int id;
    int startTime;
    int endTime;
    std::vector<int> flights;

    Pairing(int id, int start, int end, std::vector<int> flights) 
        : id(id), startTime(start), endTime(end), flights(flights) {}
};

class CrewScheduling {
public:
    std::vector<CrewMember> crewList;
    std::vector<Pairing> pairings;

    void setPairings(const std::vector<Pairing>& pairings);
    void setCosts(int C_u, int C_a, int C_d, int C_m);
    void setTimeRange(int start, int end);
    void optimizeSchedule();
    void printSchedule();

private:
    int C_u, C_a, C_d, C_m;
    int timeRangeStart, timeRangeEnd;
};

#endif // CREW_SCHEDULING_H