close all;
clear all;
clc;

dh = 0.5;
dk =-0.7;
da = 0.5;

a=[ -pi: 0.01 : pi ];
x=0.1*cos(a);
y=0.1*sin(a);

for i=1:size(a,2)
    v_la = [x(i);y(i);0];
    v_mo = [x(i);0.3-y(i);0];
    v_mo = 585 * v_mo/norm(v_mo);
    T = cross ( v_la , v_mo );
    torque(i) = T(3);
end
% plot (x,y, '.');
% hold on; grid on;
% plot (x,-0.3+y, 'r.');
% axis square equal;
% return;



%% 1.1 Straight walking at 1.0 m/s
ds_11  =load ('../dataset/robibio/1.1.mat', 'dataset');
ds_12  = load ('../dataset/robibio/1.2.mat', 'dataset');
ds_13  = load ('../dataset/robibio/1.3.mat', 'dataset');
ds_21  = load ('../dataset/robibio/2.1.mat', 'dataset');
ds_22  = load ('../dataset/robibio/2.2.mat', 'dataset');
ds_23  = load ('../dataset/robibio/2.3.mat', 'dataset');
ds_3   = load ('../dataset/robibio/3.mat', 'dataset');
ds_4   = load ('../dataset/robibio/4.mat', 'dataset');
ds_51  = load ('../dataset/robibio/5.1.mat', 'dataset');
ds_52  = load ('../dataset/robibio/5.2.mat', 'dataset');
ds_6   = load ('../dataset/robibio/6.mat', 'dataset');


scatterSize = 2;


%% Hip
figure; hold on;
% scatter (reshape(ds_11.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_11.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_12.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_12.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_13.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_13.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_21.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_21.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_22.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_22.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
%scatter (reshape(ds_23.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_23.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_3.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_3.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_4.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_4.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_51.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_51.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_52.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_52.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_6.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_6.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
area (a+dh, torque, 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
area (a+dh, 2*torque, 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);

grid on;
xlabel('q [rad]');
ylabel('\Gamma [N.m]');
legend ('2.1', '2.2', '1 motor', '2 motors');
alpha(.2);
title ('\Gamma=f(q) [Hip]');


%% Knee
figure; hold on;
% scatter (reshape(ds_11.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_11.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_12.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_12.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_13.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_13.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_21.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_21.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_22.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_22.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
%scatter (reshape(ds_23.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_23.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_3.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_3.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_4.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_4.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_51.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_51.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_52.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_52.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_6.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_6.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
area (a+dk, torque, 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
area (a+dk, 2*torque, 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);
area (a+dk, 3*torque, 'FaceColor','y','FaceAlpha',.1,'EdgeAlpha',.2);


alpha(.2);
legend ('2.1', '2.2', '1 motor', '2 motors', '3 motors');
grid on;
xlabel('q [rad]');
ylabel('\Gamma [N.m]');
title ('\Gamma=f(q) [Knee]');

%% Ankle
figure; hold on;
% scatter (reshape(ds_11.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_11.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_12.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_12.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_13.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_13.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_21.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_21.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_22.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_22.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
%scatter (reshape(ds_23.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_23.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_3.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_3.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_4.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_4.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_51.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_51.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_52.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_52.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
% scatter (reshape(ds_6.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_6.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
area (a+da, torque, 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
area (a+da, 2*torque, 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);

alpha(.2);
legend ('2.1', '2.2', '1 motor', '2 motors');
grid on;
xlabel('q [rad]');
ylabel('\Gamma [N.m]');
title ('\Gamma=f(q) [Ankle]');