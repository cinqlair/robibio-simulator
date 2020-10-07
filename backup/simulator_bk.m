close all;
clear all;
clc;

%% Path for Matlab functions
addpath ('functions/')


%% Load dataset
% 1.1 Straight walking at 1.0 m/s
%load ('dataset/robibio/1.1.mat');
% 4 Transition from 0.0 m/s to 4.0 m/s
load ('dataset/robibio/4.mat');
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
motors.enable.knee_ankle = true;


disp ('Start core'); tic
motors = core (motors, dataset, 1, 1, dataset.frames);
toc
return;



figure;
fig_robot = init_figure_robot();


%% Create time line from number of frames and frame rate
frame_rate = dataset.frame_rate;
frames = dataset.frames;
time_second = [1 : frames]/frame_rate;

index = 1;
for i=1:0.05*size(dataset.trajectories.q, 2)
    
      
    
    
    %% Get transformation matrices
    T_Hip_to_Knee_Left      = reshape (dataset.transformation_matrices.hip_to_knee_left(:,i),[4,4]);
    T_Hip_to_Knee_Right     = reshape (dataset.transformation_matrices.hip_to_knee_right(:,i),[4,4]);
    T_Hip_to_Ankle_Left     = reshape (dataset.transformation_matrices.hip_to_ankle_left(:,i),[4,4]);
    T_Hip_to_Ankle_Right    = reshape (dataset.transformation_matrices.hip_to_ankle_right(:,i),[4,4]);
    T_Hip_to_Foot_Left      = reshape (dataset.transformation_matrices.hip_to_foot_left(:,i),[4,4]);
    T_Hip_to_Foot_Right     = reshape (dataset.transformation_matrices.hip_to_foot_right(:,i),[4,4]);
    
    
    %% Hip motors
    if (motors.enable.hip)
        
        % Motor joint coordinates
        motors.trajectories.hip.left.trunk(:,index)     = [motors.parameters.hip.trunk ; 0 ; 1];
        motors.trajectories.hip.right.trunk(:,index)    = [motors.parameters.hip.trunk ; 0 ; 1];
        motors.trajectories.hip.left.thigh(:,index)     = T_Hip_to_Knee_Left * [motors.parameters.hip.thigh ; 0 ; 1];
        motors.trajectories.hip.right.thigh(:,index)    = T_Hip_to_Knee_Right * [motors.parameters.hip.thigh ; 0 ; 1];
        
        % Distance between attachment points
        motors.length.hip.left(index)                   = norm (motors.trajectories.hip.left.thigh(:,index) - motors.trajectories.hip.left.trunk(:,index));
        motors.length.hip.right(index)                  = norm (motors.trajectories.hip.right.thigh(:,index) - motors.trajectories.hip.right.trunk(:,index));
        
        % Motor maximal force and motor state
        [Force, State] = motors.parameters.hip.reference(motors.length.hip.left(index), motors.parameters.hip.offset);
        motors.max_force.hip.left(index) = Force;
        motors.state.hip.left(index) = State;
        
        [Force, State] = motors.parameters.hip.reference(motors.length.hip.right(index), motors.parameters.hip.offset);
        motors.max_force.hip.right(index) = Force;
        motors.state.hip.right(index) = State;
        
        
        % Compute maximum available torque
        vector_motor = motors.trajectories.hip.left.thigh(:,index) - motors.trajectories.hip.left.trunk(:,index);
        vector_motor = motors.max_force.hip.left(index) * vector_motor/norm(vector_motor);
        vector_lever = motors.trajectories.hip.left.thigh(:,index) / 1000;
        motors.max_torque.hip.left(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));
        
        vector_motor = motors.trajectories.hip.right.thigh(:,index) - motors.trajectories.hip.right.trunk(:,index);
        vector_motor = motors.max_force.hip.right(index) * vector_motor/norm(vector_motor);
        vector_lever = motors.trajectories.hip.right.thigh(:,index) / 1000;
        motors.max_torque.hip.right(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));
        
    end;
    
    %% Knee motor
    if (motors.enable.knee)
        motors.trajectories.knee.left.thigh(:,index)    = T_Hip_to_Knee_Left * [motors.parameters.knee.thigh ; 0 ; 1];
        motors.trajectories.knee.right.thigh(:,index)   = T_Hip_to_Knee_Right * [motors.parameters.knee.thigh ; 0 ; 1];
        motors.trajectories.knee.left.shang(:,index)    = T_Hip_to_Ankle_Left * [motors.parameters.knee.shang ; 0 ; 1];
        motors.trajectories.knee.right.shang(:,index)   = T_Hip_to_Ankle_Right * [motors.parameters.knee.shang ; 0 ; 1];
        
        % Distance between attachment points
        motors.length.knee.left(index)                  = norm (motors.trajectories.knee.left.thigh(:,index) - motors.trajectories.knee.left.shang(:,index));
        motors.length.knee.right(index)                 = norm (motors.trajectories.knee.right.thigh(:,index) - motors.trajectories.knee.right.shang(:,index));
        
        % Motor maximal force and motor state
        [Force, State] = motors.parameters.knee.reference(motors.length.knee.left(index), motors.parameters.knee.offset);
        motors.max_force.knee.left(index) = Force;
        motors.state.knee.left(index) = State;
        
        [Force, State] = motors.parameters.knee.reference(motors.length.knee.right(index), motors.parameters.knee.offset);
        motors.max_force.knee.right(index) = Force;
        motors.state.knee.right(index) = State;
        
        % Compute maximum available torque
        vector_motor = motors.trajectories.knee.left.shang(:,index) - motors.trajectories.knee.left.thigh(:,index);
        vector_motor = motors.max_force.knee.left(index) * vector_motor/norm(vector_motor);
        vector_lever = (motors.trajectories.knee.left.thigh(:,index) - dataset.trajectories.joints.left.knee  )/ 1000;
        motors.max_torque.knee.left(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));
        
        vector_motor = motors.trajectories.knee.right.shang(:,index) - motors.trajectories.knee.right.thigh(:,index);
        vector_motor = motors.max_force.knee.right(index) * vector_motor/norm(vector_motor);
        vector_lever = (motors.trajectories.knee.right.thigh(:,index) - dataset.trajectories.joints.right.knee  )/ 1000;
        motors.max_torque.knee.right(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));

    end;
    
    %% Ankle motor
    if (motors.enable.ankle)
        
        % Motor joint coordinates
        motors.trajectories.ankle.left.shang(:,index)   = T_Hip_to_Ankle_Left * [motors.parameters.ankle.shang; 0 ; 1];
        motors.trajectories.ankle.right.shang(:,index)  = T_Hip_to_Ankle_Right * [motors.parameters.ankle.shang ; 0 ; 1];
        motors.trajectories.ankle.left.foot(:,index)    = T_Hip_to_Foot_Left * [motors.parameters.ankle.foot ; 0 ; 1];
        motors.trajectories.ankle.right.foot(:,index)   = T_Hip_to_Foot_Right * [motors.parameters.ankle.foot ; 0 ; 1];
        
                
        % Distance between attachment points
        motors.length.ankle.left(index)                 = norm (motors.trajectories.ankle.left.shang(:,index) - motors.trajectories.ankle.left.foot(:,index));
        motors.length.ankle.right(index)                = norm (motors.trajectories.ankle.right.shang(:,index) - motors.trajectories.ankle.right.foot(:,index));
        
        % Motor maximal force and motor state
        [Force, State] = motors.parameters.ankle.reference(motors.length.ankle.left(index), motors.parameters.ankle.offset);
        motors.max_force.ankle.left(index) = Force;
        motors.state.ankle.left(index) = State;
        
        [Force, State] = motors.parameters.ankle.reference(motors.length.ankle.right(index), motors.parameters.ankle.offset);
        motors.max_force.ankle.right(index) = Force;
        motors.state.ankle.right(index) = State;
        
                
        % Compute maximum available torque
        vector_motor = motors.trajectories.ankle.left.foot(:,index) - motors.trajectories.ankle.left.shang(:,index);
        vector_motor = motors.max_force.ankle.left(index) * vector_motor/norm(vector_motor);
        vector_lever = (motors.trajectories.ankle.left.foot(:,index) - dataset.trajectories.joints.left.ankle  )/ 1000;
        motors.max_torque.ankle.left(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));
        
        vector_motor = motors.trajectories.ankle.right.foot(:,index) - motors.trajectories.ankle.right.shang(:,index);
        vector_motor = motors.max_force.ankle.right(index) * vector_motor/norm(vector_motor);
        vector_lever = (motors.trajectories.ankle.right.foot(:,index) - dataset.trajectories.joints.right.knee  )/ 1000;
        motors.max_torque.ankle.right(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));

    end;
    
    %% Hip-knee motor (biarticular)
    if (motors.enable.hip_knee)
        
        % Motor joint coordinates
        motors.trajectories.hip_knee.left.trunk(:,index)    = [motors.parameters.hip_knee.trunk; 0 ; 1];
        motors.trajectories.hip_knee.right.trunk(:,index)   = [motors.parameters.hip_knee.trunk ; 0 ; 1];
        motors.trajectories.hip_knee.left.shang(:,index)    = T_Hip_to_Ankle_Left * [motors.parameters.hip_knee.shang; 0 ; 1];
        motors.trajectories.hip_knee.right.shang(:,index)   = T_Hip_to_Ankle_Right * [motors.parameters.hip_knee.shang ; 0 ; 1];
        
                
        % Distance between attachment points
        motors.length.hip_knee.left(index)                  = norm (motors.trajectories.hip_knee.left.trunk(:,index) - motors.trajectories.hip_knee.left.shang(:,index));
        motors.length.hip_knee.right(index)                 = norm (motors.trajectories.hip_knee.right.trunk(:,index) - motors.trajectories.hip_knee.right.shang(:,index));
        
        % Motor maximal force and motor state
        [Force, State] = motors.parameters.hip_knee.reference(motors.length.hip_knee.left(index), motors.parameters.hip_knee.offset);
        motors.max_force.hip_knee.left(index) = Force;
        motors.state.hip_knee.left(index) = State;
        
        [Force, State] = motors.parameters.hip_knee.reference(motors.length.hip_knee.right(index), motors.parameters.hip_knee.offset);
        motors.max_force.hip_knee.right(index) = Force;
        motors.state.hip_knee.right(index) = State;
        
        % Compute maximum available torque on hip and knee
        vector_motor = motors.trajectories.hip_knee.left.shang(:,index) - motors.trajectories.hip_knee.left.trunk(:,index);
        vector_motor = motors.max_force.hip_knee.left(index) * vector_motor/norm(vector_motor);
        % Left hip
        vector_lever = (motors.trajectories.hip_knee.left.trunk(:,index) - [0; 0; 0 ;1] )/ 1000;
        motors.max_torque.hip_knee.hip.left(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));
        % Left knee
        vector_lever = (motors.trajectories.hip_knee.left.shang(:,index) - dataset.trajectories.joints.left.knee  )/ 1000;
        motors.max_torque.hip_knee.knee.left(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));
        
        vector_motor = motors.trajectories.hip_knee.right.shang(:,index) - motors.trajectories.hip_knee.right.trunk(:,index);
        vector_motor = motors.max_force.hip_knee.right(index) * vector_motor/norm(vector_motor);
        % Right hip
        vector_lever = (motors.trajectories.hip_knee.right.trunk(:,index) - [0; 0; 0 ;1] )/ 1000;
        motors.max_torque.hip_knee.hip.right(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));
        % Right knee
        vector_lever = (motors.trajectories.hip_knee.right.shang(:,index) - dataset.trajectories.joints.right.knee  )/ 1000;
        motors.max_torque.hip_knee.knee.right(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));


        
       
    end;
    
    %% Knee-ankle motor (biarticular)
    if (motors.enable.knee_ankle)
        
        % Motor joint coordinates
        motors.trajectories.knee_ankle.left.thigh(:,index)   = T_Hip_to_Knee_Left * [motors.parameters.knee_ankle.thigh; 0 ; 1];
        motors.trajectories.knee_ankle.right.thigh(:,index)  = T_Hip_to_Knee_Right * [motors.parameters.knee_ankle.thigh ; 0 ; 1];
        motors.trajectories.knee_ankle.left.foot(:,index)    = T_Hip_to_Foot_Left * [motors.parameters.knee_ankle.foot; 0 ; 1];
        motors.trajectories.knee_ankle.right.foot(:,index)   = T_Hip_to_Foot_Right * [motors.parameters.knee_ankle.foot ; 0 ; 1];
        
                
        % Distance between attachment points
        motors.length.knee_ankle.left(index)                 = norm (motors.trajectories.knee_ankle.left.thigh(:,index) - motors.trajectories.knee_ankle.left.foot(:,index));
        motors.length.knee_ankle.right(index)                = norm (motors.trajectories.knee_ankle.right.thigh(:,index) - motors.trajectories.knee_ankle.right.foot(:,index));
        
        % Motor maximal force and motor state
        [Force, State] = motors.parameters.knee_ankle.reference(motors.length.knee_ankle.left(index), motors.parameters.knee_ankle.offset);
        motors.max_force.knee_ankle.left(index) = Force;
        motors.state.knee_ankle.left(index) = State;
        
        [Force, State] = motors.parameters.knee_ankle.reference(motors.length.knee_ankle.right(index), motors.parameters.knee_ankle.offset);
        motors.max_force.knee_ankle.right(index) = Force;
        motors.state.knee_ankle.right(index) = State;
        
        % Compute maximum available torque on knee and ankle
        vector_motor = motors.trajectories.knee_ankle.left.thigh(:,index) - motors.trajectories.knee_ankle.left.foot(:,index);
        vector_motor = motors.max_force.knee_ankle.left(index) * vector_motor/norm(vector_motor);
        % Left knee
        vector_lever = (motors.trajectories.knee_ankle.left.thigh(:,index) - dataset.trajectories.joints.left.knee )/ 1000;
        motors.max_torque.knee_ankle.knee.left(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));
        % Left foot
        vector_lever = (motors.trajectories.knee_ankle.left.foot(:,index) - dataset.trajectories.joints.left.ankle  )/ 1000;
        motors.max_torque.knee_ankle.ankle.left(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));
        
        % Compute maximum available torque on knee and ankle
        vector_motor = motors.trajectories.knee_ankle.right.thigh(:,index) - motors.trajectories.knee_ankle.right.foot(:,index);
        vector_motor = motors.max_force.knee_ankle.right(index) * vector_motor/norm(vector_motor);
        % Right knee
        vector_lever = (motors.trajectories.knee_ankle.right.thigh(:,index) - dataset.trajectories.joints.right.knee  )/ 1000;
        motors.max_torque.knee_ankle.knee.right(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));
        % Right foot
        vector_lever = (motors.trajectories.knee_ankle.right.foot(:,index) - dataset.trajectories.joints.right.ankle  )/ 1000;
        motors.max_torque.knee_ankle.ankle.right(index) = norm (-cross (vector_motor(1:3), vector_lever(1:3)));
    end;
    
    %% Update joints
    set(fig_robot.joint.Left.Knee,    'XData', dataset.trajectories.x(3,i),   'YData', dataset.trajectories.y(3,i));
    set(fig_robot.joint.Right.Knee,   'XData', dataset.trajectories.x(4,i),   'YData', dataset.trajectories.y(4,i));
    set(fig_robot.joint.Left.Ankle,   'XData', dataset.trajectories.x(5,i),   'YData', dataset.trajectories.y(5,i));
    set(fig_robot.joint.Right.Ankle,  'XData', dataset.trajectories.x(6,i),   'YData', dataset.trajectories.y(6,i));
    set(fig_robot.joint.Left.Foot,    'XData', dataset.trajectories.x(7,i),   'YData', dataset.trajectories.y(7,i));
    set(fig_robot.joint.Right.Foot,   'XData', dataset.trajectories.x(8,i),   'YData', dataset.trajectories.y(8,i));
    
    %% Update segments
    set(fig_robot.segment.Left.Thigh,   'XData', [0, dataset.trajectories.x(3,i)],   'YData', [0, dataset.trajectories.y(3,i)]);
    set(fig_robot.segment.Right.Thigh,  'XData', [0, dataset.trajectories.x(4,i)],   'YData', [0, dataset.trajectories.y(4,i)]);
    set(fig_robot.segment.Left.Shang,   'XData', [dataset.trajectories.x(3,i), dataset.trajectories.x(5,i)],   'YData', [dataset.trajectories.y(3,i), dataset.trajectories.y(5,i)]);
    set(fig_robot.segment.Right.Shang,  'XData', [dataset.trajectories.x(4,i), dataset.trajectories.x(6,i)],   'YData', [dataset.trajectories.y(4,i), dataset.trajectories.y(6,i)]);
    set(fig_robot.segment.Left.Foot,    'XData', [dataset.trajectories.x(5,i), dataset.trajectories.x(7,i)],   'YData', [dataset.trajectories.y(5,i), dataset.trajectories.y(7,i)]);
    set(fig_robot.segment.Right.Foot,   'XData', [dataset.trajectories.x(6,i), dataset.trajectories.x(8,i)],   'YData', [dataset.trajectories.y(6,i), dataset.trajectories.y(8,i)]);
    
    %% Update motors
    if (motors.enable.hip)
        set(fig_robot.motor.Left.Hip,           'XData', [motors.trajectories.hip.left.trunk(1,index),  motors.trajectories.hip.left.thigh(1,index)]);
        set(fig_robot.motor.Left.Hip,           'YData', [motors.trajectories.hip.left.trunk(2,index),  motors.trajectories.hip.left.thigh(2,index)]);
        set(fig_robot.motor.Right.Hip,          'XData', [motors.trajectories.hip.right.trunk(1,index), motors.trajectories.hip.right.thigh(1,index)]);
        set(fig_robot.motor.Right.Hip,          'YData', [motors.trajectories.hip.right.trunk(2,index), motors.trajectories.hip.right.thigh(2,index)]);
    end;

    if (motors.enable.knee)
        set(fig_robot.motor.Left.Knee,          'XData', [motors.trajectories.knee.left.thigh(1,index),  motors.trajectories.knee.left.shang(1,index)]);
        set(fig_robot.motor.Left.Knee,          'YData', [motors.trajectories.knee.left.thigh(2,index),  motors.trajectories.knee.left.shang(2,index)]);
        set(fig_robot.motor.Right.Knee,         'XData', [motors.trajectories.knee.right.thigh(1,index), motors.trajectories.knee.right.shang(1,index)]);
        set(fig_robot.motor.Right.Knee,         'YData', [motors.trajectories.knee.right.thigh(2,index), motors.trajectories.knee.right.shang(2,index)]);
    end;

    if (motors.enable.ankle)
        set(fig_robot.motor.Left.Ankle,         'XData', [motors.trajectories.ankle.left.shang(1,index),  motors.trajectories.ankle.left.foot(1,index)]);
        set(fig_robot.motor.Left.Ankle,         'YData', [motors.trajectories.ankle.left.shang(2,index),  motors.trajectories.ankle.left.foot(2,index)]);
        set(fig_robot.motor.Right.Ankle,        'XData', [motors.trajectories.ankle.right.shang(1,index), motors.trajectories.ankle.right.foot(1,index)]);
        set(fig_robot.motor.Right.Ankle,        'YData', [motors.trajectories.ankle.right.shang(2,index), motors.trajectories.ankle.right.foot(2,index)]);
    end
    
    if (motors.enable.hip_knee)
        set(fig_robot.motor.Left.Hip_Knee,      'XData', [motors.trajectories.hip_knee.left.trunk(1,index),  motors.trajectories.hip_knee.left.shang(1,index)]);
        set(fig_robot.motor.Left.Hip_Knee,      'YData', [motors.trajectories.hip_knee.left.trunk(2,index),  motors.trajectories.hip_knee.left.shang(2,index)]);
        set(fig_robot.motor.Right.Hip_Knee,     'XData', [motors.trajectories.hip_knee.right.trunk(1,index), motors.trajectories.hip_knee.right.shang(1,index)]);
        set(fig_robot.motor.Right.Hip_Knee,     'YData', [motors.trajectories.hip_knee.right.trunk(2,index), motors.trajectories.hip_knee.right.shang(2,index)]);
    end;
    
    if (motors.enable.knee_ankle)
        set(fig_robot.motor.Left.Knee_Ankle,    'XData', [motors.trajectories.knee_ankle.left.thigh(1,index),  motors.trajectories.knee_ankle.left.foot(1,index)]);
        set(fig_robot.motor.Left.Knee_Ankle,    'YData', [motors.trajectories.knee_ankle.left.thigh(2,index),  motors.trajectories.knee_ankle.left.foot(2,index)]);
        set(fig_robot.motor.Right.Knee_Ankle,   'XData', [motors.trajectories.knee_ankle.right.thigh(1,index), motors.trajectories.knee_ankle.right.foot(1,index)]);
        set(fig_robot.motor.Right.Knee_Ankle,   'YData', [motors.trajectories.knee_ankle.right.thigh(2,index), motors.trajectories.knee_ankle.right.foot(2,index)]);
    end;
    
    title (sprintf('Step: %d | Time: %.2fs',i,i / frame_rate));  
    
    
    drawnow;
    index = index+1;
    
