% [C_i, T_i, D_i, P_i, J_i]
% read a taskset
taskset_arr = [1 2 3 3 1; 1 5 5 2 1; 1 12 12 3 1; 1 17 17 4 1];

taskset_arr

% run GA

% check schedulability
h = analysis.rta;

ret = h.schedulabilityTest([1 2 3 1 0; 2 2 3 2 0]);

disp(ret)
%bSched = h.schedulabilityTest(taskset);

% plot results


% save results 

% 
