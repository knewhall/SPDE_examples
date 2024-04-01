
dt = 0.00001;
Tend = 6;
t = 0:dt:Tend-dt;

cmap = colormap('winter');

kappa = linspace(0,1,11);
F = griddedInterpolant(linspace(0,1,256),cmap);
cmap = F(kappa);
figure(6); clf; hold on
figure(7); clf; hold on
for k=1:11

    [X0,Y0,Z0,erg0] = det_evol_spin(64+1,kappa(k),Tend);
    fln = sprintf('spin_kappa_k%g.mat',k);
    save(fln)

    figure(6);
    plot(t,erg0,'linewidth',2,'color',cmap(k,:))

    figure(7);
    plot(t/(2*pi)^(2*kappa(k)),erg0,'linewidth',2,'color',cmap(k,:))

end

figure(6);
xlabel('time'); ylabel('energy');
set(gca,'fontsize',25)
colorbar;
xlim([0 2])
box on

figure(7);
xlabel('time/(2\pi)^{2\kappa}'); ylabel('energy');
set(gca,'fontsize',25)
xlim([0 0.1])
box on
