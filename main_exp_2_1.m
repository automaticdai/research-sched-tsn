% Find candidate solution space by exhausive search

clear; clc;

addpath('tasksets')
addpath('plants')
addpath('data')
addpath('rta')

javaaddpath(strcat(pwd(),'/rta/rta.jar'));
rta = analysis.RTA;

%spmd   
%javaaddpath(strcat(pwd(),'/rta/rta.jar'));
%end

%% Define Parameters
% scheduling system
N = 10;                           % number of packets
U_bar = [0.5 0.6 0.7 0.8 0.9];    % desired utilization

N_c = 3;                          % number of control packets

search_range = [1 100] * 1000;
search_step = 1000;
search_space = search_range(1):search_step:search_range(2);
search_numel = numel(search_space);


%% this is one experiment
% generate a taskset

for kk = 0:1000
    U_bar_this = U_bar(mod(kk,5) + 1);
    
    disp([kk U_bar_this])
    
    taskset_nc = taskset_gen(N, U_bar_this);
    candidate_solutions = zeros(search_numel,search_numel,search_numel);

    for i = 1:search_numel
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
        disp("Progress:" + (i) / (search_numel) * 100 + "%")
    end

    % save file
    filename_str = sprintf('./data/s_%0.2f_%d_%d.mat', U_bar_this, N, ceil(kk / 5 + 0.1));
    save(filename_str,'candidate_solutions')

end
