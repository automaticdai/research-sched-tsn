
sys1 = dc_motor(0.01,0.1,0.01,1,0.5);
step(sys1)

sys2 = dc_motor(0.10,0.2,0.01,1,0.55);
hold on;
step(sys2)

sys3 = dc_motor(0.15,0.3,0.01,1,0.6);
hold on;
step(sys3)


sys1
sys2
sys3