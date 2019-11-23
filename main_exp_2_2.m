% Find the value function for all control tasks

clear; clc;

addpath('tasksets')
addpath('plants')
addpath('data')
addpath('rta')

global Ts
global U_MAX
global p

%% Parameters
% control system (continous)
syss_param = [0.01,0.1,0.01,1,0.5;
              0.012,0.11,0.01,1,0.51;
              0.014,0.12,0.01,1,0.52];

T_list = [0.5, 1, 2, 5, 10, 20, 50, 100, 200] * 10^-3;
num_all = numel(T_list);
U_MAX = 24; % input constraint


for sys_idx = 1:size(syss_param,1)
    
    p = dc_motor(syss_param(sys_idx,:)); % dynamics
    
    tss_best_a = zeros(num_all,1); 
    x1_best_a = zeros(num_all,1);
    x2_best_a = zeros(num_all,1);

    for idx = 1:num_all
        Ts = T_list(idx);
        [tss_best, x1_best, x2_best] = pso();
        tss_best_a(idx) = tss_best;
        x1_best_a(idx) = x1_best;
        x2_best_a(idx) = x2_best;
        %Ts = Ts + 0.001;
    end


    %% Save results
    filename_str = sprintf('./data/v_p%d_ts.mat', sys_idx);
    save(filename_str,"tss_best_a","x1_best_a","x2_best_a")

end