% Objective function for PSO
function obj_arr = psoobj(xy)
    m_size = size(xy);
    obj_arr = zeros(m_size(1),1);
    
    for i = 1:m_size(1)
       x = -1 * xy(i,1);
       y = xy(i,2);
       poles = [x + y * 1i   x - y * 1i];
       tss = dcdesigner(poles);
       obj_arr(i) = tss;
    end
end
