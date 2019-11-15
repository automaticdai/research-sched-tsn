%% Define Dataset
% [C_i, T_i, D_i, P_i, J_i]
% read a taskset
h = analysis.rta;

taskset_arr = [1 2 3 1 0; 2 2 3 2 0];


%% Test Schedulability
% run GA

% check schedulability
bSched = h.schedulabilityTest(taskset_arr);
disp(bSched);

% run PSO
% generate population
% check input constraint
% update the speed
    
%bSched = h.schedulabilityTest(taskset);


%% Run LTI simulation
x0 = [0; 10];
Ad = [0.8 0.15; 0.4 0.35];
Bd = 0.35;
K = [0.15 0.05];
Ns = 200;
Ts = 0.01;

Acl = Ad + Bd * K;

eig(Acl)

if (max(abs(eig(Acl))) >= 1)
    disp("Unstable system!")
end

[t,x,u] = ltisim_d(x0, Ad, Bd, K, Ns, Ts);


%% plot results
subplot(2,1,1);
for i = 1:size(x0,1)
    plot(t, x(:,i));
    hold on;
end
ylabel("States: x_k")
subplot(2,1,2);
plot(t, u);
ylabel("Intpus: u_k")


%% Save results
%save()