 \documentclass{article}

\usepackage{geometry}
\usepackage{amsmath} 
\usepackage{hyperref}

% Make header with name and date etc.
\usepackage{fancyhdr}
\lhead{Maryam Hemmati}
\rhead{\today\\Crew Scheduling Problem}
\thispagestyle{fancy}

\usepackage[utf8]{inputenc}
\setlength{\parindent}{0pt} % Don't indent new paragraphs
\setlength{\headheight}{24pt} 

\begin{document}

\section{Flight Scheduling}

\subsection{Problem Statement}

\textbf{Introduction:} \\
Pilots' schedules consist of flight sequences called pairings. For simplicity, we assume a pairing is a sequence of flights (two or more) that starts and ends at the same airport (being the crew's home base). After each pairing, there must be a required rest period.

\textbf{Problem:} \\
There was a hurricane forecast, and many flights were cancelled. Pilots cannot continue flying with their original schedules (pairings) because, with flight cancellations, pairings usually become corrupted (missing flight connections or the same airport start and end requirement). Thus, other flights from the original pairings cannot be flown if the current schedules remain unchanged. In this situation, the airline recovery system generated a new set of pairings from all non-cancelled flights (containing all possible pairings); however, due to the huge number of possibilities, the system couldn't build new schedules for pilots. The airline asked an OR expert for help.

You are responsible for building new schedules for pilots using pre-generated flight sequences (pairings), minimizing the cost, with the following objectives and constraints in mind:

\subsection{Objectives}

\begin{itemize}
    \item As many flights as possible should be covered (pilots assigned).
    \item Pilots should keep as much of their original schedule as possible (minimize the total number of off-plan pairings).
    \item The number of pilots with schedule changes should be minimized (minimize the number of modified pilot schedules).
\end{itemize}

\subsection{Constraints}

\begin{itemize}
    \item Each flight can be assigned to a maximum of one pilot.  
    \item After each pairing, there must be at least a 1-hour rest period (two consecutive assignments should be separated by at least 10 hours).
    \item As the airline would like to keep a pool of pilots available for other possible tasks/disruptions, 20\% (rounded up) of pilots should have their schedules cleared (all pairings removed).
\end{itemize}

\subsection{Parameters}

\begin{itemize}
    \item $R_s, R_e$: Integer parameters representing the start time and end time (in minutes from 01.01.1970) of the period for schedule generation. The assumption is that all flights, pairings, and schedules are contained within this period.
    \item $C$: Set of crew (pilots).
    \item $F$: Set of non-cancelled flights.
    \item $P$: Set of pairings generated from flights $F$.
    \item $p_{if}$: Binary coefficient, where $p_{if} = 1$ if and only if pairing $i$ includes flight $f$.
    \item $s_{ic}$: Binary coefficient, where $s_{ic} = 1$ if and only if pairing $i$ was in the original schedule of crew $c$.
    \item $s_i, e_i$: Integer coefficients representing the start time and end time (in minutes from 01.01.1970) of pairing $i$.
    \item $C_u$: Cost of an unassigned flight.
    \item $C_a$: Cost of assigning a pairing that was not in the original plan.
    \item $C_d$: Cost of deassigning a pairing that was in the original plan.
    \item $C_m$: Unit cost if the pilot's original schedule was modified.
\end{itemize}

\subsection{Tasks}

\begin{itemize}
    \item Formulate the problem as an Integer Programming (IP) model.
    
\section*{Model Formulation}

\subsection*{Decision Variables}

\[
x_{ic} =
\begin{cases}
1 & \text{if pairing $i$ is assigned to crew $c$,} \\
0 & \text{otherwise.}
\end{cases}
\]

