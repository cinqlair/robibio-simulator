function [handle] = init_figure_robot()
    
    hold on;
    
    
%% Robot joints
    
    handle.Hip                 = plot(0,0,'b.', 'MarkerSize',5);    
    handle.joint.Left.Knee     = plot(0,0,'r.', 'MarkerSize',20);
    handle.joint.Right.Knee    = plot(0,0,'b.', 'MarkerSize',20);
    handle.joint.Left.Ankle    = plot(0,0,'r.', 'MarkerSize',20);
    handle.joint.Right.Ankle   = plot(0,0,'b.', 'MarkerSize',20);
    handle.joint.Left.Foot     = plot(0,0,'r.', 'MarkerSize',20);
    handle.joint.Right.Foot    = plot(0,0,'b.', 'MarkerSize',20);
    
%% Segments    
    handle.segment.Left.Thigh   = line ([0,0], [0,0], 'Color', 'r');
    handle.segment.Right.Thigh  = line ([0,0], [0,0], 'Color', 'b');
    handle.segment.Left.Shang   = line ([0,0], [0,0], 'Color', 'r');
    handle.segment.Right.Shang  = line ([0,0], [0,0], 'Color', 'b');
    handle.segment.Left.Foot    = line ([0,0], [0,0], 'Color', 'r');
    handle.segment.Right.Foot   = line ([0,0], [0,0], 'Color', 'b');

%% Motors

    handle.motor.Left.Hip           = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [1,0,0,0.2], 'Marker', '.');
    handle.motor.Right.Hip          = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0,0,1,0.2], 'Marker', '.');
    handle.motor.Left.Knee          = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [1,0,0,0.2], 'Marker', '.');
    handle.motor.Right.Knee         = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0,0,1,0.2], 'Marker', '.');
    handle.motor.Left.Ankle         = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [1,0,0,0.2], 'Marker', '.');
    handle.motor.Right.Ankle        = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0,0,1,0.2], 'Marker', '.');
    handle.motor.Left.Hip_Knee      = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [1,0,0,0.2], 'Marker', '.');
    handle.motor.Right.Hip_Knee     = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0,0,1,0.2], 'Marker', '.');
    handle.motor.Left.Knee_Ankle    = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [1,0,0,0.2], 'Marker', '.');
    handle.motor.Right.Knee_Ankle   = line ([0,0], [0,0], 'LineWidth', 3, 'Color', [0,0,1,0.2], 'Marker', '.');
    
%% Torques   

    handle.torque.Left.Knee     = plot(0,0,'ro', 'MarkerSize',0.1);    
    handle.torque.Right.Knee    = plot(0,0,'bo', 'MarkerSize',0.1);
    handle.torque.Left.Ankle    = plot(0,0,'ro', 'MarkerSize',0.1);
    handle.torque.Right.Ankle   = plot(0,0,'bo', 'MarkerSize',0.1);
    handle.torque.Left.Foot     = plot(0,0,'ro', 'MarkerSize',0.1);
    handle.torque.Right.Foot    = plot(0,0,'bo', 'MarkerSize',0.1);
    
    axis square equal;
    grid on;
    axis([-1000, 1000, -1000, 400]);
    set(gca,'XAxisLocation','bottom','YAxisLocation','left');
    xlabel ('X');
    ylabel ('Y');   
    
end

