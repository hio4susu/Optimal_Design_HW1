% kriging fitting and prediction demo for 1d problem
% NTU, ME, SOLab
% 2022/09/27

clc; clear; close all;
addpath('optimal_design_week5\kriging demo\code\');
%% Step 0: Load data file
% x: 200 points between 0 and 2
% y: 200 points
load('OneDimensional_data.mat');
lb = 0;
ub = 2;

%% Step 1: Polt the original data
figure(1);
% ----- to do -----
plot(x,y,'.');
%% Step 2: Modeling through the all data.
% Fitting kriging
% Hint: parameter = f_variogram_fit(data x, data y, lb, ub);
% ----- to do -----
parameter = f_variogram_fit(x, y, lb, ub);
% Kriging prediction.
% Hint: Kriging prediction = f_predictkrige(data x, parameter);
% ----- to do -----
prediction = f_predictkrige(x, parameter);
% Plot the kriging average in the interval [0,2].
% ----- to do -----
x1=linspace(0,2,200);
hold on
plot(x1,prediction)


%% Step 3: Estimate error (known model)
figure(2);
y_origin = (1.7*x.^5-6.2*x.^4+6.3*x.^3-2.3*x+1.1);

% Estimate error 
% ----- to do -----
error = (abs(prediction - y_origin)./y_origin)*100;
% Plot error with respect to x  
% ----- to do -----
plot(x, error, '.');
%% Step 4: Estimate error (unknown model, leave one out)
% Leave one out: Take out the 1 sample, and model through the remaining n-1 data.
% Generate 200 models.
for i = 1:size(y,1) 
    % Take out the ith sample.
    % ----- to do -----
    x_new = x;
    y_new = y;
    x_new(i) = [];
    y_new(i) = [];
    % Modeling through the remaining 199 data. (similar Step 2)
    % ----- to do -----
    parameter_new = f_variogram_fit(x_new, y_new, lb, ub);
    prediction_new = f_predictkrige(x, parameter_new);
    % Estimate error between model prediction and provided data 
    % ----- to do -----
    err(i)=(abs(prediction_new(i)-y(i))./y(i))*100;

end
% Polt error with respect to each model 
 % ----- to do -----
figure(3)
plot(err,'.')
figure(4)
histogram(err,10)