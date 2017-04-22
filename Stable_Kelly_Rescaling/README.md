
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **Stable_Kelly_Rescaling** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of Quantlet : Stable_Kelly_Rescaling

Published in : tba

Description : 'Stable Rescaling illustrates the principle rescaling the distribution under stable
distributions, i.e. elliptically stable distributions.'

Keywords : stable, scaling, elliptical distribution, scatterplot, standardize, normalization

See also : 'Stable_Kelly_LogDensityFinancials, Stable_Kelly_MomentIncrease,
Stable_Kelly_MomentDistribution, sim_stable, stable'

Author : NW

Submitted : 2016-07-04

Example : 1.png, 2.png

```

![Picture1](1.png)

![Picture2](2.png)


### MATLAB Code:
```matlab
%% Stable_Rescaling
% Stable Rescaling illustrates the principle rescaling the distribution
% under stable distributions, i.e. elliptically stable distributions.

%% Global Commands

% ver % verify the version of Matlab
clear;clc; % clear

% set global commands for font size and line width
size_font=12;
size_line=2;
set(0,'DefaultAxesFontSize',size_font,'DefaultTextFontSize',size_font);
set(0,'defaultlinelinewidth',size_line)

% figures
set(0, 'defaultFigurePaperType', 'A4')
set(0, 'defaultFigurePaperUnits', 'centimeters')
set(0, 'defaultFigurePaperPositionMode', 'auto')

% reset rngs before running
rng(1)

%% Univariate: Generate Student-T random numbers

x_normalized=randn(1000,1);
x_daily=x_normalized*1.2+1;
x_yearly=x_normalized*1.5+10;

graph=figure();
[f,xi]=ksdensity(x_daily);hold on;
plot(xi,f,'color',[0 102 204]./255)
[f,xi]=ksdensity(x_normalized);
plot(xi,f,'color',[0 204 102]./255)
[f,xi]=ksdensity(x_yearly);
plot(xi,f,'color',[204 0 0]./255)

axis off
grid on
%print(graph,'-depsc','-r300','a')

%% Two dimensional

%x_normal=mvnrnd([1 1],[1 -0.8;
%                      -0.8 1],5000);
 
x_normal=mvtrnd([1 -0.8;
                      -0.8 1],5,5000);                 


x_normalized=x_normal*(chol(cov(x_normal))^-1);
                  
mean(x_normalized);                
std(x_normalized);
corr(x_normalized);

sigma=[1.5; 1.5];
Rho=[1 -0.8; -0.8 1];
Sigma_a=corr2cov(sigma,Rho);
x_daily=x_normal*0.5+8;

x_yearly=x_normalized*chol(Sigma_a)+20;

h=figure();
scatter(x_daily(:,1),x_daily(:,2),'markeredgecolor',[0 102 204]./255); hold on;
scatter(x_normalized(:,1),x_normalized(:,2),'markeredgecolor',[0 204 102]./255)
scatter(x_yearly(:,1),x_yearly(:,2),'markeredgecolor',[204 0 0]./255)
axis equal 
axis off
grid on
%print(h,'-depsc','-r300','presentation_scaling2D')

```
