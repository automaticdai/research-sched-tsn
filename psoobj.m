function tsss = psoobj(xy)
    tsss = [];
    m_size = size(xy);
    
    for i = 1:m_size(1)
       x = -1 * xy(i,1);
       y = xy(i,2);
       poles = [x + y * 1i   x - y * 1i];
       tss = dcdesigner(poles);
       tsss = [tsss;tss];
    end
    
end