% Find candidate solution space by exhausive search

clear; clc;

addpath('tasksets')
addpath('plants')
addpath('data')
addpath('rta')

javaaddpath(strcat(pwd(),'/rta/rta.jar'));

spmd   
    javaaddpath(strcat(pwd(),'/rta/rta.jar'));
end

%% Define Parameters
% scheduling system
N = 10;                           % number of packets
U_bar = [0.70 0.75 0.80 0.85 0.90 0.95];    % desired utilization

N_c = 3;                          % number of control packets
C_i = 120;                        % C_i of control packets

search_range = [1 100] * 1000;
search_step = 1000;
%search_space = search_range(1):search_step:search_range(2);

search_space = [0.5, 1, 2, 5, 10, 20, 50, 100, 200] * 10^3;

search_numel = numel(search_space);


%% this is one experiment
% generate a taskset

for kk = 1:1000
    for u_idx = 1:numel(U_bar)
        U_bar_this = U_bar(u_idx);

        fprintf("%0.2f, %d \n", U_bar_this, kk)

        taskset_nc = taskset_gen(N, U_bar_this);
        candidate_solutions = zeros(search_numel,search_numel,search_numel);

        parfor i = 1:search_numel
            rta = analysis.RTA;
            for j = 1:search_numel
                for k = 1:search_numel 
                    % add control packets 
                    Ti = search_space(i);
                    taskset_c1 = [C_i, Ti, Ti, -1, ceil(C_i/100)];

                    Tj = search_space(j);
                    taskset_c2 = [C_i, Tj, Tj, -1, ceil(C_i/100)];           

                    Tk = search_space(k);
                    taskset_c3 = [C_i, Tk, Tk, -1, ceil(C_i/100)];

                    taskset = [taskset_nc; taskset_c1; taskset_c2; taskset_c3];

                    % reorder priorities by deadlines
                    taskset = sortrows(taskset, 3, 'ascend');
                    Pi = ((N-1+N_c):-1:0)';
                    taskset(:,4) = Pi;            

                    % test schedulability
                    bSched = rta.schedulabilityTest(taskset);

                    % if scheduable, add as a candidate solution
                    if bSched
                        candidate_solutions(i,j,k) = 1;
                    end
                end
            end
        end

        % save file
        filename_str = sprintf('./data/s_%0.2f_%d_%d.mat', U_bar_this, N, kk);
        save(filename_str,'candidate_solutions', 'taskset_nc')
    end
end
