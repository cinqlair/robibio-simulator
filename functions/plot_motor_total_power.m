function nPlots = plot_motor_total_power(motors, dataset)

    %% Plot power with log-y axis
    semilogy (motors.power.total);
    hold on;
    semilogy (dataset.power.total(motors.start : motors.step : motors.stop));
    grid on;
    legend ('Input power [W]', 'Output power [W]');
    title ('Input vs output power [W]');
        



end

