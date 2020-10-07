close all;
clear all;
clc;

%% Path for Matlab functions
addpath ('functions/')


%% Load dataset
% 1.1 Straight walking at 1.0 m/s
load ('dataset/robibio/1.1.mat');
% 4 Transition from 0.0 m/s to 4.0 m/s
%load ('dataset/robibio/4.mat');
% 6 Squats
%load ('dataset/robibio/6.mat');


%% Motor parameters

dataset.labels = [{'Hip_Left'}, {'Hip_Right'}, {'Knee_Left'}, {'Knee_Right'}, {'Ankle_Left'}, {'Ankle_Right'}, {'Hip_Knee_Left'}, {'Hip_Knee_Right'}, {'Knee_Ankle_Left'}, {'Knee_Ankle_Right'}];

motors.parameters.hip.trunk         = [-20; 300];
motors.parameters.hip.thigh         = [-50; 400];
motors.parameters.hip.offset        = 50;
motors.parameters.hip.reference     = str2func('motor_P01_48x240_30x240');

motors.parameters.knee.thigh        = [50; 350];
motors.parameters.knee.shang        = [50; 400];
motors.parameters.knee.offset       = 0;
motors.parameters.knee.reference    = str2func('motor_P01_48x240_30x240');

motors.parameters.ankle.shang       = [50; 310];
motors.parameters.ankle.foot        = [-80; 0];
motors.parameters.ankle.offset      = 0;
motors.parameters.ankle.reference   = str2func('motor_P01_48x240_30x240');

motors.parameters.hip_knee.trunk    = [-50; -50];
motors.parameters.hip_knee.shang    = [-50; 250];
motors.parameters.hip_knee.offset   = 0;
motors.parameters.hip_knee.reference = str2func('motor_P01_48x240_30x240');

motors.parameters.knee_ankle.thigh   = [-50; 50];
motors.parameters.knee_ankle.foot    = [-200; 50];
motors.parameters.knee_ankle.offset  = 0;
motors.parameters.knee_ankle.reference = str2func('motor_P01_48x240_30x240');

%% Enable/disable motors
motors.enable.hip = true;
motors.enable.knee = true;
motors.enable.ankle = true;
motors.enable.hip_knee = true;
motors.enable.knee_ankle = false;


disp ('Start core'); tic
motors = core (motors, dataset, 10000, 1, 12000); % dataset.frames);
toc



figure(1);
fig_robot = init_figure_robot();
[time, step] = update_figure_robot(fig_robot, dataset, motors, 1000);    
title (sprintf('HuMoD time: %.2fs | ROBIBIO step: %.d', time, step));  
    

%% Plot motor data
figure(2);
plot_motor_length(motors,1000);

figure();
plot_motor_max_force(motors);

figure();
plot_motor_state(motors);

figure();
plot_motor_torque_hip(motors, dataset);

figure();
plot_motor_torque_knee(motors, dataset);

figure();
plot_motor_torque_ankle(motors, dataset);
return;

