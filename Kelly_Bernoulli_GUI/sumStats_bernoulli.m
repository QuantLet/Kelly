function [stats] = sumStats(traj,m)
%% SUMSTATS Calculates summary statistics for simulation trajectories 
% traj = given trajectories from the simulation
% m = number of simulations (not the trials per simulation)
%
% 1 mean
% 2 std
% 3 P_smaller100
% 4 P_smaller50
% 5 P_smaller10
% 6 P_oncelarger200
% 7 T_average200
% 8 P_oncelarger1000
% 9 T_average1000

my=mean(traj(end,:));
sigma=std(traj(end,:));
my_ln=mean(log(traj(end,:)));
sigma_ln=std(log(traj(end,:)));
P_smaller100=sum(traj(end,:)<100)./m;
P_smaller50=sum(traj(end,:)<50)./m;
P_smaller10=sum(traj(end,:)<10)./m;

T_larger200=NaN(m,1);
for i=1:m
if isscalar(find(traj(:,i)>200,1,'first'))==0;
T_larger200(i,:)=NaN;else
T_larger200(i,:)=find(traj(:,i)>200,1,'first');
end
end

P_oncelarger200=1-(sum(isnan(T_larger200))./m);
T_average200=nanmean(T_larger200);

T_larger1000=NaN(m,1);
for i=1:m
if isscalar(find(traj(:,i)>1000,1,'first'))==0;
T_larger1000(i,:)=NaN;else
T_larger1000(i,:)=find(traj(:,i)>1000,1,'first');
end
end

P_oncelarger1000=1-(sum(isnan(T_larger1000))./m);
T_average1000=nanmean(T_larger1000);

%%
stats=[my,sigma,my_ln,sigma_ln,P_smaller100,P_smaller50,P_smaller10,...
    P_oncelarger200,T_average200,P_oncelarger1000,T_average1000]';

end

