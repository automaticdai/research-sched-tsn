function taskset = taskset_gen(N, U_bar)
% task_generator.m
% used to generate synthetic task sets

Ui = zeros(N, 1);
Ci = zeros(N, 1);
Ti = zeros(N, 1);
Di = zeros(N, 1);

%% Generate task utilization with UUnifast
Ui = UUniFast(N, U_bar);
Ui = Ui';


%% Generate task periods with harmonic period to avoid hyperperiod becomes too large
%log-uniform distribution
%LA = log10(Ti_L);
%LB = log10(Ti_U);
%Ti = 10 .^ (LA + (LB-LA) * rand(1, N));
%Ti = round(Ti');

T_list = [1,2,5,10,20,50,100,200,500,1000,2000,5000,10000] * 100;
idx = floor(rand(N,1) * 10 + 1);
Ti = T_list(idx)';


%% Calculate task computation times
Ci = Ui .* Ti;


%% Put everything into taskset[], 
Di = (rand(N,1) / 2 + 0.5) .* Ti;
Pi = ones(N,1) * -1;
Ji = ones(N,1) .* (Ci / 100);
taskset = [ceil(Ci), floor(Ti), floor(Di), Pi, ceil(Ji)];

% Prioirty assignment: truncate and sort with DM
taskset = sortrows(taskset, 3, 'ascend');
Pi = (N-1:-1:0)';
taskset(:,4) = Pi;

end