end

%% Plot motor length
figure; 
subplot (5,1,1); hold on; grid on;
plot (motors.length.hip.left, 'r');
plot (motors.length.hip.right, 'b');
title ('Hip motor length [mm]');

subplot (5,1,2); hold on; grid on;
plot (motors.length.knee.left, 'r');
plot (motors.length.knee.right, 'b');
title ('Knee motor length [mm]');

subplot (5,1,3); hold on; grid on;
plot (motors.length.ankle.left, 'r');
plot (motors.length.ankle.right, 'b');
title ('Ankle motor length [mm]');

subplot (5,1,4); hold on; grid on;
plot (motors.length.hip_knee.left, 'r');
plot (motors.length.hip_knee.right, 'b');
title ('Hip-knee motor length [mm]');

subplot (5,1,5); hold on; grid on;
plot (motors.length.knee_ankle.left, 'r');
plot (motors.length.knee_ankle.right, 'b');
title ('Knee-ankle motor length [mm]');



%% Plot motor max forces
figure; 
subplot (5,1,1); hold on; grid on; ylim([0 585]);
plot (motors.max_force.hip.left, 'r');
plot (motors.max_force.hip.right, 'b');
title ('Max force on hip motors [N]');

subplot (5,1,2); hold on; grid on; ylim([0 585]);
plot (motors.max_force.knee.left, 'r');
plot (motors.max_force.knee.right, 'b');
title ('Max force on knee motors [N]');

