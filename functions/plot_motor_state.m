function nPlots = plot_motor_state(motors)

    nPlots = sum(cell2mat(struct2cell(motors.enable)));
    plotIndex = 1;
    
    if (motors.enable.hip)
        subplot (nPlots,1,plotIndex); hold on; grid on; ylim([0 4]);
        plot (motors.state.hip.left, 'r');
        plot (motors.state.hip.right, 'b');
        title ('Hip motors states');
        plotIndex=plotIndex+1;
    end

    if (motors.enable.knee)
        subplot (nPlots,1,plotIndex); hold on; grid on; ylim([0 4]);
        plot (motors.state.knee.left, 'r');
        plot (motors.state.knee.right, 'b');
        title ('Knee motor states');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on; ylim([0 4]);
        plot (motors.state.ankle.left, 'r');
        plot (motors.state.ankle.right, 'b');
        title ('Ankle motor states');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.hip_knee)
        subplot (nPlots,1,plotIndex); hold on; grid on; ylim([0 4]);
        plot (motors.state.hip_knee.left, 'r');
        plot (motors.state.hip_knee.right, 'b');
        title ('Hip-knee motor states');

        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.knee_ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on; ylim([0 4]);
        plot (motors.state.knee_ankle.left, 'r');
        plot (motors.state.knee_ankle.right, 'b');
        title ('knee-ankle motor states');
        plotIndex=plotIndex+1;
    end
end

