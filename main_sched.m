%clear; clc;

h = analysis.rta;

% taskset
% [C_i, T_i, D_i, P_i, J_i]
%taskset_arr = [1 2 3 1 0; 
%               2 2 3 2 0];


%% Test Schedulability
% run GA

% check schedulability
% bSched = h.schedulabilityTest(taskset_arr);
% disp(bSched);

% run PSO
% generate population
% check input constraint
% update the particle speed

bSched = h.schedulabilityTest(taskset);

bSched



%% Save results
%save()