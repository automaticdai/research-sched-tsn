% system dynamics generator

numerator = 1;
denominator = [0.01,0.3,40];
sys = tf(numerator,denominator);

step(sys);

