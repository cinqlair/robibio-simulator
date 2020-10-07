function nPlots = plot_motor_efficiency(motors, dataset)


    power_motion = dataset.power.total(motors.start : motors.step : motors.stop);
    power_motor = sum (motors.power.left) + sum (motors.power.right);
    
    subplot (2,1,1);   %ylim([0,1]);
    semilogy ((power_motion ./ power_motor) .* motors.feasable, 'b');
    hold on; 
    semilogy(motors.efficiency, 'b:');
    grid on;
    title ('Efficiency');
    
    subplot (2,1,2);  
    semilogy(power_motor);
    hold on;
    semilogy (power_motion);
    grid on;
    legend ('Cumulated motors power', 'Cumulated torques power');
    title ('Powers [W]');

end

