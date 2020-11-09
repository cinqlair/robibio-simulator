close all;
clear all;
clc;

%% Path for Matlab functions
addpath ('functions/')


%% Load dataset
%% 1.1 Straight walking at 1.0 m/s
load ('dataset/robibio/1.1.mat');

%% 2.3 Straight running at 4.0 m/s
%load ('dataset/robibio/2.3.mat');

%% 4 Transition from 0.0 m/s to 4.0 m/s
%load ('dataset/robibio/4.mat');

%% 6 Squats
%load ('dataset/robibio/6.mat');


%% Motor parameters

motors.parameters.hip.trunk         = [-80; 300];
motors.parameters.hip.thigh         = [-80; 400];
motors.parameters.hip.offset        = 50;
motors.parameters.hip.reference     = str2func('motor_P01_48x240_30x240');

motors.parameters.knee.thigh        = [80; 350];
motors.parameters.knee.shang        = [80; 400];
motors.parameters.knee.offset       = 0;
motors.parameters.knee.reference    = str2func('motor_P01_48x240_30x240');

motors.parameters.ankle.shang       = [80; 310];
motors.parameters.ankle.foot        = [-60; 50];
motors.parameters.ankle.offset      = 0;
motors.parameters.ankle.reference   = str2func('motor_P01_48x240_30x240');

motors.parameters.hip_knee.trunk    = [-80; 50];
motors.parameters.hip_knee.shang    = [-80; 300];
motors.parameters.hip_knee.offset   = 0;
motors.parameters.hip_knee.reference = str2func('motor_P01_48x240_30x240');

motors.parameters.knee_ankle.thigh   = [-80; 50];
motors.parameters.knee_ankle.foot    = [-200; 0];
motors.parameters.knee_ankle.offset  = 0;
motors.parameters.knee_ankle.reference = str2func('motor_P01_48x240_30x240');

%% Enable/disable motors
motors.enable.hip = true;
motors.enable.knee = true;
motors.enable.ankle = true;
motors.enable.hip_knee = true;
motors.enable.knee_ankle = true;


disp ('Running core, it may take a while...'); tic
%motors = core (motors, dataset, 1030, 1, 1250); 
%motors = core (motors, dataset, 10000, 1, 12000); 
motors = core (motors, dataset, 1, 1, dataset.frames);
toc

%% Feasability
fprintf('Feasability: %.2f%%\n', mean(motors.feasable)*100 );

%% Compute efficiency
fprintf('Efficiency real: %.2f\n',mean(motors.efficiency));
fprintf('Efficiency real: %.2f\n',mean(max(0,motors.efficiency)));



%% Simulation is over, make a sound
%load gong.mat; sound(y);

%% Robot motion
figure(1);
fig_robot = init_figure_robot();
for i=1:10:motors.n_steps
    [time, step] = update_figure_robot(fig_robot, dataset, motors, i);    
    title (sprintf('HuMoD time: %.2fs | ROBIBIO step: %.d', time, step));      
    drawnow;       
end



%% Plot motor data
% figure;
% plot_knee_torque_velocity(motors,dataset);

figure;
plot_joint_power_positive_vs_negative(motors, dataset);
% 
% figure;
% plot_joint_cumulated_power_positive_vs_negative(motors, dataset);
% 
% figure();
% plot_motor_length(motors);
% 
% figure();
% plot_motor_velocity(motors);

figure();
plot_motor_efficiency(motors, dataset);
% 
% figure; 
% plot_motor_optim_residual(motors);
% 
% figure();
% plot_motor_force(motors);
% 
% figure();
% plot_motor_total_power(motors, dataset);
% 
% figure();
% plot_motor_max_force(motors);
% 
% figure; 
% plot_motor_power(motors);
% 
% figure();
% plot_motor_torques(motors, dataset);
% 
% figure();
% plot_motor_state(motors);

% figure();
% plot_motor_torque_hip(motors, dataset);
% 
% figure();
% plot_motor_torque_knee(motors, dataset);
% 
% figure();
% plot_motor_torque_ankle(motors, dataset);



 
