function nPlots = plot_motor_force(motors)

    nPlots = sum(cell2mat(struct2cell(motors.enable)));
    plotIndex = 1;
    
    if (motors.enable.hip)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.forces.hip.left, 'r');
        plot (motors.forces.hip.right, 'b');
        area(motors.max_force.hip.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(motors.max_force.hip.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.hip.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.hip.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        title ('Force produced by hip motors [N]');
        plotIndex=plotIndex+1;
    end

    if (motors.enable.knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.forces.knee.left, 'r');
        plot (motors.forces.knee.right, 'b');
        area(motors.max_force.knee.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(motors.max_force.knee.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.knee.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.knee.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        title ('Force produced by knee motors [N]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.forces.ankle.left, 'r');
        plot (motors.forces.ankle.right, 'b');
        area(motors.max_force.ankle.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(motors.max_force.ankle.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.ankle.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.ankle.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        title ('Force produced by ankle motors [N]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.hip_knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.forces.hip_knee.left, 'r');
        plot (motors.forces.hip_knee.right, 'b');
        area(motors.max_force.hip_knee.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(motors.max_force.hip_knee.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.hip_knee.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.hip_knee.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        title ('Force produced by hip-knee motors [N]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.knee_ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.forces.knee_ankle.left, 'r');
        plot (motors.forces.knee_ankle.right, 'b');
        area(motors.max_force.knee_ankle.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(motors.max_force.knee_ankle.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.knee_ankle.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.knee_ankle.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        title ('Force produced by knee-ankle motors [N]');
        plotIndex=plotIndex+1;
    end
end

