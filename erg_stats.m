% bead-spring (heat equation like) model with pinned ends
function erg_all = erg_stats(n_beads,eigenvalue_order,Tend,beta)
% n_beads: number of discretization points, suggested to be odd  
% eigenvalue_order: decay of eigenvalues for correlation matrix
    % 0: white noise, >0 colored noise
% Tend: length of time to run simulation (not number of time steps)
% beta: inverse temperature

interval_length = 1;

k_sp = 0.01; % spring constant

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
V = @(x) 0;     % external potential for each bead
Vp = @(x) 0;    % derivative of external potential

X = 0.3*randn(n_beads,1);   % initial conditions
erg = dx*0.5*sum( k_sp*diff(X).^2/dx2 ) + dx*sum( V(X) );

erg_all = zeros(1,nstepmax);
erg_all(1) = erg;

for nstep = 2:nstepmax
    dW = randn(n_beads,1);    
    noise = dt2*covariance_half*dW;

    % two pinned beads at either end
    Lpx = k_sp*( X(3:end,:) - 2*X(2:end-1,:) + X(1:end-2,:) )/dx2;

    X(2:end-1,:) = X(2:end-1,:) ...
        + CN/n_beads*(Lpx + Vp(X(2:end-1,:)))*dt ...
        + noise(2:end-1,:);

    erg_all(nstep) = dx*0.5*sum( k_sp*diff(X).^2/dx2 ) + dx*sum( V(X) );
end

