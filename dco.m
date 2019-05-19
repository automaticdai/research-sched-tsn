% design an optimal digital controller

A = [1];
B = [1];
C = [1];
D = [0];

sys = ss(A,B,C,D);