% Objective function for PSO
function obj_arr = pso_obj_func(xy)
    m_size = size(xy);
    obj_arr = zeros(m_size(1),1);
    
    for i = 1:m_size(1)
       x1 = xy(i,1);
       x2 = xy(i,2);
       if (x2 == 0)
            x2 = x2 + 1e-6;
       end
       poles = [x1 + x2*1i   x1 - x2*1i];
       tss = dcdesigner(poles);
       obj_arr(i) = tss;
    end
end
