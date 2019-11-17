% task_generator.m
% generate synthetic task sets
format long g
%rng(5)


%% Parameters
N = 10;                            % number of tasks
U_bound = N * (power(2, 1/N) - 1); % utilization boundary
U_bar = 0.2;                       % desired utilization
Ti_lower = 10;                     % taskset period upper bound (x10)
Ti_upper = 100;                    % taskset period lower bound (x10)

Ui = zeros(N, 1);
Ci = zeros(N, 1);
Ti = zeros(N, 1);
Di = zeros(N, 1);


%% Generate task utilization with UUnifast
Ui = UUniFast(N, U_bar);
Ui = Ui';

% f1 = figure();
% histogram(Ui, 'Normalization', 'Probability')
% title('Utilization')


%% Generate task periods with log-uniformed distribution
% need harmonic period to avoid hyperperiod becomes too large
LA = log10(Ti_lower);
LB = log10(Ti_upper);
Ti = 10 .^ (LA + (LB-LA) * rand(1, N));
Ti = round(Ti') * 10;

% f2 = figure();
% histogram(Ti, 'Normalization', 'Probability')
% title('Periods')


%% Calculate task computation times
Ci = Ui .* Ti;


%% Put everything into taskset[], 
Di = (rand(N,1) / 2 + 0.5) .* Ti;
Pi = ones(N,1) * -1;
Ji = ones(N,1) * 1;
taskset = [ceil(Ci * 10), ceil(Ti * 10), ceil(Di * 10), Pi, Ji];

% truncate and sort with DM
taskset = sortrows(taskset, 3, 'ascend');
Pi = (0:N-1)';
taskset(:,4) = Pi;

% print result
fprintf('\r Generated Taskset (Ci, Ti, Di, Pi, Ji): \r\r');
disp(taskset);

fprintf('The actual task total utilization is: %0.3f \r', sum(taskset(:,1) ./ taskset(:,2)));

% save dataset
filename = sprintf("taskset_u_%0.2f.mat", U_bar);

taskset_nc = taskset;
save(filename, 'taskset_nc');