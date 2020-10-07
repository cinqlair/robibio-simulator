function nPlots = plot_motor_optim_residual(motors)

    subplot (2,1,1); hold on; grid on; ylim([0,2]);
    plot (motors.feasable, 'k');
    title ('Feasability');

    subplot (2,1,2); hold on; grid on;
    plot (motors.status.left(1,:), 'r');
    plot (motors.status.right(1,:), 'b');
    title ('Squared 2-norm of the residual ');

end

