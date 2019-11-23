% Searching the maximum value

clear; clc;

addpath('tasksets')
addpath('plants')
addpath('data')
addpath('rta')


%% Parameters
T_list = [0.5, 1, 2, 5, 10, 20, 50, 100, 200] * 10;
U_bar = [0.70 0.75 0.80 0.85 0.90 0.95];

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


%% Main
S_f_a = [];
S_f_a_idx = [];
n_f_a = [];
n_nf_a = [];
J_avg_a = [];

% Open a feasible candidates
for u_bar_idx = 1:6
    U_bar_this = U_bar(u_bar_idx);
    N = 10;
    J_sum = 0;

    n_f = 0;    % # of feasible solutions
    S_f = [];   % list of feasible solutions
    n_nf = 0;   % # of infeasible solutions

    for kk = 1:1000
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
            J_sum = J_sum + s_hat(1);
            n_f = n_f + 1;
            S_f = [S_f; s_hat(1)];
        else
            fprintf('%d: [] \n', kk);
            n_nf = n_nf + 1;
        end

    end

    J_avg = J_sum / n_f;
    fprintf('%f, %d, %d \n', J_avg, n_f, n_nf);
    
    J_avg_a = [J_avg_a; J_avg];
    n_f_a = [n_f_a; n_f];
    n_nf_a = [n_nf_a; n_nf];
    S_f_a = [S_f_a; S_f];
    S_f_a_idx = [S_f_a_idx; ones(n_f, 1) * U_bar_this];
    
end


%% plot results
close all;
figure()
boxplot(S_f_a, S_f_a_idx, 'whisker',2)
xlabel("Network Load")
ylabel("Control Cost (normalized)")

figure()
plot(U_bar, J_avg_a, 'rd-.')
xlabel("Network Load")
ylabel("Average Control Cost (normalized)")

figure()
plot(U_bar, n_f_a / 1000 * 100, 'bd-.')
xlabel("Network Load")
ylabel("Schedule Packet Sets (precentage)")
