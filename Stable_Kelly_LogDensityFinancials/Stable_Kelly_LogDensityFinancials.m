%% Stable_LogDensity_Financials
    % Compares parametric densities of Normal, Stable and Cauchy with
    % empirical financial market returns on log-scale to emphasize
    % non-normal behavior.

%% Global Commands

% ver % verify the version of Matlab
clear;clc; % clear

% set global commands for font size and line width
size_font=12;
size_line=2;
set(0,'DefaultAxesFontSize',size_font,'DefaultTextFontSize',size_font);
set(0,'defaultlinelinewidth',size_line)

%% Data and dimensions

load data.mat
ret=price2ret(prices);
[A,B]=size(ret);

%% Plotting

scale=0.0001;
line_width=3;

h=figure();

% closed form pdfs for normal
x=-10:0.01:10;
pd_gauss = makedist('Normal',0,1);
pdf_gaussian = pdf(pd_gauss,x);
semilogy(x,pdf_gaussian+scale,'Color',[0 102 204]./255,'linewidth',line_width); hold on;

% closed form pdfs for cauchy
pdf_cauchy = tpdf(x,1);
semilogy(x,pdf_cauchy+scale,'Color',[204 0 0]./255,'linewidth',line_width)

% approx for stable
%ret_choice=ret(:,1);
pd_stable = makedist('Stable',1.7,0,1/sqrt(2),0);
pdf_stable=pdf(pd_stable,x);
semilogy(x,pdf_stable+scale,'Color',[0 204 102]./255,'linewidth',line_width)

% assets
for i=1:B % reduce B to make the plot simpler
    [y,t]=ksdensity((ret(:,i)-mean(ret(:,i)))./std(ret(:,i)),x); %,'bandwidth',0.005
    semilogy(t,y+scale,'Color',[128 128 128]./255,'linewidth',1);hold on;
end

xlabel('Normalized Log-returns')
ylabel('Log-Frequency')
xlim([-10,10])
