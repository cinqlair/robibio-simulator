function nPlots = plot_motor_power(motors)

    nPlots = sum(cell2mat(struct2cell(motors.enable)));
    plotIndex = 1;
    
    if (motors.enable.hip)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.power.hip.left, 'r');
        plot (motors.power.hip.right, 'b');
        title ('Hip power [W]');
        plotIndex=plotIndex+1;
    end

    if (motors.enable.knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.power.knee.left, 'r');
        plot (motors.power.knee.right, 'b');
        title ('Knee power [W]');
        plotIndex=plotIndex+1;
    end        
  
    if (motors.enable.ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.power.ankle.left, 'r');
        plot (motors.power.ankle.right, 'b');
        title ('Ankle power [W]');
        plotIndex=plotIndex+1;
    end
        
    if (motors.enable.hip_knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.power.hip_knee.left, 'r');
        plot (motors.power.hip_knee.right, 'b');
        title ('Hip-knee power [W]');
        plotIndex=plotIndex+1;
    end
    
    
    if (motors.enable.knee_ankle)        
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.power.knee_ankle.left, 'r');
        plot (motors.power.knee_ankle.right, 'b');
        title ('Knee-ankle power [W]');
        plotIndex=plotIndex+1;
    end

end

