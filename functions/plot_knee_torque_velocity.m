function plot_knee_torque_velocity(motors, dataset)

    
    
    subplot(3,1,1); hold on; grid on;
    plot (dataset.power.q(3,motors.start : motors.step : motors.stop), 'k');
    title ('Torque')
    subplot(3,1,2); hold on; grid on;
    plot (dataset.trajectories.dqdt(3,motors.start : motors.step : motors.stop), 'c');
    title ("dqdt");
    subplot(3,1,3); hold on; grid on;
    plot (dataset.trajectories.q(3,motors.start : motors.step : motors.stop), 'r');
    %legend ('Torque [N.m]', 'q [rad]', 'dqdt [m/s]');
    title ('q');
    
   
end

