function nPlots = plot_motor_torques(motors, dataset)

    subplot(3,1,1); hold on; grid on;
    plot (dataset.torques.q(1,motors.start : motors.step : motors.stop), 'r');
    plot (dataset.torques.q(2,motors.start : motors.step : motors.stop), 'b');
    title ('Hip required torques [N.m]');
    
	subplot(3,1,2); hold on; grid on;
    plot (dataset.torques.q(3,motors.start : motors.step : motors.stop), 'r');
    plot (dataset.torques.q(4,motors.start : motors.step : motors.stop), 'b');
    title ('Knee required torques [N.m]');
    
    subplot(3,1,3); hold on; grid on;
    plot (dataset.torques.q(5,motors.start : motors.step : motors.stop), 'r');
    plot (dataset.torques.q(6,motors.start : motors.step : motors.stop), 'b');
    title ('Ankle required torques [N.m]');
    
   
end

