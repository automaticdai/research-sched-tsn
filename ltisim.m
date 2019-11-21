function [t, x, u] = ltisim(x0, A, B, K, Ns, dt, Ts)
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

num_of_states = size(x0,1);
num_of_inputs = size(B,2);

t = zeros(Ns, 1);
x = zeros(Ns, num_of_states);
u = zeros(Ns, num_of_inputs);

u_timer = Ts;
u_sampled_x = x0;

% i = 1
t(1) = 0;
x(1,:) = x0;
u(1,:) = K * x0;

% i >= 2
for i = 2:Ns
    t(i) = t(i - 1) + dt;
    x(i,:) = (A * x(i-1,:)' + B * u(i-1)) .* dt + x(i-1,:)';
    % update control output every Ts
    if u_timer > Ts
        u(i) = K * u_sampled_x;
        u_timer = 0;
        u_sampled_x = x(i,:)';
    else
        u(i) = u(i-1);
    end
    u_timer = u_timer + dt;
end

end