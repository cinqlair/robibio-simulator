close all;
clear all;
clc;

%% 1.1 Straight walking at 1.0 m/s
ds_11 = load ('../dataset/robibio/1.1.mat', 'dataset');
ds_12 = load ('../dataset/robibio/1.2.mat', 'dataset');
ds_13 = load ('../dataset/robibio/1.3.mat', 'dataset');
ds_21 = load ('../dataset/robibio/2.1.mat', 'dataset');
ds_22 = load ('../dataset/robibio/2.2.mat', 'dataset');
ds_23 = load ('../dataset/robibio/2.3.mat', 'dataset');
ds_3 = load ('../dataset/robibio/3.mat', 'dataset');
ds_4 = load ('../dataset/robibio/4.mat', 'dataset');
ds_51 = load ('../dataset/robibio/5.1.mat', 'dataset');
ds_52 = load ('../dataset/robibio/5.2.mat', 'dataset');
ds_6 = load ('../dataset/robibio/6.mat', 'dataset');


scatterSize = 7;


%% Hip
figure; hold on;
scatter (reshape(ds_11.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_11.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_12.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_12.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_13.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_13.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_21.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_21.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_22.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_22.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_23.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_23.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_3.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_3.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_4.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_4.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_51.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_51.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_52.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_52.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_6.dataset.trajectories.q(1:2,:),1,[]) , abs(reshape(ds_6.dataset.torques.q(1:2,:), 1, [])),'filled','SizeData',scatterSize);

alpha(.02);
%grid on;
xlabel('q [rad]');
ylabel('\Gamma [N.m]');
title ('\Gamma=f(q) [Hip]');


%% Knee
figure; hold on;
scatter (reshape(ds_11.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_11.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_12.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_12.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_13.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_13.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_21.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_21.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_22.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_22.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_23.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_23.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_3.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_3.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_4.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_4.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_51.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_51.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_52.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_52.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_6.dataset.trajectories.q(3:4,:),1,[]) , abs(reshape(ds_6.dataset.torques.q(3:4,:), 1, [])),'filled','SizeData',scatterSize);

alpha(.02);
%grid on;
xlabel('q [rad]');
ylabel('\Gamma [N.m]');
title ('\Gamma=f(q) [Knee]');

%% Ankle
figure; hold on;
scatter (reshape(ds_11.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_11.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_12.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_12.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_13.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_13.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_21.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_21.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_22.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_22.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_23.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_23.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_3.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_3.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_4.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_4.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_51.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_51.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_52.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_52.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);
scatter (reshape(ds_6.dataset.trajectories.q(5:6,:),1,[]) , abs(reshape(ds_6.dataset.torques.q(5:6,:), 1, [])),'filled','SizeData',scatterSize);

alpha(.02);
%grid on;
xlabel('q [rad]');
ylabel('\Gamma [N.m]');
title ('\Gamma=f(q) [Ankle]');