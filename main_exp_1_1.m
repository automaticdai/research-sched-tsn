clear; clc;

rta = analysis.RTA;

% taskset
% [C_i, T_i, D_i, P_i, J_i]

taskset  = 	[ 6, 2200,  896,  10, 1;
			 10, 1400, 1382,  9,  1;
			414, 2700, 1723,  8,  5;
			112, 2400, 2016,  7,  2;
			 29, 3100, 2323,  6,  1;
			 88, 2800, 2744,  5,  1;
			 64, 4400, 2949,  4,  1;
			288, 6200, 3605,  3,  3;
			518, 5800, 4800,  2,  6;
			793, 8900, 7607,  1,  8];

        
%% Test Schedulability
% run GA

% check schedulability
% bSched = h.schedulabilityTest(taskset_arr);
% disp(bSched);

% run PSO
% generate population
% check input constraint
% update the particle speed

bSched = rta.schedulabilityTest(taskset);

Response_Time = rta.ResponseTimeAnalysis(taskset)

if (bSched)
    disp("Packet set is schedulable.")
else
    disp("Error: Packet set is unschedulable.")
end
