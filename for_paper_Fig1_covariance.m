% covariance matrix examples

% --- Dirichlet Boundary Conditions
interval_length = 1;
n_beads = 64+1;     % odd so there is one point where x=y in covariance

x = linspace(0,interval_length,n_beads);

eigenvalue_order = 0.75;   % this is what we call "kappa"

kvec = pi*(1:n_beads);
Q = [sqrt(2)*sin(pi*(0:n_beads-1)'/(n_beads-1)*(1:n_beads))];
D = diag(kvec.^(-eigenvalue_order));
covariance_matrix = Q*D.^2*Q';
covariance_half = Q*D;

figure(1);clf;hold on
[meshx,meshy] = meshgrid(x,x);
surf(meshx,meshy,covariance_matrix,'EdgeColor',[0.5 0.5 0.5])
xlabel('x_i'); ylabel('x_j');zlabel('C_{ij}')
set(gca,'fontsize',25)
set(gca,'view',[ -13.5000   15.4914])

% --- Periodic Boundary Conditions
interval_length = 1;
spin_number = 64;     % even so there are N/2 sine eigenfunctions

x = linspace(0,interval_length,spin_number+1);
x = x(1:end-1);

kvec = 2*pi*[(0:spin_number/2),(1:spin_number/2-1)]; kvec(1) = 1;
Q = [ones(spin_number,1),sqrt(2)*cos(2*pi/spin_number*(0:spin_number-1)'*(1:spin_number/2-1)), ...
    cos(pi*(0:spin_number-1)'),sqrt(2)*sin(2*pi/spin_number*(0:spin_number-1)'*(1:spin_number/2-1))];
D = diag(kvec.^(-eigenvalue_order));
covariance_matrix = Q*D.^2*Q';
covariance_half = Q*D;

figure(2);clf;hold on
[meshx,meshy] = meshgrid(x,x);
surf(meshx,meshy,covariance_matrix,'EdgeColor',[0.5 0.5 0.5])
xlabel('x_i'); ylabel('x_j');zlabel('C_{ij}')
set(gca,'fontsize',25)
set(gca,'view',[ -13.5000   15.4914])
