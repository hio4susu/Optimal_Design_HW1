% feedforward net training and prediction demo for 1d problem
% NTU, ME, SOLab
% 2022/09/27

clc; clear; close all;
%% Step 0: Load data file
% x: 200 points between 0 and 2
% y: 200 points
load('OneDimensional_data.mat');

%% Step 1: Polt the original data
figure(1);
% ----- to do -----
hold on
plot(x,y,'.');
%% Step 2: Modeling through the all data.
% Construct a feedforward network with one hidden layer of size 10.
% ----- to do -----
net = feedforwardnet(10);
% Train the network net using the training data.
% Hint: Input will be a row vector. (1*n matrix)
% ----- to do -----
s=x';
u=y';
net = train(net,s,u);
% Estimate the targets using the trained network.
% ----- to do -----
Estimate = net(s);
% Plot the estimation in the interval [0,2].
% ----- to do -----
x1=linspace(0,2,200); 
u_predicted = net(x1);
plot(x, u_predicted,'.');

%% Step 3: Estimate error (known model)
figure(2);
y_origin = (1.7*x.^5-6.2*x.^4+6.3*x.^3-2.3*x+1.1);

% Estimate error 
% ----- to do -----
error = (abs((Estimate)' - y_origin)./y_origin)*100;

% Plot error with respect to x  
% ----- to do -----
plot(x, error, '.');
%% Step 4: Estimate error (unknown model, leave one out)
% Leave one out: Take out the 1 sample, and model through the remaining n-1 data.
% Generate 200 models.
for i = 1:size(y,1) 
    % Take out the ith sample.
    % ----- to do -----
    s_new = s;
    u_new = u;
    s_new(i) = [];
    u_new(i) = [];
    % Modeling through the remaining 199 data. (similar Step 2)
    % ----- to do -----
    net_new = feedforwardnet(10);
    net_new = train(net_new, s_new, u_new);
    % Estimate error between model prediction and provided data 
    % ----- to do -----
    Estimate_new = net_new(s(i));
    error_new(i)= (abs(Estimate_new - y(i))./y(i))*100;
    
end
% Polt error with respect to each model 
 % ----- to do -----
figure(3);
plot(error_new, '.');
figure(4)
histogram(error_new,10)