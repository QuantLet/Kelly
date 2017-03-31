function [W] = wealth_bernoulli(W0,b,n,m,f)
%% WEALTH_BERNOULLI Wealth trajectories for repeated bernoulli

W=ones(n,m);
for j=1:m
W(1,j)=W0;
for i=1:n
W(i+1,j)=W(i,j).*(1+b(i,j).*f);
end
end
W(W<=0)=0;

end

