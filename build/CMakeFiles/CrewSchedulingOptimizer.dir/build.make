# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.30

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.30.2/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.30.2/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/maryamhemmati/CrewSchedulingOptimizer

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/maryamhemmati/CrewSchedulingOptimizer/build

# Include any dependencies generated for this target.
include CMakeFiles/CrewSchedulingOptimizer.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/CrewSchedulingOptimizer.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/CrewSchedulingOptimizer.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/CrewSchedulingOptimizer.dir/flags.make

CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.o: CMakeFiles/CrewSchedulingOptimizer.dir/flags.make
CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.o: /Users/maryamhemmati/CrewSchedulingOptimizer/src/main.cpp
CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.o: CMakeFiles/CrewSchedulingOptimizer.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/maryamhemmati/CrewSchedulingOptimizer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.o"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.o -MF CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.o.d -o CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.o -c /Users/maryamhemmati/CrewSchedulingOptimizer/src/main.cpp

CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/maryamhemmati/CrewSchedulingOptimizer/src/main.cpp > CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.i

CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/maryamhemmati/CrewSchedulingOptimizer/src/main.cpp -o CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.s

CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.o: CMakeFiles/CrewSchedulingOptimizer.dir/flags.make
CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.o: /Users/maryamhemmati/CrewSchedulingOptimizer/src/CrewMember.cpp
CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.o: CMakeFiles/CrewSchedulingOptimizer.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/maryamhemmati/CrewSchedulingOptimizer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.o"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.o -MF CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.o.d -o CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.o -c /Users/maryamhemmati/CrewSchedulingOptimizer/src/CrewMember.cpp

CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/maryamhemmati/CrewSchedulingOptimizer/src/CrewMember.cpp > CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.i

CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/maryamhemmati/CrewSchedulingOptimizer/src/CrewMember.cpp -o CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.s

CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.o: CMakeFiles/CrewSchedulingOptimizer.dir/flags.make
CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.o: /Users/maryamhemmati/CrewSchedulingOptimizer/src/CrewScheduling.cpp
CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.o: CMakeFiles/CrewSchedulingOptimizer.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/maryamhemmati/CrewSchedulingOptimizer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.o"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.o -MF CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.o.d -o CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.o -c /Users/maryamhemmati/CrewSchedulingOptimizer/src/CrewScheduling.cpp

CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/maryamhemmati/CrewSchedulingOptimizer/src/CrewScheduling.cpp > CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.i

CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/maryamhemmati/CrewSchedulingOptimizer/src/CrewScheduling.cpp -o CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.s

# Object files for target CrewSchedulingOptimizer
CrewSchedulingOptimizer_OBJECTS = \
"CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.o" \
"CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.o" \
"CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.o"

# External object files for target CrewSchedulingOptimizer
CrewSchedulingOptimizer_EXTERNAL_OBJECTS =

CrewSchedulingOptimizer: CMakeFiles/CrewSchedulingOptimizer.dir/src/main.cpp.o
CrewSchedulingOptimizer: CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewMember.cpp.o
CrewSchedulingOptimizer: CMakeFiles/CrewSchedulingOptimizer.dir/src/CrewScheduling.cpp.o
CrewSchedulingOptimizer: CMakeFiles/CrewSchedulingOptimizer.dir/build.make
CrewSchedulingOptimizer: /usr/local/opt/or-tools/lib/libortools.dylib
CrewSchedulingOptimizer: CMakeFiles/CrewSchedulingOptimizer.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/Users/maryamhemmati/CrewSchedulingOptimizer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable CrewSchedulingOptimizer"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/CrewSchedulingOptimizer.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/CrewSchedulingOptimizer.dir/build: CrewSchedulingOptimizer
.PHONY : CMakeFiles/CrewSchedulingOptimizer.dir/build

CMakeFiles/CrewSchedulingOptimizer.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/CrewSchedulingOptimizer.dir/cmake_clean.cmake
.PHONY : CMakeFiles/CrewSchedulingOptimizer.dir/clean

CMakeFiles/CrewSchedulingOptimizer.dir/depend:
	cd /Users/maryamhemmati/CrewSchedulingOptimizer/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/maryamhemmati/CrewSchedulingOptimizer /Users/maryamhemmati/CrewSchedulingOptimizer /Users/maryamhemmati/CrewSchedulingOptimizer/build /Users/maryamhemmati/CrewSchedulingOptimizer/build /Users/maryamhemmati/CrewSchedulingOptimizer/build/CMakeFiles/CrewSchedulingOptimizer.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/CrewSchedulingOptimizer.dir/depend

