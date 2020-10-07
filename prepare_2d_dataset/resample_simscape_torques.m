clear all;
close all;
clc;

%% ------------Load torques----------

%fileId = '1.1'
fileId = '1.2'
%fileId = '1.3'
%fileId = '2.1'
%fileId = '2.2'
%fileId = '2.3'
%fileId = '4'
%fileId = '5.1'
%fileId = '5.2'
simscape_torques = load(sprintf ('../dataset/simscape-torques/%s_S_Torques.mat', fileId));
newton_euler_torques = load(sprintf('../dataset/newton-euler-torques/%s_Torques.mat', fileId));



%% ------------compute resample----------

%size (newton_euler_torques.NE_Torques.torques_with_computed_grf, 2)
timevec = 0:1/500:simscape_torques.Simscape_Torques.Time(end);
%time_ne = 0:1/500:simscape_torques.Simscape_Torques.Time(end);
%time_sc = (0:1/500:simscape_torques.Simscape_Torques.Time(end))+0.002;

for articulation=1:length(simscape_torques.Simscape_Torques.Label)
    current_ts = timeseries(simscape_torques.Simscape_Torques.smoothed(articulation,:),simscape_torques.Simscape_Torques.Time);
    current_resampled = resample(current_ts, timevec);
    torque_resampled(articulation,:) = current_resampled.Data;
end

%% ------------saving results----------

%save ('output_resampled_1.2','motion','meta','ground','events','force','muscle','torque', '-v7.3');

joints = [25,28,29,30,33,36];
joints_label = {'Hip left', 'Hip right', 'Knee left', 'Knee right', 'Ankle left', 'Ankle right'};
for i=1:numel(joints)
    
    figure; 
    
    subplot (2,1,1); hold on;
    
    title (joints_label(i));
    plot (timevec, torque_resampled(joints(i),:),'-');
    plot (timevec, newton_euler_torques.NE_Torques.filtered_torques(joints(i),:),'-');
    plot (timevec, newton_euler_torques.NE_Torques.torques_with_computed_grf(joints(i),:),'-');
    
    grid on;
    legend ('Torque - Simscape', 'Torque - NE filtered', 'Torque - Newton-Euler');

    subplot (2,1,2); hold on;
    plot (timevec, torque_resampled(joints(i),:) - newton_euler_torques.NE_Torques.torques_with_computed_grf(joints(i),:) );
    grid on;
    legend ('Difference (Simscape - Newton-Euler)');
end

save (sprintf ('../dataset/simscape-torques-resampled/%s_S_Torques.mat', fileId) ,'torque_resampled');