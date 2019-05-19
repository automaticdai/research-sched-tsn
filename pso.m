% Particle Swarm Optimization
xx = []
yy = []
zz = []

for i = 1:100
    x = -rand(1) * 100;
    y = rand(1) * 100;
    poles = [x + 1i * y, x - 1i * y];

    tss = dcdesigner(poles);

    xx = [xx x];
    yy = [yy y];
    zz = [zz tss];
end

plot3(xx, yy, zz, 'x')
grid on;