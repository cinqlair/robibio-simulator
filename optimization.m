close all;
clear all;
clc;

%% Path for Matlab functions
addpath ('functions/')

global best_solution;

%% Load dataset
%% 1.1 Straight walking at 1.0 m/s
%load ('dataset/robibio/1.1.mat');

%% 4 Transition from 0.0 m/s to 4.0 m/s
load ('dataset/robibio/4.mat');

start = 1;
step = 10;
stop = 20000;


%% Motor references
motors.parameters.hip.reference     = str2func('motor_P01_48x240_30x240');
motors.parameters.knee.reference    = str2func('motor_P01_48x240_30x240');
motors.parameters.ankle.reference   = str2func('motor_P01_48x240_30x240');
motors.parameters.hip_knee.reference = str2func('motor_P01_48x240_30x240');
motors.parameters.knee_ankle.reference = str2func('motor_P01_48x240_30x240');



%% Enable/disable motors
motors.enable.hip = true;
motors.enable.knee = true;
motors.enable.ankle = true;
motors.enable.hip_knee = true;
motors.enable.knee_ankle = true;

%% Anonymous function for calling the core from fminsearchbnd
paramCore = @(x)coreOptim(x,motors, dataset, start, step, stop);
    
    
%% Motor parameters


x=[ -80     300     -80,    400     50 ...
    80      350     80      400     0  ...
    80      310     -60     50      0 ...
    -80     50      -80     300     0 ...
    -80     50      -200    0       0];
%x = [46.4499987245664 378.076271326647 -79.0353612646276 379.772065263859 7.62618283297715 57.4651999237865 392.472150843386 53.0133152314646 364.720684637766 63.0882410207131 67.4514895895606 286.726773047387 -136.263503792503 8.24278647500071 -6.67982822254056 -63.6612378658841 -50.4990817634458 -65.2743590713349 278.023086344015 -10.7318805069168 7.57515516443146 70.0318792933904 -197.395802622857 44.3586492953258 -4.01412457806377];

%% Load best initial position
% load('dataset/initial-config/valid-4.mat');
% 
% % % Top efficiency
% % %[m,i] = max(X(:,27));
% 
% % % Top feasability
% % [m,i] = max(X(:,26));
% 
% % Random row
% i = ceil(rand * size(X,1));
% x = X(i,1:25);


lb =  [ -85     -100    -80,    50      -100 ...
        -80     -80     -80,    278     -100 ...
        -80     -0      -200,   -54     -100 ...
        -80     -80     -80,    278     -100 ...
        -80    -80      -201,   0       -100];

ub =[   85      500     80      480     100 ...
        80      480     80,     438     100 ...
        80      350     -41,    130     100 ...
        80      80      80,     438     100 ...
        80      80      -39,    134     100];
    
% x=(ub-lb).*rand(1,25)+lb;
% while (isnan(paramCore(x)))
%     x=(ub-lb).*rand(1,25)+lb;        
% end

figure; hold on; grid on;
plot_initial_configuration(x, lb, ub);
drawnow;
    
    
%% Optimization    
disp ('Running optimization, it may really take a while...'); tic
options = optimset('Display','iter', 'TolFun', 1e-2, 'TolX', 1e-2); %, 'MaxFunEvals',80);
[x,fval,exitflag,output] = fminsearchbnd(paramCore,x,lb, ub, options);
toc

%% draw optimal solution
figure; hold on; grid on;
plot_initial_configuration(x, lb, ub);
drawnow;

%% Process best solution
disp ('Running core, it may again take a while...'); tic
motors = appendX2motors(x, motors);
motors = core (motors, dataset, start, 1, stop);
toc

%% Feasability
fprintf('Feasability: %.2f%%\n', mean(motors.feasable)*100 );

%% Compute efficiency
power_motion = sum (dataset.power.total(motors.start : motors.step : motors.stop));
power_motor = (sum(sum (abs(motors.power.left))) + sum(sum (abs(motors.power.right))));
fprintf('Efficiency: %.2f%%\n',(power_motion/power_motor)*100);


%% Simulation is over, make a sound
load gong.mat; sound(y);
pause;



%% Robot motion
figure;
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


