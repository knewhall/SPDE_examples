% spin system with cross-product projection
function [X_all,Y_all,Z_all,erg] = det_evol_spin(n_spins,eigenvalue_order,Tend)

interval_length = 1;

dt = 0.00001;
nstepmax = ceil(Tend/dt);
dx = interval_length/n_spins;
dx2 = dx*dx;

kvec = 2*pi*[(0:n_spins/2),(1:n_spins/2-1)];
kvec(1) = 1;
Q = [ones(n_spins,1),sqrt(2)*cos(2*pi/n_spins*(0:n_spins-1)'*(1:n_spins/2-1)), ...
    cos(pi*(0:n_spins-1)'),sqrt(2)*sin(2*pi/n_spins*(0:n_spins-1)'*(1:n_spins/2-1))];
D = diag(kvec.^(-eigenvalue_order));
covariance_matrix = Q*D.^2*Q';
covariance_half = Q*D;
noise_coefficient = blkdiag(covariance_half,covariance_half,covariance_half);


% for creating the projection matrix
row_indices = [1:n_spins,1:n_spins,n_spins+1:2*n_spins,...
    n_spins+1:2*n_spins,2*n_spins+1:3*n_spins,2*n_spins+1:3*n_spins];
column_indices = [n_spins+1:2*n_spins,2*n_spins+1:3*n_spins,...
    1:n_spins,2*n_spins+1:3*n_spins,1:n_spins,n_spins+1:2*n_spins];

% initial conditions out of equilibrium - a figure-8
d_phi = 2*pi/n_spins; d_theta = d_phi;
theta = [0:d_theta:(n_spins-1)*d_theta]';
phi = theta;
Xm = sin(phi).*cos(theta);
Ym = sin(phi).*sin(theta);
Zm = cos(phi);

% save trajectories
X_all = zeros(n_spins,nstepmax); X_all(:,1) = Xm;
Y_all = zeros(n_spins,nstepmax); Y_all(:,1) = Ym;
Z_all = zeros(n_spins,nstepmax); Z_all(:,1) = Zm;

% SDE concatenate vectors together
sde_cross = [Xm; Ym; Zm];

for nstep = 2:nstepmax

    % --- cross dynamics
    X = sde_cross(1:n_spins,1);
    Y = sde_cross(n_spins+1:2*n_spins,1);
    Z = sde_cross(2*n_spins+1:3*n_spins,1);

    Lpx = ( [X(2:end,:); X(1,:)] -2*X + [X(end,:); X(1:end-1,:)] )/dx2;
    Lpy = ( [Y(2:end,:); Y(1,:)] -2*Y + [Y(end,:); Y(1:end-1,:)] )/dx2;
    Lpz = ( [Z(2:end,:); Z(1,:)] -2*Z + [Z(end,:); Z(1:end-1,:)] )/dx2;

    projection_cross_SDE = sparse(row_indices,column_indices,...
        [Z;-Y;-Z;X;Y;-X]);
    PC = projection_cross_SDE * noise_coefficient;

    sde_cross = [X; Y; Z] + dt/n_spins*(PC*PC')*[Lpx;Lpy;Lpz];

    X = sde_cross(1:n_spins,1);
    Y = sde_cross(n_spins+1:2*n_spins,1);
    Z = sde_cross(2*n_spins+1:3*n_spins,1);

    lng = sqrt(X.^2+Y.^2+Z.^2);

    X = X./lng;
    Y = Y./lng;
    Z = Z./lng;

    sde_cross = [X; Y; Z];

    X_all(:,nstep) = X;
    Y_all(:,nstep) = Y;
    Z_all(:,nstep) = Z;

end

% calculate the energy,
Gdx = ([X_all(2:end,:); X_all(1,:)] -X_all)/dx;
Gdy = ([Y_all(2:end,:); Y_all(1,:)] -Y_all)/dx;
Gdz = ([Z_all(2:end,:); Z_all(1,:)] -Z_all)/dx;

erg = dx*0.5*sum( Gdx.^2 + Gdy.^2 + Gdz.^2 );