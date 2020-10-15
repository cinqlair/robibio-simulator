function nPlots = plot_motor_efficiency(motors, dataset)


    power_motion = dataset.power.effective(motors.start : motors.step : motors.stop);
    power_motor = motors.power.total;
    
    subplot (2,1,1); hold on; % ylim([0,1]); 
    plot(motors.efficiency, 'b:');
    grid on;
    title ('Efficiency');
    
    subplot (2,1,2);  
    plot (power_motor);
    hold on;
    plot (power_motion, '--r');
    grid on;
    legend ('Cumulated motors power', 'Cumulated torques power');
    title ('Powers [W]');

end

