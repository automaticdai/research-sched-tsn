function [tss_best, x1_best, x2_best] = pso()
% -----------------------------------
% PSO Control Poles Optimization
% This function is written using PSO to solve control poles.
% Current version only support second-order systems!
% 
% To increase the efficieny of the PSO this version is a vectorized version
% for MATLAB.
%
% -----------------------------------
% Xiaotian Dai, University of York
% Credit to: Reza Ahmadzadeh
% -----------------------------------

%% initialization
swarm_size = 64;                        % number of the swarm particles
maxIter = 50;                           % maximum number of iterations
inertia = 1.0;
correction_factor = 2.0;

% set the position of the initial swarm
a = 0:7;
b = 0:7;
[X,Y] = meshgrid(a,b);
C = cat(2, X', Y');
D = reshape(C,[],2);
swarm(1:swarm_size,1,1:2) = D;          % set the position of the particles in 2D
swarm(:,2,:) = 0;                       % set initial velocity for particles
swarm(:,4,1) = 1000;                    % set the best value so far
b_plot = 1;                             % set to zero if you do not need a final plot


%% The main loop of PSO
%tic;

for iter = 1:maxIter
    swarm(:, 1, 1) = swarm(:, 1, 1) + swarm(:, 2, 1)/1.3;       % update x position with the velocity
    swarm(:, 1, 2) = swarm(:, 1, 2) + swarm(:, 2, 2)/1.3;       % update y position with the velocity
    x = swarm(:, 1, 1);                                         % get the updated position
    y = swarm(:, 1, 2);                                         % updated position
    fval = pso_obj_func([x y]);                                 % evaluate the function using the position of the particle
    
    % compare the function values to find the best ones
    for ii = 1:swarm_size
        if fval(ii,1) < swarm(ii,4,1)
            swarm(ii, 3, 1) = swarm(ii, 1, 1);                  % update best x position,
            swarm(ii, 3, 2) = swarm(ii, 1, 2);                  % update best y postions
            swarm(ii, 4, 1) = fval(ii,1);                       % update the best value so far
        end
    end
    
    [~, gbest] = min(swarm(:, 4, 1));                           % find the best function value (minimal) in total
    
    % update the velocity of the particles
    swarm(:, 2, 1) = inertia*(rand(swarm_size,1).*swarm(:, 2, 1)) + correction_factor*(rand(swarm_size,1).*(swarm(:, 3, 1) ...
        - swarm(:, 1, 1))) + correction_factor*(rand(swarm_size,1).*(swarm(gbest, 3, 1) - swarm(:, 1, 1)));   %x velocity component
    swarm(:, 2, 2) = inertia*(rand(swarm_size,1).*swarm(:, 2, 2)) + correction_factor*(rand(swarm_size,1).*(swarm(:, 3, 2) ...
        - swarm(:, 1, 2))) + correction_factor*(rand(swarm_size,1).*(swarm(gbest, 3, 2) - swarm(:, 1, 2)));   %y velocity component
    
    % plot the particles
    if b_plot
        clf;plot(swarm(:, 1, 1), swarm(:, 1, 2), 'bx');             % drawing swarm movements
        axis([-10 10 -10 10]);
        pause(.1);                                                  % un-comment this line to decrease the animation speed
    end
    
    tss_best = swarm(gbest, 4, 1);
    x1_best = swarm(gbest, 1, 1);
    x2_best = swarm(gbest, 1, 2);
    
    disp(['iteration: ' num2str(iter) ', best: ' num2str(tss_best)]);
end

%toc

end