\[
y_c =
\begin{cases}
1 & \text{if crew $c$'s schedule is modified,} \\
0 & \text{otherwise.}
\end{cases}
\]

\[
z_c =
\begin{cases}
1 & \text{if crew $c$'s schedule is cleared,} \\
0 & \text{otherwise.}
\end{cases}
\]

\(\alpha_{if}\) is a binary parameter indicating whether pairing \(i\) covers flight \(f\):
\[
\alpha_{if} =
\begin{cases}
1 & \text{if pairing $i$ covers flight $f$,} \\
0 & \text{otherwise.}
\end{cases}
\]
\subsection*{Objective Function}

\[
\min \left( \sum_{f \in F} C_u \cdot \left(1 - \sum_{i \in P} \sum_{c \in C} \alpha_{if} x_{ic}\right) + \sum_{i \in P} \sum_{c \in C} C_a \cdot (1 - s_{ic}) x_{ic} + \sum_{i \in P} \sum_{c \in C} C_d \cdot s_{ic} (1 - x_{ic}) + \sum_{c \in C} C_m \cdot y_c \right)
\]

\subsection*{Constraints}

\begin{enumerate}
    \item \textbf{Flight Coverage:}
    \[
    \sum_{i \in P} \sum_{c \in C} \alpha_{if} x_{ic} \leq 1, \quad \forall f \in F
    \]
    \[
    \sum_{c \in C}x_{ic} \geq \alpha_{if} , \quad \forall f \in F, i \in P
    \]
The second constraint can be removed, it's just to avoid assigning a flight to a pairing and leave it.
    \item \textbf{Crew Assignment:}
    \[
    x_{ic} + x_{jc} \leq 1, \quad \forall c \in C, \forall i, j \in P \text{ where } [s_i, e_i] \cap [s_j, e_j] \neq \emptyset
    \]

    \item \textbf{Rest Periods:}
    \[
    e_i x_{ic} + 600 \leq s_j x_{jc} + M(2 - x_{ic} - x_{jc}), \quad \forall c \in C, \forall i, j \in P \text{ where } e_i < s_j
    \]

    \item \textbf{Cleared Schedules:}
    \[
    \sum_{c \in C} z_c \geq \lceil 0.2 \cdot |C| \rceil
    \]

    \item \textbf{No Pairings for Cleared Crews:}
    \[
    \sum_{i \in P} x_{ic} \leq M(1 - z_c), \quad \forall c \in C
    \]

    \item \textbf{Schedule Modification Definition:}
    \[
    y_c \geq x_{ic} - s_{ic}, \quad \forall c \in C, \forall i \in P
    \]
    \[
    y_c \geq s_{ic} - x_{ic}, \quad \forall c \in C, \forall i \in P
    \]
\end{enumerate}

\subsection*{Binary Constraints}

\[
x_{ic}, y_c, z_c \in \{0, 1\}, \quad \forall c \in C, \forall i \in P
\]

\item Assuming there must be two pilots on a flight, how would the model formulation change?

\[
    \sum_{i \in P} \sum_{c \in C} \alpha_{if} x_{ic} \leq 2, \quad \forall f \in F
    \]
\[
\sum_{c \in C}x_{ic} = 2\alpha_{if} , \quad \forall f \in F, i \in P
\]

\item How would you tackle solving this model, considering that the enumerated set of possible pairings can be large?

To efficiently solve this model with a large set of possible pairings, I would primarily go for column generation. This technique starts with a restricted master problem (RMP)containing only a subset of pairings, then iteratively adds new pairings with reduced cost coming from a pricing subproblem until no more reduced cost is observed. 
Additionally, depending on how my approach is going I might consider Branch-and-price, Heuristics or even going for Parallel computing on GPU.

There are so many ways to address this issue. I might prefer to start with Heuristic since it's the simplest approach. For the sake of a high-quality solution, I would rather start with column generation.
\end{itemize}


Note: I am trying to write C++ code for this model and solve it using OR-Tools (since it is open source). You can watch my progress on \href{https://github.com/maryamhmt/CrewSchedulingOptimizer}{Crew Scheduling Repository}.

\end{document}

 
 
 
 To compile:
 
 g++ -std=c++17 -I/usr/local/opt/or-tools/include -I/usr/local/include -Iinclude -L/usr/local/opt/or-tools/lib -L/usr/local/Cellar/abseil/20240722.0/lib -L/usr/local/lib -lortools -labsl_base -labsl_cord -labsl_strings -labsl_synchronization -labsl_time -lprotobuf src/main.cpp src/CrewScheduling.cpp -o CrewSchedulingOptimizer

To run:
 ./CrewSchedulingOptimizer
