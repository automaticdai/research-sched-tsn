N = 20;         % number of packets
U_bar = 0.9;    % desired utilization

n_All = 1000;   % number of packet sets
n_P_DM = 0;     % number of schedulable packet sets
n_Q_DM = 0;
n_Q_RND = 0;

n = 0;
while (n < n_All)
    disp(n)
    
    % generate a taskset
    taskset = taskset_gen(N, U_bar);
    
    % P-DM
    bSched = rta.schedulabilityTest(taskset);
    if bSched == true
        n_P_DM = n_P_DM + 1;
    end
    
    % Q-DM
    if N == 10
        p = [8 7 6 5 4 3 2 2 1 1];
    end
    
    if N == 20
        p = [8 8 7 7 6 6 5 5 4 4 4 3 3 3 2 2 2 1 1 1];
    end
    
    taskset(:,4) = p';

    bSched = rta.schedulabilityTest(taskset);
    if bSched == true
        n_Q_DM = n_Q_DM + 1;
    end    
    
    % Q-RND
    % (this has to be the last, as priority are changed)
    for i = 1:N
        taskset(i, 4) = floor(rand(1) * N + 1);
    end
    
    bSched = rta.schedulabilityTest(taskset);
    if bSched == true
        n_Q_RND = n_Q_RND + 1;
    end    
    
    n = n + 1;
end
