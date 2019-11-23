sys1 = dc_motor([0.01,0.1,0.01,1,0.5])
subplot(3,1,1)
step(sys1)

sys2 = dc_motor([0.012,0.11,0.01,1,0.51])
subplot(3,1,2)
step(sys2)

sys3 = dc_motor([0.014,0.12,0.01,1,0.52])
subplot(3,1,3)
step(sys3)

