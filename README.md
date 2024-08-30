 g++ -std=c++17 -I/usr/local/opt/or-tools/include -I/usr/local/include -Iinclude -L/usr/local/opt/or-tools/lib -lortools src/main.cpp src/CrewMember.cpp src/CrewScheduling.cpp -o CrewSchedulingOptimizer

 ./CrewSchedulingOptimizer


 g++ -std=c++17 -o simple_test simple_test.cpp

g++ -std=c++17 -I/usr/local/opt/or-tools/include -I/usr/local/include -Iinclude -L/usr/local/opt/or-tools/lib -L/usr/local/Cellar/abseil/20240722.0/lib -L/usr/local/lib -lortools -labsl_base -labsl_cord -labsl_strings -labsl_synchronization -labsl_time -lprotobuf src/main.cpp src/CrewMember.cpp src/CrewScheduling.cpp -o CrewSchedulingOptimizer