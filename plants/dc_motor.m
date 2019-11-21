function sys = dc_motor(params)
% system dynamics (DC motor)
% (J)     moment of inertia of the rotor     0.01 kg.m^2
% (b)     motor viscous friction constant    0.1 N.m.s
% (Ke)    electromotive force constant       0.01 V/rad/sec
% (Kt)    motor torque constant              0.01 N.m/Amp
% (R)     electric resistance                1 Ohm
% (L)     electric inductance                0.5 H

J = params(1);
b = params(2);
K = params(3);
R = params(4);
L = params(5);

A = [-b/J   K/J
    -K/L   -R/L];
B = [0
    1/L];
C = [1   0];
D = 0;

sys = ss(A,B,C,D);

% system order
sys_order = order(sys);

% verfify the controllability
sys_rank = rank(ctrb(A,B));
