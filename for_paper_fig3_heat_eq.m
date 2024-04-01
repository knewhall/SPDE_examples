
dt = 0.001;
Tend = 100;
t = 0:dt:Tend-dt;

cmap = colormap('spring');

kappa = linspace(0,1,11);
F = griddedInterpolant(linspace(0,1,256),cmap);
cmap = F(kappa);
figure(6); clf; hold on
figure(7); clf; hold on
for k=1:11

    [X0,erg0] = det_evol(64+1,kappa(k),Tend);

    figure(6);
    plot(t,erg0,'linewidth',2,'color',cmap(k,:))

    figure(7);
    % plot(t/(2*pi)^(kappa(k)),erg0,'linewidth',2,'color',cmap(k,:))
    plot(t/(pi)^(2*kappa(k)),erg0,'linewidth',2,'color',cmap(k,:))

end

figure(6);
xlabel('time'); ylabel('energy');
set(gca,'fontsize',25)
colorbar;
box on

figure(7);
xlabel('time/(\pi)^{2\kappa}'); ylabel('energy');
set(gca,'fontsize',25)
xlim([0 30])
box on
