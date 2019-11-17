clear; clc;


%% Define Parameters
% taskset
% [C_i, T_i, D_i, P_i, J_i]
taskset_arr = [1 2 3 1 0; 2 2 3 2 0];

% control system
x0 = [0; 10; 0];
A = [0    -0.15   0;
     0.23  0     -0.28;
     0     0     -0.25];
B = [0.15;0.15;0.5];
C = [1 0 0];
D = [0];
K = [0.25 0.21 0.01];
Ns = 1000;
dt = 0.1;
Ts = 0.1;

Acl = A + B * K;

eig(Acl)

[t, x, u] = ltisim(x0, A, B, K, Ns, dt);

% p = ss(A,B,C,D);
% pd = c2d(p, Ts);
%
% Ad = pd.A;
% Bd = pd.B;
% Cd = pd.C;
% Dd = pd.D;



% plot states
subplot(2,1,1);
for i = 1:size(x,2)
    stairs(t, x(:,i));
    hold on;
end
ylabel("States: x_k")
xlabel("t")

% plot inputs
subplot(2,1,2);
for i = 1:size(u,2)
    stairs(t, u(:,i));
    hold on;
end
ylabel("Intpus: u_k")
xlabel("t")




%% Test Schedulability
% run GA

% check schedulability
% bSched = h.schedulabilityTest(taskset_arr);
% disp(bSched);

% run PSO
% generate population
% check input constraint
% update the particle speed


% h = analysis.rta;
% bSched = h.schedulabilityTest(taskset);


%% Run LTI simulation


if (max(abs(eig(Acl))) >= 1)
    disp("Unstable system!")
end

[t,x,u] = ltisim_d(x0, Ad, Bd, K, Ns, Ts);


%% plot results
subplot(2,1,1);
for i = 1:size(x0,1)
    stairs(t, x(:,i));
    hold on;
end
ylabel("States: x_k")

subplot(2,1,2);
stairs(t, u);
ylabel("Intpus: u_k")


%% Save results
%save()