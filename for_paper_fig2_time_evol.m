
X0 = single_sim(64+1,0,2,5);
X025 = single_sim(64+1,0.25,2,5);

%%
figure(3);clf;hold on
plot([0:0.001:2-0.001],X0(32,:),'linewidth',2)
plot([0:0.001:2-0.001],X0(33,:),'--','linewidth',2)
plot([0:0.001:2-0.001],X0(31,:),'--','linewidth',2)

xlim([1.5 2]); ylim([-3 2])
box on
legend('u_{32} \kappa 0','u_{33} \kappa 0','u_{31} \kappa 0')
xlabel('time')
set(gca,'fontsize',25)



figure(4);clf;hold on
plot([0:0.001:2-0.001],X025(32,:),'linewidth',2)
plot([0:0.001:2-0.001],X025(33,:),'--','linewidth',2)
plot([0:0.001:2-0.001],X025(31,:),'--','linewidth',2)

xlim([1.5 2]); ylim([-3 2])
box on
legend('u_{32} \kappa 0.25','u_{33} \kappa 0.25','u_{31} \kappa 0.25')
xlabel('time')
set(gca,'fontsize',25)