
taskset_arr = [1 2 3 4 5; 6 7 8 9 10; 11 12 13 14 15; 16 17 18 19 20];

% convert to Java Array<Integer> 
x1 = 4;
x2 = 5;
taskset = javaArray('java.lang.Integer',x1,x2);

for m = 1:x1
    for n = 1:x2
        taskset(m,n) = java.lang.Integer(taskset_arr(m,n));
    end
end

taskset

% run GA

% check schedulability
h = analysis.rta;

ret = h.schedulabilityTest([1 2 3 1 0; 2 2 3 2 0]);

disp(ret)
%bSched = h.schedulabilityTest(taskset);

% plot results
