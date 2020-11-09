function plot_joint_power(motors, dataset)

    subplot (3,1,1); hold on; grid on;
    plot (dataset.power.q(1,motors.start : motors.step : motors.stop), 'r');
    plot (dataset.power.q(2,motors.start : motors.step : motors.stop), 'b');
    title ('Hip joint power [W]');
    legend ('left', 'right');

    subplot (3,1,2); hold on; grid on;
    plot (dataset.power.q(3,motors.start : motors.step : motors.stop), 'r');
    plot (dataset.power.q(4,motors.start : motors.step : motors.stop), 'b');
    title ('Knee joint power [W]');
    legend ('left', 'right');

    subplot (3,1,3); hold on; grid on;
    plot (dataset.power.q(5,motors.start : motors.step : motors.stop), 'r');
    plot (dataset.power.q(6,motors.start : motors.step : motors.stop), 'b');
    title ('Ankle joint power [W]');
    legend ('left', 'right');
end

