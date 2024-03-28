% bead-spring (heat equation like) model with pinned ends
function [dd, line] = multi_sims(n_beads,eigenvalue_order,Tend,beta)
n_sims = 1000;

interval_length = 1;

k_sp = 0.01; % spring constant
% k_sp = 0.05;

dt = 0.001;
nstepmax = ceil(Tend/dt);
x = linspace(0,interval_length,n_beads);
dx = interval_length/n_beads;
dx2 = dx*dx;
dt2 = sqrt(2*dt/beta);

kvec = pi*(1:n_beads);
Q = [sqrt(2)*sin(pi*(0:n_beads-1)'/(n_beads-1)*(1:n_beads))];
D = diag(kvec.^(-eigenvalue_order));
covariance_matrix = Q*D.^2*Q';
CN = covariance_matrix(2:end-1,2:end-1);
covariance_half = Q*D;

% V = @(x) 0.25*(1-x.^2).^2;
% Vp = @(x) x.*(1-x.^2); % this is -\nabla V
V = @(x) 0;
Vp = @(x) 0;

X = zeros(n_beads,n_sims);
erg = dx*0.5*sum( k_sp*diff(X).^2 ) + dx*sum( V(X) );

for k=1:n_sims
for nstep = 2:nstepmax
    dW = randn(n_beads,1);    
    noise = dt2*covariance_half*dW;

    % two pinned beads at either end
    Lpx = k_sp*( X(3:end,k) - 2*X(2:end-1,k) + X(1:end-2,k) )/dx2;

    X(2:end-1,k) = X(2:end-1,k) ...
        + CN/n_beads*(Lpx + Vp(X(2:end-1,k)))*dt ...
        + noise(2:end-1,1);

    % plot(x,X,'o--')
    % ylim([-2 2])
    % drawnow
    % erg_all(nstep) = dx*0.5*sum( k_sp*diff(X).^2 ) + dx*sum( V(X) );
end
end

C = cov(X');

line = zeros(1,n_beads);
dd = line;
for k=1:n_beads
    line(k) = C(k,n_beads-k+1);
    dd(k) = x(k)-x(n_beads-k+1);
end
