sys1 = dc_motor([0.01,0.1,0.01,1,0.5])
subplot(3,1,1)
step(sys1)

sys2 = dc_motor([0.10,0.2,0.01,1,0.55])
subplot(3,1,2)
step(sys2)

sys3 = dc_motor([0.15,0.3,0.01,1,0.6])
subplot(3,1,3)
step(sys3)

