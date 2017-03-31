function [W] = wealth(f1,f2,x_discrete,rf)
% W/W_0

W = 1+(f1*x_discrete(:,1)+f2*x_discrete(:,2)+(1-(f1+f2))*rf);
W(W<0)=0;

end

