% Objective function for PSO
function tss_arr = psoobj(xy)
    m_size = size(xy);
    tss_arr = zeros(m_size(1),1);
    
    for i = 1:m_size(1)
       x = -1 * xy(i,1);
       y = xy(i,2);
       poles = [x + y * 1i   x - y * 1i];
       tss = dcdesigner(poles);
       tss_arr(i) = tss;
    end
end
