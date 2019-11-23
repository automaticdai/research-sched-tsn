% Searching the maximum value

clear; clc;

addpath('tasksets')
addpath('plants')
addpath('data')
addpath('rta')


%% Parameters
T_list = [0.5, 1, 2, 5, 10, 20, 50, 100, 200] * 10;

% controller weightings
w1 = 0.5;
w2 = 0.3;
w3 = 0.2;

% pre-load and normalize performance profiles
v = zeros(3, 9);

load("data\v_p1_ts.mat")
v1 = tss_best_a;
v1n = ((v1 - min(v1)) ./ (max(v1) - min(v1)));

load("data\v_p2_ts.mat")
v2 = tss_best_a;
v2n = ((v2 - min(v2)) ./ (max(v2) - min(v2)));

load("data\v_p3_ts.mat")
v3 = tss_best_a;
v3n = ((v3 - min(v3)) ./ (max(v3) - min(v3)));

%plot([v1n v2n v3n])


%!!!!!!!!!!!!!!!!!!
v1n = v1;
v2n = v2;
v3n = v3;


%% Main
% Open a feasible candidates
U_bar_this = 0.9;
N = 10;
J_sum = 0;

for kk = 1:200
    filename_str = sprintf('./data/s_%0.2f_%d_%d.mat', U_bar_this, N, kk);
    load(filename_str)
    S = candidate_solutions;

    s_hat = [];
    J_hat = 100;
    
    for i = 1:9
        for j = 1:9
            for k = 1:9
                if S(i,j,k)
                    j1 = v1n(i);
                    j2 = v2n(j);
                    j3 = v3n(k);

                    J = w1 * j1 + w2 * j2 + w3 * j3;

                    if (J < J_hat)
                        s_hat = [J, i, j, k];
                        J_hat = J;
                    end
                end
            end
        end
    end

    if J_hat ~= 100
        fprintf('%d: %0.3f %d %d %d \n', kk, s_hat(1), s_hat(2), s_hat(3), s_hat(4));
        J_sum = J_sum + J;
    else
        fprintf('%d: [] \n', kk);
    end

end

J_sum / 200
