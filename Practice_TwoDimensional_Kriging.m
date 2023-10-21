% kriging fitting and prediction demo for 2d problem
% NTU, ME, SOLab
% 2022/09/27

clc; clear; close all;
%% Step 0: Load data file
% x1,x2: 21*21 points between 0 and 2
% z: 21*21 points
load('TwoDimensional_data.mat');
lb = [0, 0];
ub = [2, 2];
% Reshape
x1_flatten = reshape(x1,[21*21 1]);
x2_flatten = reshape(x2,[21*21,1]);
z_flatten = reshape(z,[21*21,1]);

x_data = [x1_flatten, x2_flatten];
z_data = z_flatten;

%% Step 1: Plot the original data
figure(1);
% Hint: plot3
% ----- to do -----
plot3(x1_flatten, x2_flatten, z_flatten, '.');

%% Step 2: Modeling through the all data.
% Fitting kriging
% Hint: parameter = f_variogram_fit(data x, data z, lb, ub);
% ----- to do -----
parameter = f_variogram_fit(x_data, z_data, lb, ub);
% Kriging prediction.
% Hint: Kriging prediction = f_predictkrige(data x, parameter);
% ----- to do -----
prediction = f_predictkrige(x_data, parameter);
% Plot the kriging average in the interval [0,2].
% ----- to do -----
[x1_mesh, x2_mesh] = meshgrid(linspace(0, 2, 21), linspace(0, 2, 21));
x_predict = [x1_mesh(:), x2_mesh(:)];
kriging_prediction = f_predictkrige(x_predict, parameter);
hold on
surf(x1_mesh, x2_mesh, reshape(kriging_prediction, [21, 21]));

%% Step 3: Estimate error (known model)
figure(2);
z_origin = (x1_flatten.^2-5*x2_flatten.^2+x1_flatten.*x2_flatten-8*x1_flatten+9*x2_flatten-5);

% Estimate error 
% ----- to do -----
error = (abs(prediction - z_origin)./z_origin)*100;
% Plot error with respect to x1 and x2  
% ----- to do -----

surf(x1_mesh, x2_mesh, reshape(error, [21, 21]));
%% Step 4: Estimate error (unknown model, leave one out)
% Leave one out: Take out the 1 sample, and model through the remaining n-1 data.
% Generate 21*21 models.
for i = 1:size(z_flatten,1) 
    % Take out the ith sample.
    % ----- to do -----
    z_removed = z_flatten;
    z_removed(i) = []; 
    x_removed = x_data;
    x_removed(i, :) = [];
    % Modeling through the remaining 21*21-1 data. (similar Step 2)
    % ----- to do -----
    parameter_removed = f_variogram_fit(x_removed, z_removed, lb, ub);
    prediction_removed = f_predictkrige(x_data(i, :), parameter_removed);
    % Estimate error between model prediction and provided data 
    % ----- to do -----
    error_i = (abs(prediction_removed - z_flatten(i)) / z_flatten(i)) * 100;
    errors(i) = error_i;
end
% Polt error with respect to each model 
 % ----- to do -----
figure(3);
surf(x1_mesh, x2_mesh, reshape(errors, [21, 21]));
figure(4)
hist(errors,10);

