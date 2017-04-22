
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **Stable_Kelly_MomentIncrease** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of Quantlet : Stable_Kelly_MomentIncrease

Published in : tba

Description : 'Stable_Kelly_MomentIncrease shows the sample moment convergence for increasing data
points, favoring non-normal limits.'

Keywords : stable, moments, convergence, levy, non-gaussian

See also : 'Stable_Kelly_LogDensityFinancials, Stable_Kelly_MomentDistribution,
Stable_Kelly_Rescaling, sim_stable, stable, mc_culloch, stabreg'

Author : NW

Submitted : 2016-07-04

Datafile : prices.mat

Example : 1.png

```

![Picture1](1.png)


### MATLAB Code:
```matlab
%% Moment behavior with increasing data points
% Shows how moments should converge for finite variance distributions in
% contrast to empirical stock returns (S&P 500) 1985-2015

%% Init

clear;clc;

%set global commands for font size and line width
size_font=9;
size_line=1.5;
set(0,'DefaultAxesFontSize',size_font,'DefaultTextFontSize',size_font);
set(0,'defaultlinelinewidth',size_line)

% figures
set(0, 'defaultFigurePaperType', 'A4')
set(0, 'defaultFigurePaperUnits', 'centimeters')
set(0, 'defaultFigurePaperPositionMode', 'auto')

% reset rngs before running
rng(1)

%% Daily dataset if SnP500 from 1985 till 2015

load prices.mat

%ret_daily=price2ret(prices);

% Weekly Dataset from prices
c=0;
for i=1:1:length(prices) % 1 x x x x 1 % 1 6 21 251
    c=c+1;
    prices_f(c,:)=prices(i);
end

ret_daily=price2ret(prices_f);

%stats
%[s_d,s_daily]=stats(ret_daily);
n=length(ret_daily);

% rolling moments init
mu_rolling_data=nan(n,1);
sigma_rolling_data=nan(n,1);
skew_rolling_data=nan(n,1);
kurt_rolling_data=nan(n,1);

    for i=1:n
        %mu_rolling_data(i,:)=mean(ret_daily(1:i));
        sigma_rolling_data(i,:)=std(ret_daily(1:i));
        skew_rolling_data(i,:)=skewness(ret_daily(1:i));
        kurt_rolling_data(i,:)=kurtosis(ret_daily(1:i));
    end

%% Simulated dataset
    
m=100; % number of runs for parametric simulations
% rolling moments init
mu_rolling=nan(n,m);
sigma_rolling=nan(n,m);
skew_rolling=nan(n,m);
kurt_rolling=nan(n,m);

m=100; % number of runs for parametric simulations
for j=1:m

    ret_daily=mean(price2ret(prices))+std(price2ret(prices)).*randn(7565,1);
    %ret_daily=mean(price2ret(prices))+std(price2ret(prices)).*trnd(2.8,7565,1);

    for i=1:n
        %mu_rolling(i,j)=mean(ret_daily(1:i));
        sigma_rolling(i,j)=std(ret_daily(1:i));
        skew_rolling(i,j)=skewness(ret_daily(1:i));
        kurt_rolling(i,j)=kurtosis(ret_daily(1:i));
    end

end

%% Figure

subplot(1,4,1)
loglog(1:n,mu_rolling)
subplot(1,4,2)
loglog(1:n,sigma_rolling)
subplot(1,4,3)
loglog(1:n,skew_rolling)
subplot(1,4,4)
loglog(1:n,kurt_rolling)

%% Subset Figure

h=figure();
subplot(1,3,1)
loglog(1:n,sigma_rolling*100,'Color',[0 102 204]./255);hold on; %.*sqrt(251)
loglog(1:n,sigma_rolling_data*100,'Color',[204 0 0]./255); %.*sqrt(251)

%ylim([10^-3 1])
xlabel('n')
ylabel('Standard deviation (in %)')

subplot(1,3,2)
semilogx(1:n,skew_rolling,'Color',[0 102 204]./255);hold on; %.*sqrt(251)
semilogx(1:n,skew_rolling_data,'Color',[204 0 0]./255); %.*sqrt(251)

%ylim([10^-3 1])
xlabel('n')
ylabel('Skewness')

subplot(1,3,3)
loglog(1:n,kurt_rolling,'Color',[0 102 204]./255);hold on;
loglog(1:n,kurt_rolling_data,'Color',[204 0 0]./255);

ylim([1 1000])
xlabel('n')
ylabel('Kurtosis')

set(h, 'PaperPosition',[2 2 17 10]) % 210*297
%print(h,'-dpng','-r300','implementation_moments_empiricalgaussian') %-depsc


```
