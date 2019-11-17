clear; clc;


%% Define Parameters
% control system
x0 = [10; 0];

A = [-10     1;
     -0.02  -2];
B = [0; 2];
C = [1 0];
D = [0];
p = ss(A,B,C,D);

K = [0.25 0.21];
Ns = 1000;
dt = 0.001;
Ts = 0.001;

Acl = A + B * K;
pcl = ss(Acl,B,C,D);


%% check closed-loop stability
eig(Acl)
if (max(abs(eig(Acl))) >= 1)
    disp("Unstable system!")
end


%% Run LTI simulation
[t, x, u] = ltisim(x0, A, B, K, Ns, dt);


% pd = c2d(p, Ts);
%
% Ad = pd.A;
% Bd = pd.B;
% Cd = pd.C;
% Dd = pd.D;


%%
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