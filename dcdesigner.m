% Digital Control Designer
clc
clear all
close all

%%
% System Model
num = 1;
den = [1 0.05 10];
Ts = 0.1;

sys_tf = tf(num,den);

%figure(1)
%step(sys)
%grid on
%legend('pendulun')
%hold off

roots(den)


%%
% State State Model
[A,B,C,D] = tf2ss(num,den);
sys_ss = ss(A,B,C,D);
sys_ss_d = c2d(sys_ss, Ts, 'zoh');

% Desired pole
% [0 - 1]
poles = [-2+3.1622i   -2-3.1622i];

% pole placement
K = place(A, B, poles);

% closed-loop
A_dot = A - B * K;
B_dot = B;
C_dot = C;
D_dot = D;

sys_cl = ss(A_dot, B_dot, C_dot, D_dot);

% Eigen value of A
eig(A - B * K)

[Time, Data] = step(sys_cl);

pi = stepinfo(Data(:), Time(:), 'SettlingTimeThreshold',0.02);

Settling_Time = pi.SettlingTime