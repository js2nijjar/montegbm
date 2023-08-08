function AssetPaths(S0,r,X,mu,sig,dt,days,nsims)

% Implementation of the code follows closely from the original author Dr. Phil Goddard

% Inputs
% S0 - stock price today
% r - risk free rate
% X - strike
% mu - expected return
% sig - expected volatility
% dt - time step of 1 out of 365 days
% days - days to expiry
% nsims - number of paths generated

% drift
nu = mu - sig*sig/2;

% future paths
S = S0*[ones(1,nsims);cumprod(exp(nu*dt+sig*sqrt(dt)*randn(days,nsims)),1)];

% payoff of a call for each path
payoffcall = max(mean(S)-X,0);

% payoff of a put for each path
payoffput = max(X-mean(S),0);

% years to expiry
T = dt*days;

% option price discounted
callputprice = [mean(payoffcall)*exp(-r*T),mean(payoffput)*exp(-r*T)]

time = days:-1:0;
plot(time,S,'Linewidth',1);
set(gca,'XDir','Reverse','FontWeight', 'bold', 'Fontsize', 24);
xlabel('Time to Expiry','FontWeight','bold','Fontsize',24);
ylabel('Asset Price','FontWeight','bold','Fontsize',20);
title('Simulated Asset Paths','FontWeight','bold','Fontsize',24);
grid on
set(gcf,'Color','w');