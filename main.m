% [C_i, T_i, D_i, P_i, J_i]
% read a taskset
h = analysis.rta;

taskset_arr = [1 2 3 1 0; 2 2 3 2 0];

% run GA

    % check schedulability
    bSched = h.schedulabilityTest(taskset_arr);
    disp(bSched)
    
    % run PSO
    % generate population
    % check input constraint
    % update the speed
    
%bSched = h.schedulabilityTest(taskset);

%%
[t,x,u] = ltisim_d([0 10], [0.5 0.2], 0.3, [0.25;0.4], 100, 0.01);

% plot results
subplot(2,1,1);
plot(t, x);
subplot(2,1,2);
plot(t, u);

% save results
