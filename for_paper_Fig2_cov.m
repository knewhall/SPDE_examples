% plot covariance of values

[dd0,line0] = multi_sims(64+1,0,10,5);

[dd01,line01] = multi_sims(64+1,0.1,10,5);

[dd025,line025] = multi_sims(64+1,0.25,20,5);

[dd075,line075] = multi_sims(64+1,0.75,40,5);


figure(3);clf;hold on
plot(dd0,line0,'linewidth',2)
plot(dd01,line01,'--','linewidth',2)
plot(dd025,line025,'-.','linewidth',2)
plot(dd075,line075,':','linewidth',2)

xlabel('distance')
ylabel('covariance')

set(gca,'fontsize',25)
legend('\beta=5 white','\beta=5 \kappa=0.1','\beta=5 \kappa=0.25','\beta=5 \kappa=0.75',...
    'location','ne')

%%
figure(4);clf;hold on

load('Cov_ksp001.mat')
plot(dd0,line0,'linewidth',2)
plot(dd01,line01,'--','linewidth',2)
plot(dd025,line025,'-.','linewidth',2)
plot(dd075,line075,':','linewidth',2)

load('Cov_ksp005.mat')
plot(dd0,line0,'linewidth',2)
plot(dd01,line01,'--','linewidth',2)
plot(dd025,line025,'-.','linewidth',2)
plot(dd075,line075,':','linewidth',2)

xlabel('distance')
ylabel('covariance')

ylim([0 5])
box on

set(gca,'fontsize',25)
legend('k=0.01 white','k=0.01 \kappa=0.1','k=0.01 \kappa=0.25','k=0.01 \kappa=0.75',...
    'k=0.05 white','k=0.05 \kappa=0.1','k=0.05 \kappa=0.25','k=0.05 \kappa=0.75',...
    'location','northeastoutside')