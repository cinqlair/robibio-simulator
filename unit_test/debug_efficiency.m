clear torque;
close all;
clc;


% Compute vector motor
vec_motor = motors.trajectories.hip.left.thigh-motors.trajectories.hip.left.trunk;


%% Check motor length

motor_length = vecnorm(vec_motor(1:3,:))/1000;
motor_velocity = gradient(motor_length)*dataset.frame_rate;

figure; 
subplot (2,1,1); hold on;
plot (motors.length.hip.left/1000);
plot (motor_length, 'r--');
title ('Hip motor length [m]');
grid on;

subplot (2,1,2); hold on;
title ('Hip motor velocity [m/s]');
plot (motor_velocity);
plot (motors.velocity.hip.left, 'r--');
grid on;




%% Check force

% Compute motor force vector 
vec_force = motors.forces.hip.left .* vec_motor ./vecnorm(vec_motor);
vec_force = vec_force(1:3,:);

% Compute lever arm vector
vec_lever = motors.trajectories.hip.left.thigh(1:3,:)/1000;


for i=1:size(vec_force,2)
    torque(i,:) = cross(vec_lever(:,i), vec_force(:,i));
end
torque = transpose(torque(:,3))

figure; hold on;
plot (torque);
plot (dataset.torques.q(1,motors.start : motors.step : motors.stop), 'r--');
grid on;
title ('Hip motor force [N]');


%% Check motor power
figure; 
subplot(2,1,1); hold on; grid on;
plot (abs(motors.forces.hip.left .* motors.velocity.hip.left));
plot (dataset.power.q(1,motors.start : motors.step : motors.stop), 'r--');
plot (motors.power.hip.left, 'k.');
title ('Hip motor power [W]');

subplot(2,1,2); hold on; grid on;
Pu = dataset.power.q(1,motors.start : motors.step : motors.stop);
Pa = motors.power.hip.left;
plot (Pu./Pa);






