close all;
clear all;
clc;

%% Path for Matlab functions
addpath ('functions/')

%% Lever arm [m]
lever_arm = 0.1;
%% Max motor force [N]
max_force = 585;


%% Load dataset
%% 1.1 Straight walking at 1.0 m/s
load ('dataset/robibio/1.1.mat');
%load ('dataset/robibio/1.2.mat');
%load ('dataset/robibio/1.3.mat');
%load ('dataset/robibio/2.1.mat');
%load ('dataset/robibio/2.2.mat');
%load ('dataset/robibio/2.3.mat');
%load ('dataset/robibio/3.mat');
%load ('dataset/robibio/4.mat');
%load ('dataset/robibio/5.1.mat');
%load ('dataset/robibio/5.2.mat');
%load ('dataset/robibio/6.mat');

figure; 

%% Hip
subplot(3,1,1); grid on; hold on;
plot (dataset.torques.q(1,:), 'r');
plot (dataset.torques.q(2,:), 'b');
area (1*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
area (2*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);
area (-1*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
area (-2*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);

xlabel('Sample');
ylabel('Torque [N.m]');
legend ('Left', 'Right', '1 motor', '2 motors');
title ('Hip torque [N.m]');

%% Knee
subplot(3,1,2); grid on; hold on;
plot (dataset.torques.q(3,:), 'r');
plot (dataset.torques.q(4,:), 'b');
area (1*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
area (2*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);
area (3*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','y','FaceAlpha',.1,'EdgeAlpha',.2);
area (-1*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
area (-2*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);
area (-3*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','y','FaceAlpha',.1,'EdgeAlpha',.2);

xlabel('Sample');
ylabel('Torque [N.m]');
legend ('Left', 'Right', '1 motor', '2 motors', '3 motors');
title ('Knee torque [N.m]');


%% Ankle
subplot(3,1,3); grid on; hold on;
plot (dataset.torques.q(5,:), 'r');
plot (dataset.torques.q(6,:), 'b');
area (1*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
area (2*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);
area (-1*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
area (-2*max_force*lever_arm*ones(1,dataset.frames), 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);

xlabel('Sample');
ylabel('Torque [N.m]');
legend ('Left', 'Right', '1 motor', '2 motors');
title ('Ankle torque [N.m]');