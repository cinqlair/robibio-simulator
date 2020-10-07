close all;
clear all;
clc;

%% Path for Matlab functions
addpath ('functions/')

%% Load dataset
%% 1.1 Straight walking at 1.0 m/s
%load ('dataset/robibio/1.1.mat');

%% 4 Transition from 0.0 m/s to 4.0 m/s
load ('dataset/robibio/4.mat');

start = 1;
step = 100;
stop = dataset.frames;


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

    X=[];
for i=1:10000
    
    %% Pick valid random initial position    
    x=(ub-lb).*rand(1,25)+lb;
    valid = 0;
    while (valid == 0)
        
        % Create a random initial position
        x=(ub-lb).*rand(1,25)+lb;
        
        % Run core    
        motors = appendX2motors(x, motors);    
        motors = core(motors, dataset, start, step, stop);
        
        valid=1;
        if (sum(motors.state.hip.left) == 0)            valid=0; end
        if (sum(motors.state.knee.left) == 0)           valid=0; end
        if (sum(motors.state.ankle.left) == 0)          valid=0; end
        if (sum(motors.state.hip_knee.left) == 0)       valid=0; end
        if (sum(motors.state.knee_ankle.left) == 0)     valid=0; end
        
        if (sum(motors.state.hip.right) == 0)           valid=0; end
        if (sum(motors.state.knee.right) == 0)          valid=0; end
        if (sum(motors.state.ankle.right) == 0)         valid=0; end
        if (sum(motors.state.hip_knee.right) == 0)      valid=0; end
        if (sum(motors.state.knee_ankle.right) == 0)    valid=0; end
        
    end
    
    
    X(end+1,:) = [ x mean(motors.feasable) mean(motors.efficiency)]
    save('dataset/initial-config/valid-4.mat', 'X');
    
    close all;
    figure (1); 
    plot_initial_configuration(x, lb, ub);
    title (sprintf('Config #%d',i));
    drawnow;
end