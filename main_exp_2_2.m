% Find the value function for all control tasks

clear; clc;

%% Define Parameters
% scheduling system
N = 10;         % number of packets
U_bar = 0.2;    % desired utilization

%taskset = taskset_gen(N, U_bar);
%bSched = rta.schedulabilityTest(taskset);

% control system
syss_param = [0.01,0.1,0.01,1,0.5;
              0.10,0.2,0.01,1,0.55;
              0.15,0.3,0.01,1,0.6];

w1 = 0.8;
w2 = 0.6;
w3 = 0.4;

J = 0;
j1 = 0;
j2 = 0;
j3 = 0;


%% Simulate
% control system (continous)
x0 = [1; 0];

p = dc_motor(syss_param(1,:));
A = p.A;
B = p.B;
C = p.C;
D = p.D;

K = [2.165 0.21];
Ns = 2000;
dt = 0.001;
Ts = 0.001;

Acl = A + B * K;
pcl = ss(Acl,B,C,D);

% control system (discrete)


%% check closed-loop stability
eig(Acl)
if (max(eig(Acl)) >= 0)
    disp("[Error] Unstable system!")
else
    disp("System is stable.")
end


%% Run LTI simulation
[t, x, u] = ltisim(x0, A, B, K, Ns, dt);


% pd = c2d(p, Ts);
%
% Ad = pd.A;
% Bd = pd.B;
% Cd = pd.C;
% Dd = pd.D;


%% Plot results
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


%% Save results
%save()