subplot (5,1,3); hold on; grid on; ylim([0 585]);
plot (motors.max_force.ankle.left, 'r');
plot (motors.max_force.ankle.right, 'b');
title ('Max force on ankle motors [N]');

subplot (5,1,4); hold on; grid on; ylim([0 585]);
plot (motors.max_force.hip_knee.left, 'r');
plot (motors.max_force.hip_knee.right, 'b');
title ('Max force on hip-knee motors [N]');

subplot (5,1,5); hold on; grid on; ylim([0 585]);
plot (motors.max_force.knee_ankle.left, 'r');
plot (motors.max_force.knee_ankle.right, 'b');
title ('Max force on knee-ankle motors [N]');



%% Plot motor states
figure; 
subplot (5,1,1); hold on; grid on; ylim([0 4]);
plot (motors.state.hip.left, 'r');
plot (motors.state.hip.right, 'b');
title ('Hip motors states');

subplot (5,1,2); hold on; grid on; ylim([0 4]);
plot (motors.state.knee.left, 'r');
plot (motors.state.knee.right, 'b');
title ('Knee motor states');

subplot (5,1,3); hold on; grid on; ylim([0 4]);
plot (motors.state.ankle.left, 'r');
plot (motors.state.ankle.right, 'b');
title ('Ankle motor states');

