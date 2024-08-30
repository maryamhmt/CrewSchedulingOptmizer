 To compile:
 
 g++ -std=c++17 -I/usr/local/opt/or-tools/include -I/usr/local/include -Iinclude -L/usr/local/opt/or-tools/lib -L/usr/local/Cellar/abseil/20240722.0/lib -L/usr/local/lib -lortools -labsl_base -labsl_cord -labsl_strings -labsl_synchronization -labsl_time -lprotobuf src/main.cpp src/CrewScheduling.cpp -o CrewSchedulingOptimizer

To run:
 ./CrewSchedulingOptimizer
