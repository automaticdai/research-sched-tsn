function [t, x, u] = ltisim_d(x0, Ad, Bd, K, Ns, Ts)
% LTISIM_D:
% Simulate the evolution of a linear time-invariate discrete-time system
%
% Inputs:
% - x0: initial condition
% - Ad: system matrix
% - Bd: input matrix 
% - K: control gain
% - Ns; simulation size
% - Ts: sampling period
%
% Outputs:
% - t: times
% - x: states
% - u: inputs
%
% Testset:
% [t,x,u] = ltisim_d(10, 0.5, 0.3, 1, 100, 0.01)

x = zeros(1, Ns);
u = zeros(1, Ns);
t = zeros(1, Ns);

% i = 1
t(1) = 0;
x(1) = x0;
u(1) = x0 * K;

% i >= 2
for i = 2:Ns
    t(i) = t(i - 1) + Ts;
    x(i) = Ad .* x(i-1) + Bd .* u(i-1);
    u(i) = x(i) .* K;
end

end