subplot (5,1,4); hold on; grid on; ylim([0 4]);
plot (motors.state.hip_knee.left, 'r');
plot (motors.state.hip_knee.right, 'b');
title ('Hip-knee motor states');

subplot (5,1,5); hold on; grid on; ylim([0 4]);
plot (motors.state.knee_ankle.left, 'r');
plot (motors.state.knee_ankle.right, 'b');
title ('knee-ankle motor states');



%% Plot motor max torques
figure; 
subplot (3,1,1); hold on; grid on;
plot (motors.max_torque.hip.left, 'r');
plot (motors.max_torque.hip.right, 'b');
plot (motors.max_torque.hip_knee.hip.left, 'r:');
plot (motors.max_torque.hip_knee.hip.right, 'b:');
plot (abs(dataset.torques.q(1,1:size(motors.max_torque.hip.left,2))), 'r--');
plot (abs(dataset.torques.q(2,1:size(motors.max_torque.hip.right,2))), 'b--');
legend ('Torque mono-articular left', 'Torque mono-articular right', 'Torque bi-articular left', 'Torque bi-articular right', 'Torque required left', 'Torque required right');
title ('Max torque available on hip motors [N.m]');

subplot (3,1,2); hold on; grid on;
plot (motors.max_torque.knee.left, 'r');
plot (motors.max_torque.knee.right, 'b');
plot (motors.max_torque.hip_knee.knee.left + motors.max_torque.knee_ankle.knee.left, 'r:');
plot (motors.max_torque.hip_knee.knee.right+ motors.max_torque.knee_ankle.knee.right, 'b:');
plot (abs(dataset.torques.q(3,1:size(motors.max_torque.knee.left,2))), 'r--');
plot (abs(dataset.torques.q(4,1:size(motors.max_torque.knee.right,2))), 'b--');
title ('Max torque available for knee motors [N.m]');

subplot (3,1,3); hold on; grid on;
plot (motors.max_torque.ankle.left, 'r');
plot (motors.max_torque.ankle.right, 'b');
plot (motors.max_torque.knee_ankle.ankle.left, 'r:');
plot (motors.max_torque.knee_ankle.ankle.right, 'b:');
plot (abs(dataset.torques.q(5,1:size(motors.max_torque.ankle.left,2))), 'r--');
plot (abs(dataset.torques.q(6,1:size(motors.max_torque.ankle.right,2))), 'b--');
title ('Max torque available for ankle motors [N.m]');