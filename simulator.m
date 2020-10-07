close all;
clear all;
clc;

%% Path for Matlab functions
addpath ('functions/')


%% Load dataset
%% 1.1 Straight walking at 1.0 m/s
%load ('dataset/robibio/1.1.mat');

%% 2.3 Straight running at 4.0 m/s
%load ('dataset/robibio/2.3.mat');

%% 4 Transition from 0.0 m/s to 4.0 m/s
%load ('dataset/robibio/4.mat');

%% 6 Squats
load ('dataset/robibio/6.mat');


%% Motor parameters

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
motors.enable.knee_ankle = true;

%% Set motor position from vector x (optimization output)
%x = [46.4499987245664 378.076271326647 -79.0353612646276 379.772065263859 7.62618283297715 57.4651999237865 392.472150843386 53.0133152314646 364.720684637766 63.0882410207131 67.4514895895606 286.726773047387 -136.263503792503 8.24278647500071 -6.67982822254056 -63.6612378658841 -50.4990817634458 -65.2743590713349 278.023086344015 -10.7318805069168 7.57515516443146 70.0318792933904 -197.395802622857 44.3586492953258 -4.01412457806377];
%x = [-21.71	491.18	-79.99	476.89	-35.68	-40.71	304.06	76.54	437.40	68.89	-79.44	254.39	-41.23	130.00	97.54	-79.64	-79.28	-5.08	278.03	-22.75	-78.72	78.24	-40.31	91.83	-7.51];
%motors = appendX2motors(x, motors);

disp ('Running core, it may take a while...'); tic
motors = core (motors, dataset, 1, 1, 10000); %dataset.frames);
toc

%% Feasability
fprintf('Feasability: %.2f%%\n', mean(motors.feasable)*100 );

%% Compute efficiency
power_motion = sum (dataset.power.total(motors.start : motors.step : motors.stop));
power_motor = (sum(sum (abs(motors.power.left))) + sum(sum (abs(motors.power.right))));
fprintf('Efficiency: %.2f\n',power_motion/power_motor);



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
% figure();
% plot_motor_length(motors);
% 
% figure();
% plot_motor_max_force(motors);
% 
figure();
plot_motor_force(motors);

figure; 
plot_motor_power(motors);

figure; 
plot_motor_optim_residual(motors);
% 
% figure();
% plot_motor_torques(motors, dataset);
% 
% figure();
% plot_motor_force(motors);
% 
% figure();
% plot_motor_state(motors);
% 
% figure();
% plot_motor_torque_hip(motors, dataset);
% 
% figure();
% plot_motor_torque_knee(motors, dataset);
% 
% figure();
% plot_motor_torque_ankle(motors, dataset);

figure();
plot_motor_efficiency(motors, dataset);

 
