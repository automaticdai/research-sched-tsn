syss_param = [0.01,0.1,0.01,1,0.5;
              0.10,0.2,0.01,1,0.55;
              0.15,0.3,0.01,1,0.6];

poles = [-5+0.1622i  -5-0.1622i];

for sys_i = 1:size(syss_param,1)
    p = dc_motor(syss_param(sys_i,:));
    tss = dcdesigner(poles);
end