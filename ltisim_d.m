% Simulate the flow of a linear time-invariate discrete system
% note this is just an approximation!
function [t, x, u] = ltisim_d(x0, A, B, K, n, Ts)

x = zeros(1, n);
u = zeros(1, n);
t = zeros(1, n);

t(1) = 0;
x(1) = x0;
u(1) = x0 * K;
i = 2;

while (i < n)
    t(i) = t(i - 1) + Ts;
    x(i) = A * x(i-1) + B * u(i-1);
    u(i) = x(i) * K;
    i = i + 1;
end

end