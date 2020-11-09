function nPlots = plot_motor_total_power(motors, dataset)

    %% Plot power with log-y axis
    plot (motors.power.total, 'r');
    hold on;
    plot (dataset.power.effective(motors.start : motors.step : motors.stop),'b');
    plot (dataset.power.total(motors.start : motors.step : motors.stop),'g');
    grid on;
    legend ('Absorbed power [W]', 'Effective usefull power [W]', 'Usefull power [W]');
    title ('Input vs output power [W]');
        



end

