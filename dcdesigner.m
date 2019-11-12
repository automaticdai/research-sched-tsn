% Digital Control Designer
function tss = dcdesigner(poles)

%% Desired pole
% [0 - 1]
%poles = [-2+3.1622i   -2-3.1622i];


%% System Model
num = 1;
den = [1 0.05 10];
%Ts = 0.1;

%sys_tf = tf(num,den);
%figure(1)
%step(sys)
%grid on
%hold off

disp('Open Loop:')
roots(den)


%% Pole placement design
% State State Model
[A,B,C,D] = tf2ss(num,den);
%sys_ss = ss(A,B,C,D);
%sys_ss_d = c2d(sys_ss, Ts, 'zoh');

% pole placement
K = place(A, B, poles);

% closed-loop
A_dot = A - B * K;
B_dot = B;
C_dot = C;
D_dot = D;

sys_cl = ss(A_dot, B_dot, C_dot, D_dot);

% Eigen value of A
disp('Closed Loop:')
eig(A_dot)

[time, data] = step(sys_cl);

step(sys_cl)

pi = stepinfo(sys_cl, 'SettlingTimeThreshold', 0.05);

% Settling_Time
tss = pi.SettlingTime;

end