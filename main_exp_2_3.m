% Searching the maximum value

clear; clc;

addpath('tasksets')
addpath('plants')
addpath('data')
addpath('rta')

%% Parameters
w1 = 0.5;
w2 = 0.3;
w3 = 0.2;

j1 = 0;
j2 = 0;
j3 = 0;



J = w1 * j1 + w2 * j2 + w3 * j3;
