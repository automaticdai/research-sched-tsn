% system dynamics random generator
function sys_open = sys_gen(seed)

seed = 100;

num = [];
den = [];

sys_open = tf(num, den);

end
