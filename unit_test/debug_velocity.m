close all;
figure;
subplot (2,1,1); 
plot (motors.length.hip_knee.left);
grid on;

subplot (2,1,2); hold on;
plot (motors.velocity.hip_knee.left);
plot (gradient (500*motors.length.hip_knee.left/1000), '.');
grid on;