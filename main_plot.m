clear
clc
load('nmse.mat');
load('Over_sampling.mat');
load('MM.mat');
load('Rate.mat');


figure
box on
hold on
plot(MM,nmse_SIb(:,2),'r-p','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','r','MarkerFaceColor','r')
plot(MM,nmse_SIbrnd(:,2),'r-o','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','r','MarkerFaceColor','r')
plot(MM,nmse_InSectorPaper(:,2),'r-s','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','r','MarkerFaceColor','r')
plot(MM,nmse_Greedy(:,2),'r-^','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','r','MarkerFaceColor','r')
plot(MM,nmse_SIb(:,1),'k--p','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')
plot(MM,nmse_SIbrnd(:,1),'k--o','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')
plot(MM,nmse_InSectorPaper(:,1),'k--s','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')
plot(MM,nmse_Greedy(:,1),'k--^','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')

legend('proposed, Oversampling order: 4','Random, Oversampling order: 4','Method5, Oversampling order: 4','Greedy, Oversampling order: 4','proposed, Oversampling order: 1','random, Oversampling order: 1','Method5, Oversampling order: 1','Greedy, Oversampling order: 1')
title('Nr = 256, SNR = 10 [dB]')
ylabel('NMSE [dB]')
xlabel('Number of measurements')
xlim([min(MM),max(MM)])


figure
box on
hold on
plot(MM,RateSIb(:,2),'r-p','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','r','MarkerFaceColor','r')
plot(MM,RateSIbrnd(:,2),'r-o','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','r','MarkerFaceColor','r')
plot(MM,RateInSector(:,2),'r-s','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','r','MarkerFaceColor','r')
plot(MM,RateGreedy(:,2),'r-^','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','r','MarkerFaceColor','r')
plot(MM,RateSIb(:,1),'k--p','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')
plot(MM,RateSIbrnd(:,1),'k--o','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')
plot(MM,RateInSector(:,1),'k--s','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')
plot(MM,RateGreedy(:,1),'k--^','LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')

legend('proposed, Oversampling order: 4','Random, Oversampling order: 4','Method5, Oversampling order: 4','Greedy, Oversampling order: 4','proposed, Oversampling order: 1','random, Oversampling order: 1','Method5, Oversampling order: 1','Greedy, Oversampling order: 1')
title('Nr = 256, NMSE = 10 [dB]')
ylabel('Achievable rate [bits/s/Hz]')
xlabel('Number of measurements')
xlim([min(MM),max(MM)])