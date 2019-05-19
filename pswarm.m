% PSO : Particle Swarm Optimization (VECTORIZED)
% particle swarm optimization (PSO) is a computational method that 
% optimizes a problem by iteratively trying to improve a candidate 
% solution with regard to a given measure of quality. PSO optimizes 
% a problem by having a population of candidate solutions, here dubbed 
% particles, and moving these particles around in the search-space 
% according to simple mathematical formulae over the particle's position 
% and velocity. Each particle's movement is influenced by its local best 
% known position but, is also guided toward the best known positions 
% in the search-space, which are updated as better positions are found 
% by other particles. This is expected to move the swarm toward the best solutions.
%
% this function is written as a simple example of PSO
% in order to optimiza other functions you have to change the objective
% function.
%
% to increase the efficieny of the PSO this version is a vectorized version
% for MATLAB.
%
% -----------------------------------
% code: REZA AHMADZADEH  (based on the original code by Wesam Elshamy)
% (reza.ahmadzadeh@iit.it)
% -----------------------------------
clc;clear all;close all;

%% initialization
%
swarm_size = 64;                       % number of the swarm particles
maxIter = 50;                          % maximum number of iterations
inertia = 1.0;
correction_factor = 2.0;
% set the position of the initial swarm
a = 1:8;
[X,Y] = meshgrid(a,a);
C = cat(2,X',Y');
D = reshape(C,[],2);
swarm(1:swarm_size,1,1:2) = D;          % set the position of the particles in 2D
swarm(:,2,:) = 0;                       % set initial velocity for particles
swarm(:,4,1) = 1000;                    % set the best value so far
plotObjFcn = 1;                         % set to zero if you do not need a final plot

%% define the objective funcion here (vectorized form)
objfcn =  @(x)(x(:,1) - 20).^2 + (x(:,2) - 25).^2;
tic;






%% The main loop of PSO
for iter = 1:maxIter
    swarm(:, 1, 1) = swarm(:, 1, 1) + swarm(:, 2, 1)/1.3;       %update x position with the velocity
    swarm(:, 1, 2) = swarm(:, 1, 2) + swarm(:, 2, 2)/1.3;       %update y position with the velocity
    x = swarm(:, 1, 1);                                         % get the updated position
    y = swarm(:, 1, 2);                                         % updated position
    fval = objfcn([x y]);                                       % evaluate the function using the position of the particle
    
    % compare the function values to find the best ones
    for ii = 1:swarm_size
        if fval(ii,1) < swarm(ii,4,1)
            swarm(ii, 3, 1) = swarm(ii, 1, 1);                  % update best x position,
            swarm(ii, 3, 2) = swarm(ii, 1, 2);                  % update best y postions
            swarm(ii, 4, 1) = fval(ii,1);                       % update the best value so far
        end
    end
    
    [~, gbest] = min(swarm(:, 4, 1));                           % find the best function value in total
    
    % update the velocity of the particles
    swarm(:, 2, 1) = inertia*(rand(swarm_size,1).*swarm(:, 2, 1)) + correction_factor*(rand(swarm_size,1).*(swarm(:, 3, 1) ...
        - swarm(:, 1, 1))) + correction_factor*(rand(swarm_size,1).*(swarm(gbest, 3, 1) - swarm(:, 1, 1)));   %x velocity component
    swarm(:, 2, 2) = inertia*(rand(swarm_size,1).*swarm(:, 2, 2)) + correction_factor*(rand(swarm_size,1).*(swarm(:, 3, 2) ...
        - swarm(:, 1, 2))) + correction_factor*(rand(swarm_size,1).*(swarm(gbest, 3, 2) - swarm(:, 1, 2)));   %y velocity component
    
    % plot the particles
    clf;plot(swarm(:, 1, 1), swarm(:, 1, 2), 'bx');             % drawing swarm movements
    axis([-2 40 -2 40]);
    pause(.1);                                                 % un-comment this line to decrease the animation speed
    disp(['iteration: ' num2str(iter)]);
end
toc

%% plot the function
if plotObjFcn
    ub = 40;
    lb = 0;
    npoints = 1000;
    x = (ub-lb) .* rand(npoints,2) + lb;
    for ii = 1:npoints
        f = objfcn([x(ii,1) x(ii,2)]);
        plot3(x(ii,1),x(ii,2),f,'.r');hold on
    end
    plot3(swarm(1,3,1),swarm(1,3,2),swarm(1,4,1),'xb','linewidth',5,'Markersize',5);grid
end
