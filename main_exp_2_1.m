% Find candidate solution space by exhausive search

clear; clc;

rta = analysis.RTA;

%% Define Parameters
% scheduling system
N = 10;         % number of packets
U_bar = 0.5;    % desired utilization

N_c = 3;        % number of control packets

search_range = [1 100] * 1000;
search_step = 1000;
search_space = search_range(1):search_step:search_range(2);
search_numel = numel(search_space);


%% this is one experiment
% generate a taskset
taskset_nc = taskset_gen(N, U_bar);
candidate_solution_space = [];

for i = 1:search_numel
    disp(i / search_numel * 100)
    for j = 1:search_numel
        for k = 1:search_numel
            % add control packets 
            Ti = search_space(i);
            taskset_c1 = [120, Ti, Ti, -1, 2];
            
            Tj = search_space(j);
            taskset_c2 = [120, Tj, Tj, -1, 2];           
            
            Tk = search_space(k);
            taskset_c3 = [120, Tk, Tk, -1, 2];
            
            taskset = [taskset_nc; taskset_c1; taskset_c2; taskset_c3];

            % reorder priorities by deadlines
            taskset = sortrows(taskset, 3, 'ascend');
            Pi = (N-1+N_c:-1:0)';
            taskset(:,4) = Pi;

            % test schedulability
            bSched = rta.schedulabilityTest(taskset);

            % if scheduable, add as a candidate solution
            if bSched
                candidate_solution_space = [candidate_solution_space; Ti, Tj, Tk];
            end
        end
    end
end
