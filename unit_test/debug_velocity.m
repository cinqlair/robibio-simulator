close all;
% figure;
% subplot (2,1,1); 
% plot (motors.length.hip.left);
% grid on;
% 
% subplot (2,1,2); hold on;
% plot (motors.velocity.hip.left);
% plot (gradient (500*motors.length.hip.left/1000), 'c--');
% %plot (motors.speed.left(5,:), 'r--');
% title ('Hip motor velocity [m/s]');
% grid on;
% 
% figure;
% subplot (2,1,1); 
% plot (motors.length.knee.left);
% grid on;
% 
% subplot (2,1,2); hold on;
% plot (motors.velocity.knee.left);
% plot (gradient (500*motors.length.knee.left/1000), 'c--');
% %plot (motors.speed.left(3,:), 'r--');
% title ('Knee motor velocity [m/s]');
% grid on;
% 
% figure;
% subplot (2,1,1); 
% plot (motors.length.ankle.left);
% grid on;
% 
% subplot (2,1,2); hold on;
% plot (motors.velocity.ankle.left);
% plot (gradient (500*motors.length.ankle.left/1000), 'c--');
% %plot (motors.speed.left(1,:), 'r--');
% title ('Ankle motor velocity [m/s]');
% grid on;

figure;
subplot (2,1,1); 
plot (motors.length.knee_ankle.left);
grid on;

subplot (2,1,2); hold on;
plot (motors.velocity.knee_ankle.left);
plot (gradient (500*motors.length.knee_ankle.left/1000), 'c--');
%plot (motors.speed.left(2,:), 'r--');
title ('Knee-ankle motor velocity [m/s]');
grid on;

figure;
subplot (2,1,1); 
plot (motors.length.hip_knee.left);
grid on;

subplot (2,1,2); hold on;
plot (motors.velocity.hip_knee.left);
plot (gradient (500*motors.length.hip_knee.left/1000), 'c--');
%plot (motors.speed.left(4,:), 'r--');
title ('Hip-knee motor velocity [m/s]');
grid on;