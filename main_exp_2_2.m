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
              0.10,0.2,0.01,1,0.55;
              0.15,0.3,0.01,1,0.6];

sys_idx = 3;
p = dc_motor(syss_param(sys_idx,:)); % dynamics
Ts = 0.001;   % sampling time
U_MAX = 12; % input constraint

tss_best_a = zeros(100,1); 
x1_best_a = zeros(100,1);
x2_best_a = zeros(100,1);

for i = 1:100
    [tss_best, x1_best, x2_best] = pso();
    tss_best_a(i) = tss_best;
    x1_best_a(i) = x1_best;
    x2_best_a(i) = x2_best;
    Ts = Ts + 0.001;
end

%poles = [-5+0.1622i  -5-0.1622i];
%tss = dcdesigner(poles);


%%
% for sys_i = 1:size(syss_param,1)
%     p = dc_motor(syss_param(sys_i,:));
% end


%% Save results
save("result2-2.mat","tss_best_a","x1_best_a","x2_best_a")