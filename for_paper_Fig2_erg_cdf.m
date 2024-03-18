% plot Energy stats for colored noise and white noise

figure(2);clf;hold on
tic
erg_all = erg_stats(64+1,0,400,5);
toc % N=64+1 and T=400 - 7.5 sec
[f64a,x64a] = ecdf(erg_all);

plot(erg_all)

erg_all = erg_stats(64+1,0.1,800,5);
[f64b,x64b] = ecdf(erg_all);

plot(erg_all)

erg_all = erg_stats(64+1,0.25,800,5);
[f64c,x64c] = ecdf(erg_all);

plot(erg_all)

erg_all = erg_stats(64+1,0.75,2400,5);
[f64d,x64d] = ecdf(erg_all);

plot(erg_all)

xlabel('timestep')
ylabel('energy')

set(gca,'fontsize',25)
box on
%%
figure(1);clf;hold on
plot(x64a,f64a,'linewidth',2)
plot(x64b,f64b,'--','linewidth',2)
plot(x64c,f64c,'-.','linewidth',2)
plot(x64d,f64d,':','linewidth',2)

xlabel('energy')
ylabel('CDF')
xlim([0 12])

legend('\beta=5 white','\beta=5 \kappa=0.1','\beta=5 \kappa=0.25','\beta=5 \kappa=0.75',...
    'location','se')

set(gca,'fontsize',25)
box on
%%
erg_all = erg_stats(64+1,0,400,10);
[f64a,x64a] = ecdf(erg_all);

erg_all = erg_stats(64+1,0.1,800,10);
[f64b,x64b] = ecdf(erg_all);

erg_all = erg_stats(64+1,0.25,800,10);
[f64c,x64c] = ecdf(erg_all);

erg_all = erg_stats(64+1,0.75,2400,10);
[f64d,x64d] = ecdf(erg_all);

plot(x64a,f64a,'linewidth',2)
plot(x64b,f64b,'--','linewidth',2)
plot(x64c,f64c,'-.','linewidth',2)
plot(x64d,f64d,':','linewidth',2)

xlabel('energy')
ylabel('CDF')
xlim([0 12])

legend('\beta=5 white','\beta=5 \kappa=0.1','\beta=5 \kappa=0.25','\beta=5 \kappa=0.75',...
    '\beta=10 white','\beta=10 \kappa=0.1','\beta=10 \kappa=0.25','\beta=10 \kappa=0.75',...
    'location','se')