format long g

% Parameters
N = 20;                        % number of tasks
U_bar = 0.95;                  % desired utilization

taskset = taskset_gen(N, U_bar);

% print result
Ci = taskset(:,1);
Ti = taskset(:,2);
A = sym(Ti);
LCM = lcm(A)

fprintf('\r Generated Taskset (Ci, Ti, Di, Pi, Ji): \r\r');
disp(taskset);

fprintf('The actual task total utilization is: %0.3f \r', sum(Ci ./ Ti));

% schedulability check
bSched = rta.schedulabilityTest(taskset);
Response_Time = rta.ResponseTimeAnalysis(taskset)

if (bSched)
    disp("Packet set is schedulable.")
else
    disp("Error: Packet set is unschedulable.")
end

% save dataset
%filename = sprintf("taskset_u_%0.2f.mat", U_bar);
%taskset_nc = taskset;
%save(filename, 'taskset_nc');