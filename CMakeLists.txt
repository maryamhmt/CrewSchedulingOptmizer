cmake_minimum_required(VERSION 3.10)
project(CrewSchedulingOptimizer)

# Set C++ standard to C++14
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Include directories
include_directories(${PROJECT_SOURCE_DIR}/include 
                    /usr/local/opt/or-tools/include
                    /usr/local/include)

# Add executable
add_executable(CrewSchedulingOptimizer src/main.cpp src/CrewMember.cpp src/CrewScheduling.cpp)

# Link libraries
target_link_libraries(CrewSchedulingOptimizer /usr/local/opt/or-tools/lib/libortools.dylib)
