# --- Parameters: defaults can be overwritten with .dat file

set Operations    ordered;

param Delay {Operations} integer >= 0 default 1;
param Before {Operations, Operations} binary default 0;

# --- Variable: Tscheduled[op] is time at which op starts

var Tscheduled {op in Operations} integer >= 0;

var MaxLatency integer >= 0;

# --- Optimization goal

minimize Latency: MaxLatency;

# No good since nonlinear:   
# max {op in Operations} (Tscheduled[op] + Delay[op]);
# use constraint ComputeLatency instead!

# --- Constraints

subject to ComputeLatency {op in Operations}:
   MaxLatency >= Tscheduled[op] + Delay[op];

subject to Feasibility {o1 in Operations, o2 in Operations
                        : Before[o1,o2] }:
   Tscheduled[o1] + Delay[o1] <= Tscheduled[o2];
