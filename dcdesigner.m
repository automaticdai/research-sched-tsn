% Digital Control Designer
function tss = dcdesigner(poles)
% Inputs:
% P is in continous-time state-space
% (Discrete time) Poles in the form of [-0.2+0.1622i   -0.2+0.1622i]

%% Parameters
b_plot = false;

global Ts
global U_MAX
global p

% LTI simulator parameters
x0 = [1; 0];
Ns = 5000;
dt = 0.001;


%% Pole placement design (to solve K)
% control system (continous)
A = p.A; B = p.B; C = p.C; D = p.D;
K = place(A, B, poles);


% control system (discrete)
pd = c2d(p, Ts, 'tustin');
Ad = pd.A; Bd = pd.B; Cd = pd.C; Dd = pd.D;

poles_d = exp(poles.*Ts); % poles in z-domain
Kd = place(Ad, Bd, poles_d);

Acl = Ad - Bd * Kd;

% check closed-loop stability
Acl_eig = eig(Acl);

% if (norm(Acl_eig(1),2) >= 1)
%     disp("[Error] Unstable system!")
% else
%     disp("System is stable.")
% end


%% Run LTI simulation
[t, x, u] = ltisim(x0, A, B, Kd, Ns, dt, Ts);


%% Plot results
if b_plot
    % plot states
    subplot(2,1,1);
    for i = 1:size(x,2)
        stairs(t, x(:,i));
        hold on;
    end
    ylabel("States: x_k")
    xlabel("t")

    % plot inputs
    subplot(2,1,2);
    for i = 1:size(u,2)
        stairs(t, u(:,i));
        hold on;
    end
    ylabel("Intpus: u_k")
    xlabel("t")
end

% Settling_Time
pi = stepinfo(x(:,1), t, 0.0, 'SettlingTimeThreshold',0.05);
tss = pi.SettlingTime;

if (tss > (Ns*0.95)*dt || max(abs(u)) > U_MAX || isnan(tss))
    tss = 100;
end

end
