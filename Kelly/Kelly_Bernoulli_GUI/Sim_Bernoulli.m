function [] = Sim_Bernoulli(W_0,p,n,f_naive,ax1,ax2,ax3)
%% Kelly Simulations under Bernoulli

%% Bernoulli

% reset rngs before running
rng(2)

%f_naive=1; % naive fraction
%W_0=1; % starting wealth
%p=0.6; % winning prob
%n=80; % #trials
m=5000; % trajectories

b=binornd(1,p,int32(n),m); %Bernoulli trials
b(b==0)=-1;

%% Wealth

f=2*p-1; %optimal fraction

W_kelly=wealth_bernoulli(W_0,b,int32(n),m,f);
W_naive=wealth_bernoulli(W_0,b,int32(n),m,f_naive);

%first trajectory
%h=figure();

plot(ax1,[W_kelly(:,1) W_naive(:,1)]);
xlabel(ax1,'n trials')
ylabel(ax1,'Wealth')
legend(ax1,'Full Kelly','Naive','location','northwest')
title(ax1,'Wealth trajectory')

%{
plot([W_smaller(:,1)./W_kelly(:,1) W_bigger(:,1)./W_kelly(:,1)])
xlabel('Trials')
ylabel('Kelly Outperformance')
%}

%% Boxplot

boxplot(ax2,[W_kelly(end,:); W_naive(end,:)]',...
    'Labels',{'Full Kelly','Naive'})
set(gca,'YScale','log')
ylabel(ax2,'Wealth distribution after n trials')
title(ax2,'Boxplot of 5000 wealth trajectories')

%% Optimal growth rate

f_interval=0:0.01:2*f;
g=p*log(1+f_interval)+(1-p)*log(1-f_interval);
g_opt=p*log(1+f)+(1-p)*log(1-f);
plot(ax3,f_interval,g);hold on;
plot(ax3,f,g_opt,'*');
xlim([0 2*f])
xlabel(ax3,'Investment fraction f')
ylabel(ax3,'Exponential rate of growth g(f)')
title(ax3,'Growth optimal betting fraction');hold off;
