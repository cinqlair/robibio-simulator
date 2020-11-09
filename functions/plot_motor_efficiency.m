function nPlots = plot_motor_efficiency(motors, dataset)


    power_motion = dataset.power.effective(motors.start : motors.step : motors.stop);
    %power_motor = motors.power.total;
    
    subplot (2,1,1); hold on; % ylim([0,1]); 
    plot(motors.efficiency, 'b:');
    plot(max(0,motors.efficiency), 'b');
    grid on;
    title ('Efficiency');
    
    subplot (2,1,2);  
    plot (motors.power.input);
    hold on;
    plot (motors.power.output, '--r');
    grid on;
    legend ('Input power [W]', 'Output power [W]');
    title ('Powers [W]');

end

